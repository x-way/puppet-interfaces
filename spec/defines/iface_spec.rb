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
  let(:params) { { :family => 'inet', :method => 'dhcp', :auto => 1 } }

  it {
    should contain_interfaces__auto('eth0')
    should contain_concat__fragment('interfaces::iface_eth0').with_target('/etc/network/interfaces')
    should contain_concat__fragment('interfaces::iface_eth0').with_content("iface eth0 inet dhcp\n\t\n\n")
  }
end
