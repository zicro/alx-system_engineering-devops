exec { 'update packages':
  command => '/usr/bin/apt-get update'
}

# Ensure the Nginx package is installed
package { 'nginx':
  ensure => 'installed',
}

# Ensure the Nginx service is enabled and running
service { 'nginx':
  ensure  => 'running',
  enable  => true,
  require => Package['nginx'],
}

# Create an Nginx configuration file
file { '/etc/nginx/sites-available/default':
  ensure  => 'file',
  content => '
    server {
        listen 80;
        server_name _;

        location / {
            root   /var/www/html;
            index  index.html;
            try_files $uri /index.html;

            # Custom response containing "Hello World!"
            add_header Content-Type text/html;
            return 200 "Hello World!";
        }
    }
  ',
  require => Package['nginx'],
  notify  => Service['nginx'],
}
