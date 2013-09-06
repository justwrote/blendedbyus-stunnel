define stunnel::tun(
    $conf_dir        = $stunnel::data::conf_dir,
    $certs_dir       = $stunnel::data::certs_dir,
    $certs_src_dir   = $stunnel::data::certs_src_dir,

    $protocol        = 'proxy',
    $options         = 'NO_SSLv2',
    $ciphers         = 'HIGH:!aNULL:!MD5',
    $session_timeout = '300',
    $client          = false,

    $user            = 'stunnel4',
    $group           = 'stunnel4',
    $pid             = "/var/run/stunnel4/${name}.pid",
    $chroot          = false,

    $debuglevel      = '0',
    $output          = "/var/log/stunnel4/${name}.log",

    $verify          = false,
    $cert            = false,
    $key             = false,
    $cafile          = false,
    $crlfile         = false,

    $connect         = false,

    $services,
    $snis,
) {

  file { "${conf_dir}/${name}.conf":
    ensure  => file,
    content => template("${module_name}/stunnel.conf.erb"),
    mode    => '0644',
    owner   => '0',
    group   => '0',
    require => File[$conf_dir],
  }

  file { "${certs_dir}":
    ensure => "directory",
    owner => root,
    group => root,
    mode => 600
  }

  $certs = keys($services)
  stunnel::certs { $certs:
    certs_dir => $certs_dir,
    certs_src_dir => $certs_src_dir,
    require => File["${certs_dir}"],
  }

}
