# Foundations of Image Systems Engineering (FISE)
A book based on my Stanford class with Joyce Farrell (Psych 221)

## Quarto (from Posit)
The book is written using the [Quarto tools](https://quarto.org/).  

* Go to https://quarto.org/download/.
* Download the installer.
* Run the installer and follow the instructions.

After installation, verify by opening Command Prompt or PowerShell and typing "quarto check"

My attempts to control the Quarto and VSCode tools are described below.  Still learning.

### Quarto trouble
PDF file size is too big.  Not sure why it is that big.
The default github pages name is not being correctly taken from the yaml file.

### Quarto publishing to gh-pages

Lately I have been skipping the PDF and just publishing the HTML pages.  It is finding the code subdirectory.  Not sure about resources, but I don't seem to be doing much with that.

```
quarto render --to html
quarto publish gh-pages
```

## vscode (from uSoft)

The software for writing the book is implemented within [vscode](https://code.visualstudio.com/download).

Quarto has extensions for vscode to 
 * GitHub integration.
 * write quarto markdown (qmd)
 * chatgpt/copilot integration

## GitHub:  FISE-git

The GitHub directory organization is

_quarto.yml
chapters/
   images/
   resources/
code/    (refers to html renderings of code examples)
matlab/  (utility m-files that are used to prepare figures and other related tasks)

Formatting for the book is controlled by the _quarto.yml file. Further editing there is likely to be a good thing, as I learn more.

* The chapters directory contains the main qmd (quarto markdown) files.  
* The directory (images) contains the PNG files. 
* The directory (resources) contains additional qmd/html files that are of interest to me, but not the main thread of the book.  I link out to these from the chapter.

## Quarto:  Viewing

Inside VSCode, you can preview the book using several methods:

To preview in a browser just type into the command panel

   quarto preview

I do this a lot.

To preview in a window within VS Code

   Press Cmd+Shift+P (Mac)
   Select "Quarto: Preview Project"

Or the shortcut key:

   Press Ctrl+Shift+K (Windows/Linux) or Cmd+Shift+K (Mac)

I do this some.

There are probably other ways.  But these have been good.

## Quarto: book project

To create a new Quarto Book project in VS Code, you can:

Open the Command Palette (Press Ctrl+Shift+P on Windows/Linux or Cmd+Shift+P on Mac)
Type "Quarto: Create Project"
Select "Book Project" from the options
Choose a directory location for your new book project

## Quarto: resource files

I seem to have to make sure the resource files, which I write as qmd, are converted to html files. To do this, I run

   quarto render chapters/resources/file.qmd --to html

Also, perhaps I should be adding a pre-render command for these files (see below for the code/ files).

## Quarto:  Matlab files

(This section is unclear to me.  I have been just exporting HTML from the live script.  But perhaps I once did this and it was better).

For the Matlab code in code/*, I use "fise_exportMD" (liveScript) to generate a markdown file.  Then I let quarto render the Markdown. Apparently, I followed some instructions to put the command below into the main _quarto.yml file 

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

## Quarto: section labels

This must be in the format {#sec-XXXX} to work with indexing. I am not yet sure if this works only for chapters or for arbitrary sections.

## Quarto: images

I have not been able to get text to wrap around figures yet.  Will look for example from online books.

## Quarto referencing

I created a bib file  called paperpile.bib. I think this started in paperpile and went through Zotero.  This was pretty ugly.

I am now relying on paperpile.bib, and I edit it directly within VScode.  I have made various changes to it, and I add references to paperpile, use CMD-B to get the bibtex formatted reference, and place the new references in paperpile.bib.

I exported my Paperpile references into Zotero.  There are duplicates and the whole thing is OK but messy.  I tried to delete duplicates.  In principle, I could have just used the export from Paperpile.

I then exported those references using the betterbibtex method into paperpile.bib within FISE-git.  When we start up vscode, it reads in the bibliography and helps complete references when you type @XXXX.

I am trying this better-bibtex plugin.  Download, go to Tools -> plugin, select the Gear and choose install from file. https://retorque.re/zotero-better-bibtex/installation/

(I plan to use Zotero as the bibtex data management tool.  I tried BibDesk, but it did not work well for me.  Not sure why.)

## Quarto problems

I don't have wrapping around images or even scaling image sizes working yet.  I see it in other books, but not working yet for me.

# Converting prior files

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
* installing poppler using "brew install poppler".  This gets you pdftotext.
* Convert the pdf to text using (e.g., pdftotext -layout Principles_and_Consequences_Color.pdf PCC.txt)
* Convert the text to markdown (e.g., pandoc PCC.txt -t markdown -o PCC.md)

I then copied the md file into the repository so I could copy and paste the text easily into the book.
I will probably copy the figures in, too, at some point.

## Wordpress to Markdown

I used the Jekyll Export Tool that is a Wordpress plugin.  I simply installed the plugin and waited a few minutes.  It then exported all of the markdown pages from FOV.  They aren't quite right, but they were close enough to get me well launched.

# The Future - when it is ready for sharing

In addition to putting the book on GitHub pages at some point, we will probably deposit a PDF version on Stanford Digital Repository.

For the moment, I commented out the pdf formatting option.  That format and perhaps others will be useful in the future.

