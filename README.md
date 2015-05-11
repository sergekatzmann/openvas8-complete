# openvas8-complete
Docker container for OpenVAS8

Requirements
------------
Docker
Ports available: 443, 9390, 9391, 9292

Usage
-----

Build container from Dockerfile using
```
docker build -t sergekatzmann/openvas8-complete .
```

Run container in daemon mode with
```
docker run -d -p 443:443 -p 9390:9390 -p 9391:9391 -p 9292:9292 sergekatzmann/openvas8-complete
```

Connect to running container with
```
docker exec -it <container_id> /bin/bash
```

Thanks
------
Thanks to Mike Splain for his great OpenVAS7 Docker container (https://github.com/mikesplain/openvas-docker)
Thanks to  Simon Davies, ProCheckUp for his "Installing OpenVAS 8 Beta From Source On Debian" article. (http://www.procheckup.com/blog/installing-openvas-8-beta-from-source-on-debian.aspx)
