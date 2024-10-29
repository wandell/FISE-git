# Foundations of Image Systems Engineering
Draft of a book on Image Systems Engineering, based on my Stanford class with Joyce Farrell (Psych 221)

In addition to putting the book on GitHub pages at some point, we will probably deposit a PDF version on Stanford Digital Repository.

This repository contains the chapters and control files (yaml) needed to assemble the book.  These are in a directory called chapters.
Many default formatting parameters for HTML are in the _quarto.yml file as well.

For the moment, I commented out the pdf formatting option.  That and perhaps others will be useful in the future.

The model repository we are starting from is the one for Michael Frank's book.  He has been a resource.

## Wordpress to Markdown

I usewd the Jekyll Export Tool that is a plugin.  I simply installed the plugin and waited a few minutes.  It then exported all of the markdown pages from FOV.  They aren't quite right, but they were close enough to get me well launched.

## vscode
I installed the GitHub extension to vscode, but I preferred to use the GitHub Desktop to manage this repository.  Partly this is because I couldn't figure out how to use my GitHub passkey to connect from vscode.  Someday, though, I should make this work.

I have not been able to get text to wrap around figures yet.  Will look for example from online books.

## Quarto

We are writing this book in Quarto from POSIT.  Downloading Quarto for Mac was easy and good.  Downloading vscode, installing the Quarto extension, was good.  

## Quarto: book project

    To create a new Quarto Book project in VS Code, you can:

Open the Command Palette (Press Ctrl+Shift+P on Windows/Linux or Cmd+Shift+P on Mac)
Type "Quarto: Create Project"
Select "Book Project" from the options
Choose a directory location for your new book project

## Quarto:  Viewing

Inside VS Code, you can preview your Quarto book using either of these methods:

   Press Ctrl+Shift+P (Windows/Linux) or Cmd+Shift+P (Mac)
   Type "Quarto: Preview Project"
   Select it to start the preview

Or the shortcut key:

   Press Ctrl+Shift+K (Windows/Linux) or Cmd+Shift+K (Mac)

To preview in a browser just use

   quarto preview

## Quarto: resource files

   quarto render resources/file.qmd --to html

You will have to move the created _files directory into the _book directory by hand until we figure out the proper way.
Also, the resources/files.qmd need to be in the _quart.yml file

## Quarto section labels

This must be {#sec-XXXX} to work with the bibliography


## Quarto images

I am putting the png files iin the images directory, organized by chapter.

## Quarto referencing

I will start putting the bib file in a references directory.  I plan to use Zotero as the bibtex data management tool.  I tried BibDesk, but it did not work well for me.  Not sure why.

I exported my Paperpile references into Zotero.  There are duplicates and the whole thing is OK but messy.  I tried to delete duplicates.  In principle, I could have just used the export from Paperpile.

I then exported those references using the betterbibtex method into paperpile.bib within FISE-git.  When we start up vscode, it reads in the bibliography and helps complete references when you type @XXXX.

I am trying this better-bibtex plugin.  Download, go to Tools -> plugin, select the Gear and choose install from file. https://retorque.re/zotero-better-bibtex/installation/

## Quarto problems

I don't have wrapping around images or even scaling image sizes working yet.  I see it in other books, but not working yet for me.



