#!/bin/bash

rm -rf output/
mkdir output/

for FOLDER in 0*; do
  mkdir -p output/$FOLDER
  for FILE in $FOLDER/*.adoc; do
    FILENAME=$(basename "$FILE" .adoc)
    
    # Create "pretty" cover page
    DOCUMENT_TITLE=$(grep "^= " "$FILE" | cut -d' ' -f2-)
    VERSION=$(grep "^:version:" "$FILE" | awk '{print $2}')
    DATE=$(grep "^:date:" "$FILE" | awk '{print $2}')
    OWNER=$(grep "^:owner:" "$FILE" | awk '{print $2, $3}')
    REVIEWER=$(grep "^:reviewer:" "$FILE" | awk '{print $2, $3}')
    APPROVER=$(grep "^:approver:" "$FILE" | awk '{print $2, $3}')
    cp resources/coverpage.tex coverpage.tex
    sed -i "s/VAR_DOCUMENT_NAME/$DOCUMENT_TITLE/" coverpage.tex
    sed -i "s/VAR_DOCUMENT_VERSION/$VERSION/" coverpage.tex
    sed -i "s/VAR_DOCUMENT_DATE/$DATE/" coverpage.tex
    sed -i "s/VAR_DOCUMENT_OWNER/$OWNER/" coverpage.tex
    sed -i "s/VAR_DOCUMENT_REVIEWER/$REVIEWER/" coverpage.tex
    sed -i "s/VAR_DOCUMENT_APPROVER/$APPROVER/" coverpage.tex
    xelatex coverpage.tex
    
    # Create document, remove first page (aka ugly cover page) from document, combining the new cover page (aka pretty cover) with the content pages, delete temporary files
    asciidoctor-pdf -v -a pdf-fontsdir="resources;GEM_FONTS_DIR" -a pdf-theme=resources/custom-theme.yml -o output/$FOLDER/${FILENAME}-full.pdf "$FILE"
    pdftk output/$FOLDER/${FILENAME}-full.pdf cat 2-end output output/$FOLDER/${FILENAME}-content.pdf
    pdftk coverpage.pdf output/$FOLDER/${FILENAME}-content.pdf cat output output/$FOLDER/${FILENAME}.pdf
    
    rm output/$FOLDER/${FILENAME}-content.pdf output/$FOLDER/${FILENAME}-full.pdf coverpage.pdf coverpage.tex coverpage.aux coverpage.log 
  done
done

chmod -R 777 output/
