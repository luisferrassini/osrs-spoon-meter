class DropRateSourceStrategy
  def fetch_drop_rate_from_item_name
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end
