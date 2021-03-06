What is it?
===========

A Puppet module to manage /etc/network/interfaces.

[![Build Status](https://secure.travis-ci.org/x-way/puppet-interfaces.png)](http://travis-ci.org/x-way/puppet-interfaces)
[![Coverage Status](https://coveralls.io/repos/x-way/puppet-interfaces/badge.png)](https://coveralls.io/r/x-way/puppet-interfaces)

Usage:
------

Basic example which only configures the loopback interface:

```
include interfaces
interfaces::iface { 'lo': family => 'inet', method => 'loopback', auto => 1 }
```

Standard example with a regular Ethernet interface configured for DHCP:

```
include interfaces
interfaces::iface { 'eth0': family => 'inet', method => 'dhcp', auto => 1, allow_hotplug => 1 }
```

Network interface with static addressing and VLAN with DHCP configuration:
```
include interfaces
interfaces::iface { 'eth0': family => 'inet', method => 'static', options => ['address 192.0.2.1','netmask 255.255.255.0','gateway 192.0.2.2'], auto => 1, allow_hotplug => 1 }
interfaces::iface { 'eth0.123': family => 'inet', method => 'dhcp', options => ['vlan_raw_device eth0'], auto => 1 }
```

Static IPv6 address configuration:
```
include interfaces
interfaces::iface { 'eth0': family => 'inet6', method => 'static', options => ['address 2001:db8::1','netmask 64'], auto => 1, allow_hotplug => 1 }
```

Dualstack configuration:
```
include interfaces
interfaces::iface { 'eth0': family => 'inet', method => 'dhcp', auto => 1, allow_hotplug => 1 }
interfaces::iface { 'eth0v6': ifname => 'eth0', family => 'inet6', method => 'static', options => ['address 2001:db8::1','netmask 64'] }
```

Reference:
----------

The puppet module directly implements the stanzas documented in interfaces(5).

```
interfaces::auto()
interfaces::allow($subsystem)
interfaces::mapping($script, $maps=[])
interfaces::iface($family, $method, $options=[], $ifname=$name, $auto=0, $allow_hotplug=0)
```

Currently the only shortcuts are the $auto parameter of interfaces::iface which when set to 1 directly produces an interfaces::auto entry for the interface and the $allow_hotplug parameter of interfaces::iface which when set to 1 directly produces an interfaces::allow hotplug subsystem entry for the interface.
