class Record < Struct.new(:source_address, :destination_address, :bytes, 
                    :source_port, :destination_port, :transferred_at)

  def daily?
    day_bounds.member? transferred_at
  end

  def nightly?
    ! daily?
  end
  
protected

  def day_bounds
    day_start = Time.mktime transferred_at.year, transferred_at.month, transferred_at.day, 8, 00
    day_end = Time.mktime transferred_at.year, transferred_at.month, transferred_at.day, 23, 59

    day_start..day_end
  end
end