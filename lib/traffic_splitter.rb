class TrafficSplitter < Struct.new(:local_address)
  def split_traffic!(traffic)
    {
      :internal => {
        :daily => traffic.internal.daily.highest_ten_hosts,
        :nightly => traffic.internal.nightly.highest_ten_hosts,
      },

      :world => {
        :daily => traffic.world.daily.highest_ten_hosts,
        :nightly => traffic.world.nightly.highest_ten_hosts,
      }
    }
  end
end