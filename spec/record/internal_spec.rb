require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Record do
  before :each do
    @local_address = '77.235.14.2' # Megaline gateway
    @internal_address = '213.145.129.19' # KTNet DNS server
    @world_address = '8.8.8.8' # Google DNS server
  end
  
  describe "when one of addresses belongs to world network" do
    before :each do
      @records = [Record.new(@local_address, @world_address),
                  Record.new(@world_address, @local_address)]
    end
    
    it "should be world" do
      @records.each { |record| record.should be_world }
    end
    
    it "should not be internal" do
      @records.each { |record| record.should_not be_internal }
    end
  end
  
  describe "when both, source and destination, belong to internal network" do
    before :each do
      @records = [Record.new(@local_address, @internal_address),
                  Record.new(@internal_address, @local_address)]
    end
    
    it "should be internal" do
      @records.each { |record| record.should be_internal }
    end
    
    it "should not be world" do
      @records.each { |record| record.should_not be_world }
    end
  end
end