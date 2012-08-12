define interfaces::auto ( ) {
  concat::fragment{"interfaces::auto_${name}":
    target  => '/etc/network/interfaces',
    content => "auto ${name}\n\n",
  }
}
