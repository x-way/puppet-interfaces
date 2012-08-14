require 'spec_helper'

describe 'interfaces::iface' do
  let(:title) { 'lo' }
  let(:params) { { :family => 'inet', :method => 'loopback', :auto => 1 } }

  it {
    should contain_interfaces__auto('lo')
    should contain_concat__fragment('interfaces::iface_lo').with_target('/etc/network/interfaces')
    should contain_concat__fragment('interfaces::iface_lo').with_content("iface lo inet loopback\n\t\n\n")
  }
end

describe 'interfaces::iface' do
  let(:title) { 'eth0' }
  let(:params) { { :family => 'inet', :method => 'dhcp' } }

  it {
    should_not contain_interfaces__auto('eth0')
    should contain_concat__fragment('interfaces::iface_eth0').with_target('/etc/network/interfaces')
    should contain_concat__fragment('interfaces::iface_eth0').with_content("iface eth0 inet dhcp\n\t\n\n")
  }
end

describe 'interfaces::iface' do
  let(:title) { 'eth0' }
  let(:params) { { :family => 'inet', :method => 'dhcp', :auto => 1 } }

  it {
    should contain_interfaces__auto('eth0')
    should contain_concat__fragment('interfaces::iface_eth0').with_target('/etc/network/interfaces')
    should contain_concat__fragment('interfaces::iface_eth0').with_content("iface eth0 inet dhcp\n\t\n\n")
  }
end

describe 'interfaces::iface' do
  let(:title) { 'eth0' }
  let(:params) { { :family => 'inet', :method => 'static', :options => ['address 192.0.2.1','netmask 255.255.255.0','gateway 192.0.2.2'], :auto => 1 } }

  it {
    should contain_interfaces__auto('eth0')
    should contain_concat__fragment('interfaces::iface_eth0').with_target('/etc/network/interfaces')
    should contain_concat__fragment('interfaces::iface_eth0').with_content("iface eth0 inet static\n\taddress 192.0.2.1\n\tnetmask 255.255.255.0\n\tgateway 192.0.2.2\n\n")
  }
end

describe 'interfaces::iface' do
  let(:title) { 'eth0.123' }
  let(:params) { { :family => 'inet', :method => 'dhcp', :options => ['vlan_raw_device eth0'], :auto => 1 } }

  it {
    should contain_interfaces__auto('eth0.123')
    should contain_concat__fragment('interfaces::iface_eth0.123').with_target('/etc/network/interfaces')
    should contain_concat__fragment('interfaces::iface_eth0.123').with_content("iface eth0.123 inet dhcp\n\tvlan_raw_device eth0\n\n")
  }
end

describe 'interfaces::iface' do
  let(:title) { 'eth0' }
  let(:params) { { :family => 'inet6', :method => 'static', :options => ['address 2001:db8::1','netmask 64'], :auto => 1 } }

  it {
    should contain_interfaces__auto('eth0')
    should contain_concat__fragment('interfaces::iface_eth0').with_target('/etc/network/interfaces')
    should contain_concat__fragment('interfaces::iface_eth0').with_content("iface eth0 inet6 static\n\taddress 2001:db8::1\n\tnetmask 64\n\n")
  }
end

describe 'interfaces::iface' do
  let(:title) { 'eth0v6' }
  let(:params) { { :ifname => 'eth0', :family => 'inet6', :method => 'static', :options => ['address 2001:db8::1','netmask 64'], :auto => 1 } }

  it {
    should contain_interfaces__auto('eth0')
    should contain_concat__fragment('interfaces::iface_eth0v6').with_target('/etc/network/interfaces')
    should contain_concat__fragment('interfaces::iface_eth0v6').with_content("iface eth0 inet6 static\n\taddress 2001:db8::1\n\tnetmask 64\n\n")
  }
end

describe 'interfaces::iface' do
  let(:title) { 'eth0' }
  let(:params) { { :ifname => 'eth0', :family => 'foobar', :method => 'foobar' } }

  it {
    expect {
      should contain_concat__fragment('interfaces::iface_eth0').with_target('/etc/network/interfaces')
    }.to raise_error(Puppet::Error, /family parameter must be one of inet, inet6 or ipx/)
  }
end

describe 'interfaces::iface' do
  let(:title) { 'eth0' }
  let(:params) { { :ifname => 'eth0', :family => 'inet6', :method => 'foobar' } }

  it {
    expect {
      should contain_concat__fragment('interfaces::iface_eth0').with_target('/etc/network/interfaces')
    }.to raise_error(Puppet::Error, /method parameter must be one of loopback, static, manual or v4tunnel for family inet6/)
  }
end

describe 'interfaces::iface' do
  let(:title) { 'eth0' }
  let(:params) { { :ifname => 'eth0', :family => 'ipx', :method => 'foobar' } }

  it {
    expect {
      should contain_concat__fragment('interfaces::iface_eth0').with_target('/etc/network/interfaces')
    }.to raise_error(Puppet::Error, /method parameter must be static or dynamic for family ipx/)
  }
end

describe 'interfaces::iface' do
  let(:title) { 'eth0' }
  let(:params) { { :ifname => 'eth0', :family => 'inet', :method => 'foobar' } }

  it {
    expect {
      should contain_concat__fragment('interfaces::iface_eth0').with_target('/etc/network/interfaces')
    }.to raise_error(Puppet::Error, /method parameter must be one of loopback, static, manual, dhcp, bootp, ppp or wvdial for family inet/)
  }
end
