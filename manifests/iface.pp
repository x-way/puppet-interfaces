define interfaces::iface ( $family, $method, $options=[], $auto=0, $ifname='' ) {
  if $ifname == '' {
    $_ifname = $name
  } else {
    $_ifname = $ifname
  }
  if $auto == 1 {
    interfaces::auto { $_ifname: }
  }

  $str = "iface ${_ifname} ${family} ${method}\n\t<%= options.join('\n\t') %>\n\n"
  concat::fragment{"interfaces::iface_${name}":
    target  => '/etc/network/interfaces',
    content => inline_template($str),
  }
}
