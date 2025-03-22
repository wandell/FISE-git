# Foundations of Image Systems Engineering
Draft of Foundations of Image Systems Engineering, based on my Stanford class with Joyce Farrell (Psych 221)

This repository contains chapters and control files (yml) needed to assemble the book.  The main text is in a directory called chapters.
Default formatting parameters for HTML are in the _quarto.yml file as well.  More could be done.

The directory organization for the chapters, images and some resources is

chapters/
   images/
   resources/
code/    (refers to html renderings of code examples)
matlab/  (refers to live scripts that become rendered code examples)

## Quarto:  Viewing

Inside VS Code, you can preview your Quarto book using either of these methods:

   Press Ctrl+Shift+P (Windows/Linux) or Cmd+Shift+P (Mac)
   Type "Quarto: Preview Project"
   Select it to start the preview

Or the shortcut key:

   Press Ctrl+Shift+K (Windows/Linux) or Cmd+Shift+K (Mac)

To preview in a browser just type into the command panel

   quarto preview
   
## The future
In addition to putting the book on GitHub pages at some point, we will probably deposit a PDF version on Stanford Digital Repository.
For the moment, I commented out the pdf formatting option.  That format and perhaps others will be useful in the future.

## vscode
I downloaded vscode.  There are some quarto extensions to install.  It also has a convenient plugin for managing the FISE-git repository.  I am just starting to use it.

For a while, however, I preferred to use the GitHub Desktop to manage this repository.  Partly this is because I couldn't figure out how to use my GitHub passkey to connect from vscode. I can now.


## Quarto

We are writing this book in Quarto from POSIT.  Downloading Quarto for Mac was easy and good.  Downloading vscode, installing the Quarto extension, was good.  

## Quarto: book project

To create a new Quarto Book project in VS Code, you can:

Open the Command Palette (Press Ctrl+Shift+P on Windows/Linux or Cmd+Shift+P on Mac)
Type "Quarto: Create Project"
Select "Book Project" from the options
Choose a directory location for your new book project

## Quarto: resource files

I seem to have to make sure the resource files are created as html files. To do this, I run

   quarto render chapters/resources/file.qmd --to html

For some period of time, the resources files were in the root directory.  I moved them into the chapters/ directory.  Claude says I should be able to keep them in root, but it just wasn't working for me.  

Also, perhaps I should be adding a pre-render command for these files (see below for the code/ files).

For the Matlab code in matlab/*, I use "fise_exportMD" (liveScript) to generate a markdown file.  Then I let quarto render the Markdown? Apparently, I followed some instructions to put the command below into the main _quarto.yml file 

```
project:
  type: book
  pre-render: 
    - "quarto render code/*.md --to html"
  render: 
     - "code/*.md"
```
  
and inside of code/ there is an additional _quarto.yml file and an index.qmd. Not sure why those are needed, but Claude told me to do it and I haven't really debugged to see what I can get rid of. It appears that Quarto renders the markdown file when I preview and it brings up the livescript in a window nicely enough for now.  

(In the past, I had to move the _files directory into the _book directory by hand until we figure out the proper way.  Maybe what I did for 'code' should work for these additional files? Also, the resources/files.qmd need to be in the _quarto.yml file.  But none of that appears to be true at the moment).

## Quarto section labels

This must be in the format {#sec-XXXX} to work with the bibliography (?).  I am not yet sure if this works only for chapters or for arbitrary sections.

## Quarto images

I am putting the png files in the chapters/images directory, organized by chapter.

I have not been able to get text to wrap around figures yet.  Will look for example from online books.

## Quarto referencing

I will start putting the bib file in a references directory.  I plan to use Zotero as the bibtex data management tool.  I tried BibDesk, but it did not work well for me.  Not sure why.

I exported my Paperpile references into Zotero.  There are duplicates and the whole thing is OK but messy.  I tried to delete duplicates.  In principle, I could have just used the export from Paperpile.

I then exported those references using the betterbibtex method into paperpile.bib within FISE-git.  When we start up vscode, it reads in the bibliography and helps complete references when you type @XXXX.

I am trying this better-bibtex plugin.  Download, go to Tools -> plugin, select the Gear and choose install from file. https://retorque.re/zotero-better-bibtex/installation/

## Quarto problems

I don't have wrapping around images or even scaling image sizes working yet.  I see it in other books, but not working yet for me.

# Converting files

I have been using resources from my prior work, including class notes and published papers.  This has involved file type conversion.  Here are notes.

## Google doc
I saved a Google doc chapter (Artal handbook chapter on displays) as an HTML zip file.  Google produced both the HTML and the images directory for the HTML, within the zip file.
I then used pandoc to convert the HTML to markdown.

    pandoc CharacterizationofVisualStimuli_Version2_.html -o characterization.md

I then moved the md file to qmd.  And I added the YAML header

```
---
title: "My Report"
format: html
---
```

The figures appeared in the subdirectory.  The math and images rendered in vscode from the md file with the quarto preview command.

## Overleaf
I also managed to download an Overleaf LaTeX project  (20250102 in the Ashby Book Chapter) and then run on the master tex file

  pandoc Chapter1Master.tex -t markdown -o PCC.md

That produced an md file. I renamed 'qmd' and put in vscode.  It came up well, with the equations and figure captions.  I don't remember how I created the directory with the image files.

## PDF
I have been trying to use pandoc to convert some of my published review papers into markdown from pdf.  On the mac this involved 

* installing pandoc from their github repository, (https://github.com/jgm/pandoc/releases/tag/3.6.1)
* installing poppler using "brew install poppler".  This gets you pdf2text.
* Convert the pdf to text using (e.g., pdftotext -layout Principles_and_Consequences_Color.pdf PCC.txt)
* Convert the text to markdown (e.g., pandoc PCC.txt -t markdown -o PCC.md)

I then copied the md file into the repository so I could copy and paste the text easily into the book.
I will probably copy the figures in, too, at some point.

## Wordpress to Markdown
I used the Jekyll Export Tool that is a Wordpress plugin.  I simply installed the plugin and waited a few minutes.  It then exported all of the markdown pages from FOV.  They aren't quite right, but they were close enough to get me well launched.

