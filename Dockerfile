# OpenVAS 8
#
# VERSION       1.0.0

FROM debian:7.8
MAINTAINER Serge Katzmann serge.katzmann@gmail.com

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8  
ENV LANGUAGE en  
ENV LC_ALL C.UTF-8

RUN apt-get update -y && apt-get install locales debconf -y
RUN dpkg-reconfigure locales && \
    locale-gen C.UTF-8 && \
    /usr/sbin/update-locale LANG=C.UTF-8

RUN apt-get install build-essential \
					bison \ 
					flex \ 
					cmake \ 
					pkg-config \ 
					libssh-dev \ 
					libgnutls-dev \ 
					libglib2.0-dev \ 
					libpcap-dev \ 
					libgpgme11-dev \ 
					uuid-dev \ 
					libksba-dev \ 
					libhiredis-dev \ 
					libldap2-dev \ 
					autoconf \ 
					libsqlite3-dev \ 
					libxml2-dev \ 
					libmicrohttpd-dev \ 
					xsltproc \ 
					tcl \ 
					rpm \ 
					alien \ 
					nsis \ 
					gcc-mingw32 \ 
					perl-base \ 
					perl-base \ 
					heimdal-dev \ 
					heimdal-multidev \ 
					libpopt-dev \ 
					libxslt-dev \ 
					libsnmp-dev \ 
					doxygen \ 
					xmltoman \ 
					sqlfairy \ 
					sqlite3 \
					unzip \
					rsync \	
					wget \
					python2.7 \
					python-setuptools \
					python-pip \
					libidn11-dev \
					libssl-dev \
					libpcre3-dev \
					less \
					net-tools \
					openssh-client \
					texlive-latex-base \					
					texlive-latex-recommended \
					texlive-latex-extra \
					htmldoc \
					-y --no-install-recommends --fix-missing && \				
    mkdir /openvas-src && \
    cd /openvas-src && \
		wget -nv http://wald.intevation.org/frs/download.php/2015/openvas-libraries-8.0.1.tar.gz && \
		wget -nv http://wald.intevation.org/frs/download.php/2016/openvas-scanner-5.0.1.tar.gz && \
		wget -nv http://wald.intevation.org/frs/download.php/2017/openvas-manager-6.0.1.tar.gz && \
		wget -nv http://wald.intevation.org/frs/download.php/2018/greenbone-security-assistant-6.0.1.tar.gz && \
		wget -nv http://wald.intevation.org/frs/download.php/1987/openvas-cli-1.4.0.tar.gz && \
		wget -nv http://wald.intevation.org/frs/download.php/1975/openvas-smb-1.0.1.tar.gz && \
		tar zxvf openvas-libraries-8.0.1.tar.gz && \
		tar zxvf openvas-scanner-5.0.1.tar.gz && \
		tar zxvf openvas-manager-6.0.1.tar.gz && \
		tar zxvf greenbone-security-assistant-6.0.1.tar.gz && \
		tar zxvf openvas-cli-1.4.0.tar.gz && \
		tar zxvf openvas-smb-1.0.1.tar.gz && \
    cd /openvas-src/openvas-smb-1.0.1 && \
        mkdir build && \
        cd build && \
        cmake .. && \
        make -j $(nproc)&& \
        make install && \
		make rebuild_cache && \
    cd /openvas-src/openvas-libraries-8.0.1 && \
        mkdir build && \
        cd build && \
        cmake .. && \
        make -j $(nproc)&& \
        make install && \
		make rebuild_cache && \		
	cd /openvas-src/openvas-scanner-5.0.1 && \
        mkdir build && \
        cd build && \
        cmake .. && \
        make -j $(nproc)&& \
        make install && \
		make rebuild_cache && \	
	cd /openvas-src/openvas-manager-6.0.1 && \
        mkdir build && \
        cd build && \
        cmake .. && \
        make -j $(nproc)&& \
        make install && \
		make rebuild_cache && \			
	cd /openvas-src/greenbone-security-assistant-6.0.1 && \
        mkdir build && \
        cd build && \
        cmake .. && \
        make -j $(nproc)&& \
        make install && \
		make rebuild_cache && \				
	cd /openvas-src/openvas-cli-1.4.0 && \
        mkdir build && \
        cd build && \
        cmake .. && \
        make -j $(nproc)&& \
        make install && \
		make rebuild_cache && \		
    rm -rf /openvas-src
