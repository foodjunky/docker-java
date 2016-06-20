#
# Base image for deploying java applications. Installs Oracle Java 7 JDK.
#
# docker-build properties:
# TAG=foodjunky/java:latest

FROM foodjunky/base
MAINTAINER Jeremy Jongsma "jeremy@foodjunky.com"

ADD etc/sysctl.conf /etc/
ADD clean-java.sh /tmp/

RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
	echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
	add-apt-repository --yes ppa:webupd8team/java && \
	apt-get --yes update && \
	apt-get --yes install oracle-jdk7-installer && \
	apt-get clean && \
	sh /tmp/clean-java.sh && \
	rm /tmp/clean-java.sh
