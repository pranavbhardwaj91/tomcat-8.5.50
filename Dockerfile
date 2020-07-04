#using the Image we built
FROM openjdk-8-jdk  

#making directory for tomcat
RUN mkdir /opt/tomcat/

#defining the version as variable
ENV TOMCAT_VERSION 8.5.50

#Installing all the required dependency
RUN apt-get update && apt-get install -y locales git build-essential curl wget

#Installing Tomcat version 8.5.50 from official repo
RUN wget --quiet --no-cookies https://archive.apache.org/dist/tomcat/tomcat-8/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -O /tmp/tomcat.tgz && \
tar xzvf /tmp/tomcat.tgz -C /opt && \
mv /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat

#Defining installed directory location as ENV variable inside container
ENV CATALINA_HOME /opt/tomcat/apache-tomcat-${TOMCAT_VERSION}

#Defining the CATALINA_HOME variable as Linux Env Variable
ENV PATH $PATH:$CATALINA_HOME/bin

#Exposing the port of container
EXPOSE 8080

#Directory location of container when we login
WORKDIR /opt/tomcat

#Defining the single process to execute inside container
#CMD ["/opt/tomcat/apache-tomcat-${8.5.50}/bin/catalina.sh", "run"]
CMD ["sh", "-c", "/opt/tomcat/apache-tomcat-${TOMCAT_VERSION}/bin/catalina.sh run"]
