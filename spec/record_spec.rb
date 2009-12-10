require File.join(File.dirname(__FILE__), 'spec_helper')

module RecordSpecHelper
  def record_transferred_at(time_string)
    record = Record.new
    record.transferred_at = Time.parse(time_string)
    record
  end
end

describe Record do
  include RecordSpecHelper
  
  describe "when record is created within 8:00AM and 23:59PM" do
    before :each do
      @records = [record_transferred_at('8:00'),
                  record_transferred_at('14:30'),
                  record_transferred_at('23:59')]
    end
    
    it "should be daily" do
      @records.each do |record|
	record.should be_daily
      end
    end
    
    it "should not be nightly" do
      @records.each do |record|
	record.should_not be_nightly
      end
    end
  end

  describe "when record is created within midnight and 7:59PM" do
    before :each do
      @records = [record_transferred_at('00:00'),
                  record_transferred_at('2:45'),
                  record_transferred_at('7:59')]
    end
    
    it "should not be daily" do
      @records.each do |record|
	record.should_not be_daily
      end
    end

    it "should not be nightly" do
      @records.each do |record|
	record.should be_nightly
      end
    end
  end
end