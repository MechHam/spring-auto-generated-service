#!/bin/bash

# Variables
GROUP_ID=com.example
ARTIFACT_ID=crud-project
PACKAGE=com.example.crudproject
DB_URL=jdbc:mysql://localhost:3306/crud
DB_USERNAME=root
DB_PASSWORD=password

# Go to the project directory
cd $ARTIFACT_ID

# Generate entities
mvn hibernate-tools:hbm2java \
    -Dhibernatetool.hbm2java.destdir=src/main/java/$PACKAGE/entity \
    -Dhibernatetool.hbm2java.packagename=$PACKAGE.entity \
    -Dhibernatetool.hbm2java.revengfile=src/main/resources/hibernate.reveng.xml

# Update hibernate.reveng.xml
echo "<?xml version='1.0' encoding='UTF-8'?>" > src/main/resources/hibernate.reveng.xml
echo "<!DOCTYPE hibernate-reverse-engineering SYSTEM 'http://hibernate.sourceforge.net/hibernate-reverse-engineering-3.0.dtd'>" >> src/main/resources/hibernate.reveng.xml
echo "<hibernate-reverse-engineering>" >> src/main/resources/hibernate.reveng.xml
echo "    <schema-selection match-schema='crud'/>" >> src/main/resources/hibernate.reveng.xml
echo "    <table-filter match-name='*'/>" >> src/main/resources/hibernate.reveng.xml
echo "</hibernate-reverse-engineering>" >> src/main/resources/hibernate.reveng.xml

# Update pom.xml
echo "<dependency>" >> pom.xml
echo "    <groupId>org.hibernate</groupId>" >> pom.xml
echo "    <artifactId>hibernate-tools</artifactId>" >> pom.xml
echo "    <version>5.4.21.Final</version>" >> pom.xml
echo "    <scope>runtime</scope>" >> pom.xml
echo "</dependency>" >> pom.xml

# Update application.properties
echo "spring.datasource.url=$DB_URL" >> src/main/resources/application.properties
echo "spring.datasource.username=$DB_USERNAME" >> src/main/resources/application.properties
echo "spring.datasource.password=$DB_PASSWORD" >> src/main/resources/application.properties
echo "spring.jpa.generate-ddl=true" >> src/main/resources/application.properties
