#https://hub.docker.com/_/tomcat
#FROM tomcat:8.5-alpine
FROM kwonghung/tomcat:8.0.47-oracle-jdk-1.8

MAINTAINER yeosong.heo ysheo@yeonmu.kr
#Define variables, which will be used later, the specific path can start the container and then enter to view
ENV DIR_WEBAPP /usr/local/tomcat/webapps
#Delete all files under webapp because the current application is the root application
RUN  rm -rf $DIR_WEBAPP/*

ARG WAR_FILE

#Add local war package to remote container
RUN mkdir -p /usr/local/tomcat/scouter/agent.java && mkdir -p /usr/local/tomcat/scouter/agent.host

ADD ./src/${WAR_FILE} $DIR_WEBAPP/${WAR_FILE}
ADD ./src/agent.java /usr/local/tomcat/scouter/agent.java
ADD ./src/agent.host  /usr/local/tomcat/scouter/agent.host
ADD ./src/tomcat/catalina.sh /usr/local/tomcat/bin/catalina.sh

ENV SCOUTER_ENABLED=true
ENV SCOUTER_OBJECTNAME_PREFIX=mips
ENV net_collector_ip=100.100.104.108
ENV net_collector_udp_port=6100
ENV net_collector_tcp_port=6100


#Configure folder mapping
VOLUME /usr/local/tomcat/webapps
#Configure working directory
WORKDIR /usr/local/tomcat/webapps

# 날짜 존 변경
ENV TZ=Asia/Seoul
RUN chmod 755 -R /usr/local/tomcat/scouter/agent.host && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


#Exposed port
EXPOSE 8080
#Start tomcat
#CMD ["sh","-c","cd /usr/local/tomcat/scouter/agent.host && ./host.sh && /usr/local/tomcat/bin/catalina.sh run"]
CMD ["sh","-c","/usr/local/tomcat/bin/catalina.sh run"]