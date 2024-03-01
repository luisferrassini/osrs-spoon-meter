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

    parsed_html.at('.item-drops').search('tr').each do |tr|
      tr.search('span[data-drop-oneover]').each do |x|
        name = tr.search('td')[0].text || tr.search('td')[1].text # Sometimes it is the second element on the table
        src = { 'Name': name,
                'Rarity': sanitize_value(x['data-drop-oneover']),
                'UnsanitizedText': x.text,
                'WikiElement': {
                  'data-drop-percent': x['data-drop-percent'],
                  'title': x['title'],
                  'data-drop-permil': x['data-drop-permil'],
                  'data-drop-fraction': x['data-drop-fraction'],
                  'data-drop-permyriad': x['data-drop-permyriad'],
                  'data-drop-oneover': x['data-drop-oneover']
                } }
        sources << src
      end
    end

    sources
  rescue StandardError => e
    puts "Nokogiri parsing failed: #{e.message}"
    []
  end

  def sanitize_value(value)
    value.gsub(/[ ,]/, '').gsub(/\[[^\]]*\]/, '').gsub(/×/, '*').gsub('Always', '1/1').gsub('/', '.0/')
  end
end
