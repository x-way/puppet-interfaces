define interfaces::iface ( $family, $method, $options=[], $auto=0, $allow_hotplug=0, $ifname='UNSET' ) {
  case $family {
    inet: {
      if ! ($method in [loopback, static, manual, dhcp, bootp, ppp, wvdial]) {
        fail('method parameter must be one of loopback, static, manual, dhcp, bootp, ppp or wvdial for family inet')
      }
    }
    inet6: {
      if ! ($method in [loopback, static, manual, v4tunnel]) {
        fail('method parameter must be one of loopback, static, manual or v4tunnel for family inet6')
      }
    }
    ipx: {
      if ! ($method in [static, dynamic]) {
        fail('method parameter must be static or dynamic for family ipx')
      }
    }
    default: {
      fail('family parameter must be one of inet, inet6 or ipx')
    }
  }

  $ifname_real = $ifname ? {
    'UNSET' => $name,
    default => $ifname,
  }

  if $auto == 1 {
    interfaces::auto { $ifname_real: }
  }

  if $allow_hotplug == 1 {
    interfaces::allow { $ifname_real: subsystem => 'hotplug' }
  }

  concat::fragment{"interfaces::iface_${name}":
    target  => '/etc/network/interfaces',
    content => inline_template("iface <%= @ifname_real %> <%= @family %> <%= @method %>\n\t<%= @options.join('\n\t') %>\n\n"),
  }
}
