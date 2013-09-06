define stunnel::certs($certs_dir, $certs_src_dir) {
    file { "${name}":
        path => "${certs_dir}/${name}.pem",
        source => "${certs_src_dir}/${name}.pem",
        owner => root,
        group => root,
        mode => 600
    }
}