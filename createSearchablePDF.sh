#!/bin/bash

run_install()
{
    echo "There are some required packages to continue. Packages are: ${requiredPackages[@]}"
    read -p "Do you want to install missing libraries? [Y/n]: " answer
    answer=${answer:=Y}
    if [[ $answer =~ [Yy] ]]
    then
      sudo apt-get install ${requiredPackages[@]}
    fi
}

requiredPackages=("libvips-tools" "tesseract-ocr")
## Run the run_install function if any of the libraries are missing
dpkg -s "${requiredPackages[@]}" >/dev/null 2>&1 || run_install

echo "You have all the required packages but it only supports English by default. "
echo "Check if tesseract-ocr supports your language (for example: tesseract-ocr-tur for Turkish)" 
echo "and install the language package by using: "
echo "(sudo) apt-get install tesseract-ocr-[YOUR_LANG_CODE]"
read -p "Do you wish to continue? (or will you install your language package?) [Y/n]: " answerToContinue
answerToContinue=${answerToContinue:=Y}

if [[ ! $answerToContinue =~ [Yy] ]]
then
  echo "Stopped executing script."
  exit 1
fi

read -p "> Enter the name of the pdf file (default \"input\"): " -e name_of_pdf
name_of_pdf=${name_of_pdf:=input}
read -p "> Enter page number of pdf file: " page_number
read -p "> Enter dpi of output (300 is suggested for OCR): " dpi
dpi=${dpi:=300}


if [ ! -d $(pwd)/output_of_pdf ]
then 
  mkdir output_of_pdf
  echo "Created a directory in current directory."
fi 

for ((i = 0; i < $page_number; i++)); do
  vips pdfload $name_of_pdf.pdf $(pwd)/output_of_pdf/page-$((i+1)).jpg --dpi $dpi --page $i
  echo "Page $((i+1)) saved as page-$((i+1)).jpg in output_of_pdf directory"
done

read -p "> Which language package (default \"eng\") do you want to use on tesseract-ocr: " tesseractLang
tesseractLang=${tesseractLang:=eng}

ls $(pwd)/output_of_pdf/*.jpg --format=single-column | sort --version-sort > images
tesseract images ${name_of_pdf}_searchable --dpi $dpi -l ${tesseractLang} pdf
rm -rf output_of_pdf
rm images
