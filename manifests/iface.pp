define interfaces::iface ( $family, $method, $options=[], $auto=0, $ifname=$name ) {
  if $auto == 1 {
    interfaces::auto { "${ifname}": }
  }

  $str = "iface ${ifname} ${family} ${method}\n	<%= options.join('\n	') %>\n\n"
  concat::fragment{"interfaces::iface_${name}":
    target => '/etc/network/interfaces',
    content => inline_template($str),
  }
}
