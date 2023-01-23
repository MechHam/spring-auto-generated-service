#!/bin/bash

# Create a new Spring Boot project
spring init --dependencies=web,jpa,h2 my-crud-project

cd my-crud-project

# Create entities from command line arguments
for entity in "$@"; do
  echo "Creating entity for $entity"
  touch src/main/java/com/myproject/entities/$entity.java
  echo "package com.myproject.entities;

import javax.persistence.*;

@Entity
@Table(name = \"$entity\")
public class $entity {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  // Add additional fields and getters/setters here
}
" >>src/main/java/com/myproject/entities/$entity.java
done

# Create repositories for entities
for entity in "$@"; do
  echo "Creating repository for $entity"
  touch src/main/java/com/myproject/repositories/${entity}Repository.java
  echo "package com.myproject.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import com.myproject.entities.$entity;

public interface ${entity}Repository extends JpaRepository<$entity, Long> { }
" >>src/main/java/com/myproject/repositories/${entity}Repository.java
done

# Create controllers for entities
for entity in "$@"; do
  echo "Creating controller for $entity"
  touch src/main/java/com/myproject/controllers/${entity}Controller.java
  echo "package com.myproject.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.myproject.entities.$entity;
import com.myproject.repositories.${entity}Repository;

import java.util.List;

@RestController
@RequestMapping(\"/$entity\")
public class ${entity}Controller {
  @Autowired
  private ${entity}Repository ${entity,,}Repository;

  @GetMapping
  public List<$entity> findAll() {
    return ${entity,,}Repository.findAll();
  }

  @GetMapping(\"/{id}\")
  public $entity findById(@PathVariable Long id) {
    return ${entity,,}Repository.findById(id).orElse(null);
  }

  @PostMapping
  public $entity create($entity $entity) {
    return ${entity,,}Repository.save($entity);
  }

  @PutMapping(\"/{id}\")
  public $entity update($entity $entity, @PathVariable Long id) {
    $entity.setId(id);
    return ${entity,,}Repository.save($entity);
  }

  @DeleteMapping(\"/{id}\")
  public void delete(@PathVariable Long id) {
${entity,,}Repository.deleteById(id);
}
}
" >>src/main/java/com/myproject/controllers/${entity}Controller.java
done

# Create services for entities
for entity in "$@"; do
  echo "Creating service for $entity"
  touch src/main/java/com/myproject/services/${entity}Service.java
  echo "package com.myproject.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.myproject.entities.$entity;
import com.myproject.repositories.${entity}Repository;

import java.util.List;

@Service
public class ${entity}Service {
@Autowired
private ${entity}Repository ${entity,,}Repository;

public List<$entity> findAll() {
return ${entity,,}Repository.findAll();
}

public $entity findById(Long id) {
return ${entity,,}Repository.findById(id).orElse(null);
}

public $entity create($entity $entity) {
return ${entity,,}Repository.save($entity);
}

public $entity update($entity $entity, Long id) {
$entity.setId(id);
return ${entity,,}Repository.save($entity);
}

public void delete(Long id) {
${entity,,}Repository.deleteById(id);
}
}
" >>src/main/java/com/myproject/services/${entity}Service.java
done

#Inject services into controllers
sed -i '' 's/(private )'"${entity}Repository"'( )/\1'"${entity}Service"'\2/g' src/main/java/com/myproject/controllers/*.java
