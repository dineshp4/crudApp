FROM tomcat
WORKDIR /usr/local/tomcat
COPY crudApp.war webapps/.
COPY dbconf.txt .
RUN sed -i '$e cat dbconf.txt' conf/context.xml
CMD ["catalina.sh", "run"]
EXPOSE 8080
