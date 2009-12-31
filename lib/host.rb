class Host < Struct.new(:address, :records)
  def amount_of_traffic
    summ = 0
    records.each do |record|
      summ += record.bytes
    end
    summ
  end

  def daily?
    records.first.daily?
  end

  def internal?
    records.first.internal?
  end
end