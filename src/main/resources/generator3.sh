#!/bin/bash

# Variables
GROUP_ID=com.example
ARTIFACT_ID=crud-project
PACKAGE=com.example.crudproject
DB_URL=jdbc:mysql://localhost:3306/crud
DB_USERNAME=root
DB_PASSWORD=password

# Create the project
mvn archetype:generate \
    -DgroupId=$GROUP_ID \
    -DartifactId=$ARTIFACT_ID \
    -Dversion=1.0-SNAPSHOT \
    -DarchetypeArtifactId=org.springframework.boot \
    -DarchetypeGroupId=org.springframework.boot \
    -DarchetypeVersion=2.3.3.RELEASE

# Go to the project directory
cd $ARTIFACT_ID

# Add dependencies
mvn dependency:add-dependency \
    -DgroupId=org.springframework.boot \
    -DartifactId=spring-boot-starter-web \
    -Dversion=2.3.3.RELEASE
mvn dependency:add-dependency \
    -DgroupId=org.springframework.boot \
    -DartifactId=spring-boot-starter-data-jpa \
    -Dversion=2.3.3.RELEASE
mvn dependency:add-dependency \
    -DgroupId=mysql \
    -DartifactId=mysql-connector-java \
    -Dversion=8.0.21

# Update application.properties
echo "spring.datasource.url=$DB_URL" >> src/main/resources/application.properties
echo "spring.datasource.username=$DB_USERNAME" >> src/main/resources/application.properties
echo "spring.datasource.password=$DB_PASSWORD" >> src/main/resources/application.properties
echo "spring.jpa.generate-ddl=true" >> src/main/resources/application.properties

# Create package structure
mkdir -p src/main/java/$PACKAGE/entity
mkdir -p src/main/java/$PACKAGE/controller
mkdir -p src/main/java/$PACKAGE/service
mkdir -p src/main/java/$PACKAGE/repository
