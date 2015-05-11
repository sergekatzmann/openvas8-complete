# Docker container for OpenVAS8.
Objective
------------
The purpose of this project is to create an complete, ready to use, installation of OpenVAS8 on debian wheezy 7.8 with all needed additional software packages in compatible / recommended versions - dirb, nikto, redis, nmap, wapiti. Arachni is installed in the latest version. It seems that OpenVAS is no more compatible with this product.

Motivation
------------
This is my first OpenVAS8 container with the main purpose of getting clean testing / auditing environment in no time.
I am planning on creating a set of containers to build an OpenVAS8 testing cluster with master node and slaves including easy to update architecture and volumes for configured data.

Requirements
------------
Docker
Ports available: 

OpenVAS
```
443, 9390, 9391
```
Arachni Web
```
9292
```
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

Open OpenVAS8 in browser using the following link:
```
https://docker_host_ip
User: admin
Password: openvas
```

Connect to running container with
```
docker exec -it <container_id> /bin/bash
```

Running arachni web gui.
Following docker run command will create a non persistent container and start arachni web gui on port 9292. You can stop the container by using CTRL-C.
```
docker run --rm=true -p 9292:9292 sergekatzmann/openvas8-complete /opt/arachni/bin/arachni_web
```
Open arachni web gui in your browser using the following link:
```
http://docker_host_ip:9292
```

Thanks
------
Thanks to Mike Splain for his great OpenVAS7 Docker container (https://github.com/mikesplain/openvas-docker)

Thanks to  Simon Davies, ProCheckUp for his "Installing OpenVAS 8 Beta From Source On Debian" article. (http://www.procheckup.com/blog/installing-openvas-8-beta-from-source-on-debian.aspx)
