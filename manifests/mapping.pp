define interfaces::mapping ( $script, $maps ) {
  $str = "mapping ${name}\n\tscript ${script}\n\t<%= maps.join('\n\t') %>\n\n"
  concat::fragment{"interfaces::mapping_${name}":
    target  => '/etc/network/interfaces',
    content => inline_template($str),
  }
}
