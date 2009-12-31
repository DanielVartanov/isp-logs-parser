class TrafficSplitter
  def self.split_traffic!(traffic)
    hosts = traffic.daily.internal.highest_twenty_hosts +
      traffic.nightly.internal.highest_twenty_hosts +
      traffic.daily.world.highest_twenty_hosts +
      traffic.nightly.world.highest_twenty_hosts

    hosts.sort! { |left, right| right.amount_of_traffic <=> left.amount_of_traffic }

    hosts[0..19]
  end
end