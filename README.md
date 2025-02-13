# LaTeX Workshop Materials – Colorado State University  

This repository contains the materials for the LaTeX workshop at Colorado State University. The workshop introduces students to **LaTeX** and **Beamer**, covering file setup, writing LaTeX code, and automating the integration of tables and figures generated in **R**.  

## Software Installation  

Before starting the workshop, students need to install LaTeX on their computer. We recommend the following distributions:  

- **Windows**: [MiKTeX](https://miktex.org/download)  
- **Mac**: [MacTeX](https://tug.org/mactex/)  

Both distributions include everything needed to compile LaTeX documents.  

For editing LaTeX files, you can also use powerful text editors. A very popular editor for this is **Sublime Text**, which is available for download at [https://www.sublimetext.com/download](https://www.sublimetext.com/download). To enable LaTeX support in Sublime Text, students should also install the **LaTeXTools** package:  

1. Open Sublime Text and press `Ctrl+Shift+P` (Windows/Linux) or `Cmd+Shift+P` (Mac).  
2. Type `"Package Control: Install Package"` and select it.  
3. Search for `"LaTeXTools"` and install it.
4. You now can open LaTeX files in Sublime Text and compile them with `Ctrl+B` (Windows/Linux) or `Cmd+B` (Mac).
5. [Skim](http://skim-app.sourceforge.net/) (for Mac) and [Sumatra PDF](http://blog.kowalczyk.info/software/sumatrapdf/download-free-pdf-viewer.html) (for Windows) automatically scan the PDF for updates and reload once you compile a LaTeX document with an open PDF. For Skim you need to open Preferences -> Sync and then set the PDF_Tex Sync Preset to Sublime Text.

With these installations, students will have a complete LaTeX setup ready for the workshop.  


## Repository Structure  

### `manuscript/`  
Contains `manuscript.tex` and three subfolders:  
- **`chapters/`** – Stores individual chapter files.  
- **`figures/`** – Holds figure files referenced in the manuscript.  
- **`tables/`** – Includes tables generated for the manuscript.  
- `manuscript.tex` demonstrates how to structure a LaTeX document and link figures, tables, and chapters from these subfolders.*
- **`csu_thesis/`** – Includes a `.tex` and a `.sty` file matching the formating requirements for a thesis/dissertation at CSU.   


### `scripts/`  
Includes an **R script** that generates a table and a graph using data from the **2020 ANES Pilot Study**, which are then automatically integrated into the LaTeX document.  

### `resources/`  
Provides additional materials, including:  
- **`bibliography/`** – Contains the **APSR** citation style file and an example `.bib` file.  
- **Snippets** for **Sublime Text** to assist with LaTeX coding.  
- **Templates** for Beamer presentations and manuscript writing.  

## How to Download and Unpack the Repository  

To download all files from this repository and unpack them as a folder on your computer:  

1. Click the **"Code"** button at the top of this repository.  
2. Select **"Download ZIP"** and save the file to your computer.  
3. Locate the downloaded `.zip` file and extract it using:  
   - **Windows**: Right-click the file and select **"Extract All"**.  
   - **Mac**: Double-click the file to extract it.  
4. Open the extracted folder to access all workshop materials.  

## Using Overleaf and Dropbox Sync  

If you prefer to write in LaTeX using Overleaf, you can easily upload the files from this repository to your Overleaf project. Overleaf also offers **Dropbox synchronization**, allowing you to edit LaTeX files locally while keeping them updated in Overleaf. To enable this, link your Overleaf account to Dropbox by going to **Account Settings > Linked Accounts > Dropbox**. Once linked, Overleaf will create a folder in Dropbox where you can add or modify files, and changes will automatically sync between Overleaf and Dropbox. This is a great way to integrate Overleaf with local editing tools like Sublime Text while ensuring your work is backed up and accessible across devices. It also allows you to automatically upload tables and graphs you produce locally. Generate a figures and a tables folder in the Overleaf Dropbox folder and write your files from R to these folders. 
