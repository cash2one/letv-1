class systembase_live::authorized_keys{
  file {"/root/.ssh/authorized_keys":
    owner   => root,
    group   => root,
    mode    => 600,
    ensure  => present,
    content => template("systembase_live/authorized_keys.erb"),
  }

  file {"/usr/local/zabbix/.ssh/authorized_keys":
    owner   => zabbix,
    group   => zabbix,
    mode    => 600,
    ensure  => present,
    content => template("systembase_live/zabbix_authorized_keys.erb"),
  }
}
