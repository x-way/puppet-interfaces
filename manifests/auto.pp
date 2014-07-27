define interfaces::auto ( $order='UNSET' ) {
  $order_real = $order ? {
    'UNSET' => $name ? {
      'lo'    => 02,
      default => 03,
    },
    default => $order
  }
  concat::fragment{"interfaces::auto_${name}":
    target  => '/etc/network/interfaces',
    content => "auto ${name}\n\n",
    order   => $order_real,
  }
}
