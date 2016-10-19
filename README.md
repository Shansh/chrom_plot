# chrom_plot
This repo contains source code and supplementary files for [Chromatography plot] (https://shansh.shinyapps.io/chrom/) shiny application.

Overview
--------

This application is the result of observed discrepancies in the image exporting resolution, from chromatography analytical devices, and the high quality image requirements in scientific journals. The most common exporting resolution from devices is 72 dpi, while journal requirements for black-white images are in the range of 300 - 1200 dpi. This application imports **time** and **signal** values from `.csv` dataset and produce downloadable plot in desired resolution range. 

Preparing dataset
-------

Each analytical device should have some kind of textual export system. For example, for Agilent's Data Analysis software the exporting path would be File/Export File/CSV File... In the next dialog you should select **signal** radio button and check **Write to Clipboard** check-box. Then paste data into new **Notepad** page, just to clean-up any unwanted formatting, select all and copy again. Last step would be pasting data into **Excel** and saving document as Comma-separated-value (.csv). Whole this process, with supporting images included, has been described in this [Presentation](http://rpubs.com/shansh/chromplot).

Instructions
-------

Upload csv. file and wait for plotting result. Adjust `x` and `y` axes according to your **Retention time** and **Signal abundance** (sliders). Through input fields, adjust desired resolution, ordinate caption and image dimensions. NOTE: If chosen resolution is 300 dpi, image dimensions should be about 4000x2000 px, twice larger resolution of 600 dpi requires about twice larger image dimensions (8000x4000 px), and so on. When you are fully satisfied with plot look, click **Download plot** button and save your `tiff` image. Example datasets and source code are available in [chrom_plot](http://github.com/Shansh/chrom_plot) repository.
