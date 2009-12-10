require 'ipaddr'

class InternalIPRanges
  RANGES = {
    'Elcat/HomeLine' => [IPAddr.new('77.95.56.0/21'),
			IPAddr.new('94.143.192.0/21'), 
			IPAddr.new('212.42.96.0/19')],

    'NetCom/MegaLine' => [IPAddr.new('77.235.0.0/19'),
			  IPAddr.new('92.245.96.0/19')], 

    'COMINTECH/KRSU/ISTC/IKIT/AlaTV' => [IPAddr.new('81.20.16.0/20')],

    'Transfer' => [IPAddr.new('81.88.192.0/20')],

    'MegaCom' => [IPAddr.new('85.26.220.0/22')],

    'AkNet' => [IPAddr.new('212.112.96.0/19')],

    'KTNet/Jet' => [IPAddr.new('85.113.0.0/19'),
		    IPAddr.new('89.237.192.0/18'),
		    IPAddr.new('212.97.0.0/19'),
		    IPAddr.new('212.241.0.0/19'),
		    IPAddr.new('213.145.128.0/19')],

    'TOTEL' => [IPAddr.new('85.115.192.0/19')],

    'SkyMobile/BeeLine' => [IPAddr.new('194.176.111.0/24')],

    'FastNet' => [IPAddr.new('91.205.48.0/22'),
		  IPAddr.new('95.215.244.0/22')],

    'BiSky' => [IPAddr.new('91.207.96.0/23')],

    'SaimaNet' => [IPAddr.new('217.29.16.0/20')],

    'NurTelecom' => [IPAddr.new('194.152.36.0/23')],

    'AsiaInfo/OneLine' => [IPAddr.new('195.38.160.0/19')],

    'CityTelecom' => [IPAddr.new('212.2.224.0/19')]
  }

  def self.include?(ip_address)
    ip_address = IPAddr.new(ip_address)

    RANGES.each_value.any? do |range_array|
      range_array.any? { |range| range.include?(ip_address) }
    end
  end
end