What is this?
=============

Derived from the original puppetlabs-stunnel here https://github.com/puppetlabs/puppetlabs-stunnel. 
This version allows multiple services block that will allow multiple certificates to be run on a 
single port indirectly removing the need for running multiple stunnel instances. Please verify that 
your stunnel version supports this.

I've also remove much of the obfuscation of the parameters since I prefer them to correlate with
the stunnel parameters directly.

Usage
=============

The following are for use inside of the node or service block.

Multiple IP Addresses same destination
--------------------------------------
    include stunnel
    Stunnel::Tun {
            require => Package[$stunnel::data::package],
            notify => Service[$stunnel::data::service],
    }

    stunnel::tun { 'https':
            connect => '127.0.0.1:81',
            services => {
                    'site.com' => {  accept => '1.1.1.1', cert => '/srv/ssl/certs/mysite.com.pem' },
                    'othersite.com' => { accept => '2.2.2.2', cert => '/srv/ssl/certs/mysite.com.pem' },
            }
    }