define interfaces::mapping ( $script, $maps, $order='UNSET' ) {
  $order_real = $order ? {
    'UNSET' => 05,
    default => $order,
  }
  concat::fragment{"interfaces::mapping_${name}":
    target  => '/etc/network/interfaces',
    content => inline_template("mapping <%= @name %>\n\tscript <%= @script %>\n\t<%= @maps.join('\n\t') %>\n\n"),
    order   => $order_real,
  }
}
