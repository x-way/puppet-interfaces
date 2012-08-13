define interfaces::mapping ( $script, $maps ) {
  concat::fragment{"interfaces::mapping_${name}":
    target  => '/etc/network/interfaces',
    content => inline_template("mapping <%= @name %>\n\tscript <%= @script %>\n\t<%= @maps.join('\n\t') %>\n\n"),
  }
}
