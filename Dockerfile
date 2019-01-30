FROM tomcat
WORKDIR /usr/local/tomcat
COPY /nexus/crudApp.war webapps/.
CMD ["catalina.sh", "run"]
EXPOSE 8080
