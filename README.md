# Foundations of Image Systems Engineering
Draft of a book on Image Systems Engineering, based on my Stanford class with Joyce Farrell (Psych 221)

In addition to putting the book on GitHub pages at some point, we will probably deposit a PDF version on Stanford Digital Repository.

This repository contains the chapters and control files (yaml) needed to assemble the book.  These are in a directory called chapters.
Many default formatting parameters for HTML are in the _quarto.yml file as well.

For the moment, I commented out the pdf formatting option.  That and perhaps others will be useful in the future.

The model repository we are starting from is the one for Michael Frank's book.  He has been a resource.

## Wordpress to Markdown
I used the Jekyll Export Tool that is a Wordpress plugin.  I simply installed the plugin and waited a few minutes.  It then exported all of the markdown pages from FOV.  They aren't quite right, but they were close enough to get me well launched.

## vscode
I downloaded vscode.  There are some quarto extensions to install.

I also installed the GitHub extension to vscode, but I preferred to use the GitHub Desktop to manage this repository.  Partly this is because I couldn't figure out how to use my GitHub passkey to connect from vscode.  Someday, though, I should make this work.

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

To preview in a browser just type into the command panel

   quarto preview

## Quarto: resource files

One way to make sure you have the html files is to do this

   quarto render resources/file.qmd --to html

For the Matlab code in code/*, I use fise_exportMD(liveScript) to generate a markdown file.  Then I let quarto render it because I followed some instructions to put this into the main_quarto.yml file 

```
project:
  type: book
  pre-render: 
    - "quarto render code/*.md --to html"
  render: 
     - "code/*.md"
```
  
and inside of code/ there is an additional _quarto.yml file and an index.qmd. Not sure why those are needed, but Claude told me to do it and I haven't really debugged to see what I can get rid of. It appears that Quarto renders the markdown file when I preview and it brings up the livescript in a window nicely enough for now.

For the resources, I have to move the created _files directory into the _book directory by hand until we figure out the proper way.  Maybe what I did for 'code' should work for these additional files?
Also, the resources/files.qmd need to be in the _quarto.yml file

## Quarto section labels

This must be in the format {#sec-XXXX} to work with the bibliography (?).  I am not yet sure if this works only for chapters or for arbitrary sections.

## Quarto images

I am putting the png files iin the images directory, organized by chapter.

## Quarto referencing

I will start putting the bib file in a references directory.  I plan to use Zotero as the bibtex data management tool.  I tried BibDesk, but it did not work well for me.  Not sure why.

I exported my Paperpile references into Zotero.  There are duplicates and the whole thing is OK but messy.  I tried to delete duplicates.  In principle, I could have just used the export from Paperpile.

I then exported those references using the betterbibtex method into paperpile.bib within FISE-git.  When we start up vscode, it reads in the bibliography and helps complete references when you type @XXXX.

I am trying this better-bibtex plugin.  Download, go to Tools -> plugin, select the Gear and choose install from file. https://retorque.re/zotero-better-bibtex/installation/

## Quarto problems

I don't have wrapping around images or even scaling image sizes working yet.  I see it in other books, but not working yet for me.

# Pandoc
I have been trying to use pandoc to convert some of my published review papers into markdown from pdf.  On the mac this involved 

  (a) installing pandoc from their github repository, (https://github.com/jgm/pandoc/releases/tag/3.6.1)
  (b) installing poppler using "brew install poppler".  This gets you pdf2text.
  (c) Convert the pdf to text using (e.g., pdftotext -layout Principles_and_Consequences_Color.pdf PCC.txt)
  (d) Convert the text to markdown (e.g., pandoc PCC.txt -t markdown -o PCC.md)

  I then copied the md file into the repository so I could copy and paste the text easily into the book.
  I will probably copy the figures in, too, at some point.
  
I also managed to download an Overleaf LaTeX project and run (20250102 in the Ashby Book Chapter)

  pandoc Chapter1Master.tex -t markdown -o PCC.md

That produced an md file that I renamed 'qmd' and put in vscode.  
It came up well, with the equations and figure captions.  I did not insert the images, though that should be possible.


