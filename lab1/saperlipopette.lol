server {

        root /var/www/saperlipopette.lol/html;
        index index.html index.htm index.nginx-debian.html;

        server_name saperlipopette.lol;

        location / {
		proxy_set_header Host $http_host;
		proxy_set_header X-Real-IP $remote_addr;
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		proxy_pass http://saperlipopette.lol:8080;
                try_files $uri $uri/ =404;
        }
	location /index/ {
        	alias /var/www/saperlipopette.lol/html/;
		try_files $uri $uri/ =404;
    	}

    listen [::]:443 ssl ipv6only=on; # managed by Certbot
    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/saperlipopette.lol/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/saperlipopette.lol/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}
server {
    if ($host = saperlipopette.lol) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


        listen 80;
        listen [::]:80;

        server_name saperlipopette.lol;
    return 404; # managed by Certbot


}
