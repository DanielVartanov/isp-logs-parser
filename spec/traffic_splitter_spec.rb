require File.join(File.dirname(__FILE__), 'spec_helper')

module TrafficSpecHelper
  def internal_daily_traffic
    Record.new @local_address, @internal_address, 
  end

  def internal_nightly_traffic
  end

  def world_daily_traffic
  end

  def world_nightly_traffic
  end
end

describe TrafficSplitter do
  before :each do
    @local_address = '212.112.96.1'
    @internal_address = '212.112.1.1'
    @world_address = '8.8.8.8'
    
    @traffic_splitter = TrafficSplitter.new(@local_address)
  end
  
  include TrafficSpecHelper

  describe "given a bunch of records of all types" do
    before :each do
      @records = []

      # TODO: 15 записей нужны только для проверки одного теста
      # Для остальных нужно сузить и проверять нормально, тестовыми данными, а не выполняя алгоритмы реализации
      
      15.times { |number| @record << internal_daily_traffic }
      15.times { |number| @record << internal_nightly_traffic }
      15.times { |number| @record << world_daily_traffic }
      15.times { |number| @record << world_nightly_traffic }
    end

    describe "when #split_traffic! is called" do
      before :each do
	@results = @traffic_splitter.split_traffic!(@records)
      end

      it "should create a two-dimensional hash" do
	@results.keys.should == [:internal, :world]
	@results[:internal].keys.should == [:daily, :nightly]
	@results[:world].keys.should == [:daily, :nightly]
      end

      it "should put array of Host in each cell" do
	@results.each_value do |split_results|
	  split_results.each_value do |hosts|
	    hosts.should be_kind_of(Array)
	    hosts.first.should be_kind_of(Host)
	  end
	end
      end

      it "should spit records by type correctly" do
	@results[:internal][:daily].each do |host|
	  host.records.each do |record|
	    record.should be_internal_relatively_to(@local_address)
	    record.should be_daily
	  end
	end
      end

      it "should sort hosts by amount of bytes" do
	hosts = @results[:internal][:daily]
	previous_host = hosts.first
	hosts[1..-1].each do |host|
	  (host.amount_of_traffic < previous_host.amount_of_traffic).should be_true
	  previous_host = host
	end
      end

      it "should leave only 10 highest hosts" do
	@results.each_value do |split_results|
	  split_results.each_value do |hosts|
	    hosts.size.should == 10
	  end
	end
      end
    end
  end
end

# Record #incoming? #daily? #local?