RUN	mkdir /redis && \
	cd /redis && \
	wget http://download.redis.io/releases/redis-2.8.19.tar.gz  && \
		tar zxvf redis-2.8.19.tar.gz && \
		cd redis-2.8.19 && \
		make -j $(nproc)&& \
		make install && \
		rm -fr /redis
	
RUN	apt-get remove heimdal-dev -y
RUN	apt-get install curl \
					libcurl4-gnutls-dev \
					libkrb5-dev -y
RUN mkdir /dirb && \
    cd /dirb && \
    wget -nv http://downloads.sourceforge.net/project/dirb/dirb/2.22/dirb222.tar.gz && \
        tar -zxvf dirb222.tar.gz && \
        cd dirb222 && \
        chmod 700 -R * && \
        ./configure && \
        make -j $(nproc)&& \
        make install
RUN cd /tmp && \
    wget -nv http://downloads.arachni-scanner.com/arachni-1.1-0.5.7-linux-x86_64.tar.gz && \
        tar -zxvf arachni-1.1-0.5.7-linux-x86_64.tar.gz && \
		rm -f arachni-1.1-0.5.7-linux-x86_64.tar.gz && \
        mv arachni-1.1-0.5.7 /opt/arachni && \
        ln -s /opt/arachni/bin/* /usr/local/bin/
RUN cd ~ && \
    wget -nv https://github.com/sullo/nikto/archive/master.zip && \
    unzip master.zip -d /tmp && \
    mv /tmp/nikto-master/program /opt/nikto && \
    rm -rf /tmp/nikto-master && \
	rm -f ~/master.zip && \
    echo "EXECDIR=/opt/nikto\nPLUGINDIR=/opt/nikto/plugins\nDBDIR=/opt/nikto/databases\nTEMPLATEDIR=/opt/nikto/templates\nDOCDIR=/opt/nikto/docs" >> /opt/nikto/nikto.conf && \
    ln -s /opt/nikto/nikto.pl /usr/local/bin/nikto.pl && \
    ln -s /opt/nikto/nikto.conf /etc/nikto.conf
	
RUN cd /tmp && wget -nv https://nmap.org/dist/nmap-5.51-1.x86_64.rpm && \
	alien -i nmap-5.51-1.x86_64.rpm && \
	rm -f nmap-5.51-1.x86_64.rpm
	
RUN cd /tmp && \
	pip install --upgrade pip && \
	wget -nv -O wapiti-2.3.0.tar.gz "http://downloads.sourceforge.net/project/wapiti/wapiti/wapiti-2.3.0/wapiti-2.3.0.tar.gz?r=http://sourceforge.net/projects/wapiti/files/wapiti/wapiti-2.3.0/&amp;ts=1391931386&amp;use_mirror=heanet" && \
	tar zxvf wapiti-2.3.0.tar.gz && \
	cd wapiti-2.3.0 && \
	python setup.py install	&& \
	ln -s /usr/local/bin/wapiti /usr/bin/wapiti && \
	rm -f /tmp/wapiti-2.3.0.tar.gz
	
RUN apt-get clean -yq && \
    apt-get autoremove -yq && \
    apt-get purge -y --auto-remove build-essential cmake

RUN wget -nv https://svn.wald.intevation.org/svn/openvas/trunk/tools/openvas-check-setup --no-check-certificate
	
ADD ./redis.conf /etc/redis.conf
RUN echo "\nunixsocket /tmp/redis.sock" >> /etc/redis.conf && \
	sed -i 's#daemonize yes#daemonize no#g' /etc/redis.conf
ADD ./open-vas-8-start.sh /open-vas-8-start.sh
ADD ./setup.sh /setup.sh
RUN chmod 700 /open-vas-8-start.sh && chmod 700 /openvas-check-setup && chmod 700 /setup.sh
RUN /setup.sh
#OpenVAS 443 9390 9391 Arachni Web 9292
EXPOSE 443 9390 9391 9292
CMD ["./open-vas-8-start.sh"]