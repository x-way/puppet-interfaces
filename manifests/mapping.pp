define interfaces::mapping ( $script, $maps ) {
	$str = "mapping ${name}\n	script ${script}\n	<%= maps.join('\n	') %>\n\n"
	concat::fragment{"interfaces::mapping_${name}":
		target => '/etc/network/interfaces',
		content => inline_template($str),
	}
}
