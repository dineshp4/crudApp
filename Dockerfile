FROM tomcat
WORKDIR /usr/local/tomcat
COPY crudApp.war webapps/.
CMD ["catalina.sh", "run"]
EXPOSE 8080
