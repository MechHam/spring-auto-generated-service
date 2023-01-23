#!/bin/bash

# Define the input text
text="Hello.My.Name.Is.Chatbot"

# Save the original IFS
IFS_original=$IFS

# Change the IFS to "."
IFS="."

# Split the text into an array
text_array=($text)

# Iterate through the array and print each element
path=""
for i in "${text_array[@]}"
do
    path=$path"/"$i
    echo $path
done

# Reset the IFS to the original value
IFS=$IFS_original


spring init --dependencies=web,jpa,oracle --build:maven --format:project my-crud-project