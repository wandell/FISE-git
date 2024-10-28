# Foundations of Image Systems Engineering
Draft of a book on Image Systems Engineering, based on my Stanford class with Joyce Farrell (Psych 221)

In addition to putting the book on GitHub pages at some point, we will probably deposit a PDF version on Stanford Digital Repository.

This repository contains the chapters and control files (yaml) needed to assemble the book.  These are in a directory called chapters.
Many default formatting parameters for HTML are in the _quarto.yml file as well.

For the moment, I commented out the pdf formatting option.  That and perhaps others will be useful in the future.

The model repository we are starting from is the one for Michael Frank's book.  He has been a resource.

## Wordpress to Markdown:  pandoc

To convert the Wordpress files I used Tools -> Export to create some XML data and then I downloaded pandoc.
In process of converting the FOV pages.  There was no need to convert the FISE pages because there were only a few.
This comment should probably be on the FOV-2024-git README.

Here is the [Pandoc User's Guide])https://pandoc.org/MANUAL.html)

Key command for HTML to Markdown is there.  Getting the HTML out of the XML download is

For each WordPress page in the XML export, there should typically be just **one `<content:encoded>` tag** containing the full HTML content of that page or post. This tag encapsulates all the HTML needed for that specific piece of content, including any headings, paragraphs, images, and embedded media.

However, there are a few exceptions:
- **Shortcodes**: WordPress shortcodes may appear in the HTML content if you’ve used custom blocks or plugins (e.g., for galleries, forms). These shortcodes will export as plain text within the HTML and may need manual cleanup or processing.
- **Custom Fields or Embeds**: Sometimes, additional fields or embeds might be stored outside `<content:encoded>` if they come from specific plugins or custom page templates. 

So, while you'll likely have only one HTML block per page or post in `<content:encoded>`, it’s wise to inspect the XML for any additional embedded data or custom tags that might also be relevant to your Quarto setup.

## vscode
I installed the GitHub extension to vscode, but I preferred to use the GitHub Desktop to manage this repository.  Partly this is because I couldn't figure out how to use my GitHub passkey to connect from vscode.  Someday, though, I should make this work.

I have not been able to get text to wrap around figures yet.  Will look for example from online books.

## Quarto

We are writing this book in Quarto from POSIT.  Downloading Quarto for Mac was easy and good.  Downloading vscode, installing the Quarto extension, was good.  

## Quarto commands

To create a Quarto book in vscode, after installing the Quarto extension,

    To create a new Quarto Book project in VS Code, you can:

Open the Command Palette (Press Ctrl+Shift+P on Windows/Linux or Cmd+Shift+P on Mac)
Type "Quarto: Create Project"
Select "Book Project" from the options
Choose a directory location for your new book project

Inside VS Code, you can preview your Quarto book using either of these methods:

Press Ctrl+Shift+P (Windows/Linux) or Cmd+Shift+P (Mac)
Type "Quarto: Preview Project"
Select it to start the preview

Or the shortcut key:

Press Ctrl+Shift+K (Windows/Linux) or Cmd+Shift+K (Mac)

## Quarto images

I am putting the png files iin the images directory, organized by chapter.

## Quarto referencing

I will start putting the bib file in a references directory.  I plan to use Zotero as the bibtex data management tool.  I tried BibDesk, but it did not work well for me.  Not sure why.

I exported my Paperpile references into Zotero.  There are duplicates and the whole thing is OK but messy.  I tried to delete duplicates.  In principle, I could have just used the export from Paperpile.

I then exported those references using the betterbibtex method into paperpile.bib within FISE-git.  When we start up vscode, it reads in the bibliography and helps complete references when you type @XXXX.

I am trying this better-bibtex plugin.  Download, go to Tools -> plugin, select the Gear and choose install from file. https://retorque.re/zotero-better-bibtex/installation/

## Quarto problems

The _quarto.yml file has the supplemental files in 'appendices'.  I would rather have them just be supplemental, and not show up in the TOC.

I don't have wrapping around images or even scaling image sizes working yet.  I see it in other books, but not working yet for me.



