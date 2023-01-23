#!/bin/bash
GROUP_ID=com.example
ARTIFACT_ID=crud-project
PACKAGE=com.example.crudproject
DB_URL=jdbc:oracle:thin:@localhost:1521:orcl
DB_USERNAME=username
DB_PASSWORD=password

cd $ARTIFACT_ID

mvn hibernate-tools:hbm2java -Dhibernatetool.hbm2java.destdir=src/main/java/$PACKAGE/entity -Dhibernatetool.hbm2java.packagename=$PACKAGE.entity -Dhibernatetool.hbm2java.revengfile=src/main/resources/hibernate.reveng.xml

echo "<?xml version='1.0' encoding='UTF-8'?>" > src/main/resources/hibernate.reveng.xml
echo "<!DOCTYPE hibernate-reverse-engineering SYSTEM 'http://hibernate.sourceforge.net/hibernate-reverse-engineering-3.0.dtd'>" >> src/main/resources/hibernate.reveng.xml
echo "<hibernate-reverse-engineering>" >> src/main/resources/hibernate.reveng.xml
echo "    <connection-configuration>" >> src/main/resources/hibernate.reveng.xml
echo "        <driver>oracle.jdbc.driver.OracleDriver</driver>" >> src/main/resources/hibernate.reveng.xml
echo "        <url>$DB_URL</url>" >> src/main/resources/hibernate.reveng.xml
echo "        <username>$DB_USERNAME</username>" >> src/main/resources/hibernate.reveng.xml
echo "        <password>$DB_PASSWORD</password>" >> src/main/resources/hibernate.reveng.xml
echo "    </connection-configuration>" >> src/main/resources/hibernate.reveng.xml
echo "    <table-filter match-name='*'/>" >> src/main/resources/hibernate.reveng.xml
echo "</hibernate-reverse-engineering>" >> src/main/resources/hibernate.reveng.xml

echo "<dependency>" >> pom.xml
echo "    <groupId>com.oracle</groupId>" >> pom.xml
echo "    <artifactId>ojdbc8</artifactId>" >> pom.xml
echo "    <version>19.3.0.0</version>" >> pom.xml
echo "</dependency>" >> pom.xml

echo "spring.datasource.url=$DB_URL" >> src/main/resources/application.properties
echo "spring.datasource.username=$DB_USERNAME" >> src/main/resources/application.properties
echo "spring.datasource.password=$DB_PASSWORD" >> src/main/resources/application.properties
echo "spring.jpa.generate-ddl=true" >> src/main/resources/application.properties
