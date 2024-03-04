class DropRateWikiStrategy < DropRateSourceStrategy
  def fetch_drop_rate_from_item_name(name)
    parse_drop_rates_nokogiri(HTTParty.get(fetch_wiki_page_url(name)).body)
  end

  private

  def fetch_wiki_page_url(name)
    HTTParty.get("https://oldschool.runescape.wiki/api.php?action=opensearch&search=#{URI.encode_www_form_component(name)}&format=json&limit=20").parsed_response[3][0]
  end

  def parse_drop_rates_nokogiri(html)
    sources = []
    parsed_html = Nokogiri::HTML(html)

    parsed_html.at('.mw-page-title-main').text

    if parsed_html.at('.item-drops').nil?
      return [{
        Name: 'Guaranteed', Rarity2: '1.0/1', Rarity: 'Always'
      }]
    end

    parsed_html.at('.item-drops').search('tr').drop(1).each do |tr|
      span_elements = tr.search('span[data-drop-oneover]')
      name = tr.search('td')[0].text || tr.search('td')[1].text # Sometimes it is the second element on the table

      if span_elements.empty?
        last_value_on_row = tr.search('td').last
        sources << { Name: name,
                     Rarity2: sanitize_value(last_value_on_row.text),
                     Rarity: last_value_on_row.text,
                     Quantity: tr.search('td')[-2].text }
      else
        span_elements.each do |span_element|
          sources << { Name: name,
                       Rarity2: sanitize_value(span_element['data-drop-oneover']),
                       Rarity: span_element.text,
                       Quantity: tr.search('td')[-2].text }
        end
      end
    end

    sources
  end

  def sanitize_value(value)
    value.gsub(/[ ,]/, '').gsub(/\[[^\]]*\]/, '').gsub(/×/, '*').gsub('Always', '1/1').gsub('/', '.0/')
  end
end
