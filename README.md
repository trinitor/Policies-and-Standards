# Policies and Standards 

## Overview
This repository contains the needed templates to generate pdf files for policies and standards.   
It provides a way to write the documents in a standard way using asciidoc.  
The cover page is designed in latex to be able to customize it in a more granular way. 

## Structure

### Folders

Folders should start with a the number 0. 
The script will generate a pdf file for each adoc file in the folders. 

The folder resources contains all needed additional files used for the pdf generation including the templates, themes, fonts, and scripts. 

### Documents
Each document is a separate file in the asciidoc format.  
Documents must follow some rules to be exported correctly.

The first line is the H1 header containing the document title.  
The following meta information must be specified:  
```
:version:   x.y
:date:      yyyy-mm-dd
:owner:     Firstname Lastname
:reviewer:  Firstname Lastname
:approver:  Firstname Lastname
:toc:       macro
```

after the variables there is a mandatory empty line. 
The first text line has to load the load the template. 

```
include::template.adoc[]
```

After another empty line the document can start with a H2 or text. 

### Sentences
Each sentence should be start on a new line.  
Line breaks are indicated by a the plus sign (+) at the end of the line.  
This will help you to see the history of each sentences in git. 
It also helps to identify very long sentences. 

## Build documents with Docker
```
sudo docker build -t asciidoc-document-builder -f resources/Dockerfile .
sudo docker run --rm -v "$(pwd)":/data --name asciidoc-document-builder asciidoc-document-builder
```
The created files can be found in the output/ directory.
