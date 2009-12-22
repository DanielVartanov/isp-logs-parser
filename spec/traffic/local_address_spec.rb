require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Traffic do
  before :each do
    @local_address = '77.235.12.50'
    @facebook = '69.63.187.17'
    @gmail = '74.125.43.17'
  end

  describe "when a bunch of records are given" do
    before :each do
      @traffic = Traffic.new [
        Record.new(@local_address, @facebook),
				Record.new(@facebook, @local_address),
				Record.new(@local_address, @gmail),
      ]
    end

    it "should determine a local address" do
      @traffic.local_address.should == @local_address
    end
  end
end