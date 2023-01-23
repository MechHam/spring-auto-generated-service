#!/bin/bash

/bin/bash extract-text-using-delimeter.sh

# Check for project name argument
if [ -z "$1" ]; then
  echo "Please provide a project name and path as arguments."
  exit 1
fi





# Set project variables
project_name=$1
project_path=$2
package_name="lu.sgbt.$project_name"


# Variables
GROUP_ID=$package_name
ARTIFACT_ID=$project_name
PACKAGE=$package_name
DB_URL=jdbc:mysql://localhost:3306/crud
DB_USERNAME=root
DB_PASSWORD=password


# Create project directory
#mkdir $project_path/$project_name
cd $project_path

# Initialize the project with Maven
mvn archetype:generate -DgroupId=$package_name -DartifactId=$project_name -Dversion=1.0-SNAPSHOT -Dpackage=$package_name \
  -DarchetypeArtifactId=maven-archetype-quickstart \
  -DarchetypeGroupId=org.apache.maven.archetypes \
  -DarchetypeVersion=1.4

#com.fitbur.testify.archetype:archetype-junit-springboot-systemtest 0.0.1-SNAPSHOT
#am.ik.archetype:spring-boot-docker-blank-archetype version 2.0.0
#org.apache.maven.archetypes:maven-archetype-quickstart

# Add Spring Boot dependencies to pom.xml
# Add dependencies
cd $project_path/$project_name
# Add Spring Boot dependencies to pom.xml
echo '<dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-data-jpa</artifactId>
    </dependency>
    <dependency>
        <groupId>com.h2database</groupId>
        <artifactId>h2</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-test</artifactId>
        <scope>test</scope>
    </dependency>
</dependencies>' >>pom.xml

# Add Spring Boot plugin to pom.xml
echo '<build>
    <plugins>
        <plugin>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-maven-plugin</artifactId>
        </plugin>
    </plugins>
</build>' >>pom.xml


pwd

pack_to_path=$(echo $package_name | sed 's/\./\//g')

cd src/main
mkdir resources

cd resources
# Update application.properties
echo "spring.datasource.url=$DB_URL" >> application.properties
echo "spring.datasource.username=$DB_USERNAME" >> application.properties
echo "spring.datasource.password=$DB_PASSWORD" >> application.properties
echo "spring.jpa.generate-ddl=true" >> application.properties

cd ..
cd java/$pack_to_path
# Create entities package
mkdir entities

# Create repositories package
mkdir repositories

# Create controllers package
mkdir controllers

# Create services package
mkdir services

echo "Project $project_name has been created with basic CRUD structure and maven architecture"
