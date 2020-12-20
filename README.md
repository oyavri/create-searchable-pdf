# createSearchablePDF

A script to create searchable pdf from a pdf full of images

----
One of my friends wanted to make a pdf searchable so I created this script. Probably it's not the best way to do it. Since it uses a lot of space, I don't recommend it to anyone but it could be useful if it's your last resort.

## How to use it?

It only works with Ubuntu-like Linux distros. You have to give the permission to execute it.

```sh
$ chmod +x $(pwd)/createSearchablePDF.sh
```

After giving the permission, you can follow the directions that given by the script. 

## What does the script do?

It downloads some packages (Tesseract-OCR and Vips-tools). Creates a temporary folder for pdf's images then uses OCR on them. After creating the searchable pdf, deletes the temporary folder.

Feel free to make contributions! 

## License
----
MIT
