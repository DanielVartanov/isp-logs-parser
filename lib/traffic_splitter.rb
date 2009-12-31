class TrafficSplitter
  def self.split_traffic!(traffic)
    hosts = traffic.daily.internal.highest_five_hosts +
      traffic.nightly.internal.highest_five_hosts +
      traffic.daily.world.highest_five_hosts +
      traffic.nightly.world.highest_five_hosts

    hosts.sort { |left, right| right.amount_of_traffic <=> left.amount_of_traffic }
  end
end