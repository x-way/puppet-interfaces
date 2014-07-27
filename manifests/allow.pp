define interfaces::allow ( $subsystem, $order='UNSET' ) {
  $order_real = $order ? {
    'UNSET' => 02,
    default => $order,
  }
  concat::fragment{"interfaces::allow-${subsystem}_${name}":
    target  => '/etc/network/interfaces',
    content => "allow-${subsystem} ${name}\n\n",
    order   => $order_real,
  }
}
