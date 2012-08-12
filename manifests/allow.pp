define interfaces::allow ( $subsystem ) {
  concat::fragment{"interfaces::allow-${subsystem}_${name}":
    target => '/etc/network/interfaces',
    content => "allow-${subsystem} ${name}\n\n",
  }
}

