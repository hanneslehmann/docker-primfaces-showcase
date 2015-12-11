FROM google/debian:wheezy

MAINTAINER Hannes Lehmann <hannes.lehmann@nterra.com>

RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install openjdk-7-jre-headless curl wget
RUN mkdir -p /usr/share/tomcat
RUN curl http://ftp.halifax.rwth-aachen.de/apache/tomcat/tomcat-8/v8.0.30/bin/apache-tomcat-8.0.30.tar.gz | tar zxf - --strip=1 -C /usr/share/tomcat/
RUN wget http://repository.primefaces.org/org/primefaces/showcase/5.3/showcase-5.3.war -P /usr/share/tomcat/webapps

CMD ["/usr/bin/java","-Djava.util.logging.config.file=/usr/share/tomcat/conf/logging.properties","-Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager","-Djava.endorsed.dirs=/usr/share/tomcat/endorsed","-classpath","/usr/share/tomcat/bin/bootstrap.jar:/usr/share/tomcat/bin/tomcat-juli.jar","-Dcatalina.base=/usr/share/tomcat","-Dcatalina.home=/usr/share/tomcat","-Djava.io.tmpdir=/usr/share/tomcat/temp","org.apache.catalina.startup.Bootstrap","start"]

EXPOSE 8080

# Ready on http://<docker-ip>:8080/showcase-5.3