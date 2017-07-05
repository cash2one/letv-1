class nginx_clive::install {

  exec { "luajit":
    path      => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    command   => "wget -N http://${rpmsource}/puppet/package/live/luajit.tar.gz -P /tmp;tar -zxvf /tmp/luajit.tar.gz -C /",
    creates   => "/usr/local/luajit/bin/luajit-2.0.4",

  } 

  file { "/home/update/shell/nginx_update.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("nginx_clive/nginx_update.sh"),
  }

  file { "/home/update/puppetmd5file/md5-nginx":
    ensure => file,
    mode => 644,
    content => template("nginx_clive/md5-nginx"),
  }

  exec { "update-nginx":
    require => File["/home/update/shell/nginx_update.sh"],
    command => "sh /home/update/shell/nginx_update.sh",
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    subscribe => File["/home/update/puppetmd5file/md5-nginx"],
    refreshonly => true,
  }
}
