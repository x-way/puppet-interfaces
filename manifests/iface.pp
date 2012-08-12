define interfaces::iface ( $family, $method, $options=[], $auto=0, $ifname='UNSET' ) {
  $ifname_real = $ifname ? {
    'UNSET' => $name,
    default => $ifname,
  }

  if $auto == 1 {
    interfaces::auto { $ifname_real: }
  }

  $str = "iface ${ifname_real} ${family} ${method}\n\t<%= options.join('\n\t') %>\n\n"
  concat::fragment{"interfaces::iface_${name}":
    target  => '/etc/network/interfaces',
    content => inline_template($str),
  }
}
