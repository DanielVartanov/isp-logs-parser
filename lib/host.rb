class Host < Struct.new(:address, :records)
  def amount_of_traffic
    summ = 0
    records.each do |record|
      summ += record.bytes
    end
    summ
  end
end