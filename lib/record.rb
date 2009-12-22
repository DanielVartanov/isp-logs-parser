class Record < Struct.new(:source_address, :destination_address, :bytes, 
                    :source_port, :destination_port, :transferred_at)

  def daily?
    @daily ||= day_bounds.member? transferred_at
  end

  def nightly?
    ! daily?
  end

  def internal?
    @internal ||= InternalIPRanges.include?(source_address) and
      InternalIPRanges.include?(destination_address)
  end

  def world?
    ! internal?
  end

protected

  def day_bounds
    day_start = on_the_day_at 8,00
    day_end = on_the_day_at 23,59

    day_start..day_end
  end

  def on_the_day_at(hours, minutes)
    Time.mktime transferred_at.year, transferred_at.month, transferred_at.day, hours, minutes
  end
end