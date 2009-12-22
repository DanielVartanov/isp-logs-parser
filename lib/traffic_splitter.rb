class TrafficSplitter
  def self.split_traffic!(traffic)
    {
      :internal => {
        :daily => traffic.daily.internal.highest_ten_hosts,
        :nightly => traffic.nightly.internal.highest_ten_hosts,
      },

      :world => {
        :daily => traffic.daily.world.highest_ten_hosts,
        :nightly => traffic.nightly.world.highest_ten_hosts,
      }
    }
  end
end