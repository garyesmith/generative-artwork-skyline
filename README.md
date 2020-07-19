# Generative Artwork: "Skyline"

A Processing.js code-generated cityscape featuring skyscrapers and trees.

This is a simplified version of the code used to generate the Skyline artworks on https://www.genartive.com.

![Sample Skyline artwork](https://www.genartive.com/thumbs/skyline/350/803714956.png)

# Dependencies
Artwork is rendered to an HTML Canvas by a Processing.js script, which is the Javascript adaptation of the Processing language. 

More information and full documentation for the Processing.js library is at http://processingjs.org/.

# Usage
To run this code and generate a random artwork, simply open `index.html` in a modern web browser.

The `index.html` file includes a local copy of the Processing.js library (version 1.3.6) and then loads and runs the Processing.js code in `skyline.pde` via the `data-processing-sources` attribute on the HTML canvas element.

# Additional Details
Processing.js will automatically run the `setup()` function in the PDE file. This initializes the canvas and then calls additional functions to draw the various elements of the artwork, in this case, the sky, skyscrapers, windows, and trees. The exact number of elements and their relative positions and sizes are randomized through generous use of the Processing.js `random(min,max)` function, which ensures that every execution of this code generates a unique artwork.

This artwork uses the Processing.js `HSB` (Hue/Saturation/Brightness) color mode, as documented at http://processingjs.org/reference/colorMode_/. 

On each execution a "main" hue between 1 and 360 is chosen at random, and then [split complementary colours](https://www.tigercolor.com/color-lab/color-theory/color-harmonies.htm#:~:text=Split%2DComplementary,scheme%2C%20but%20has%20less%20tension) are generated from that main hue. This creates three harmonious hues for use in the artwork's colour palette. Each hue is modified further by adjusting its saturation and brightness.

Note that all calculations related to x and y coordinates, or widths and heights of elements, are scaled to the rendered size of the canvas. On [genartive.com](https://www.genartive.com) this enables me to seed the `random()` function with a fixed value and then regenerate the same artwork multiple times on canvases of any size. The logic for this seeding and resizing is not included in this simplified sample code.

# Usage Permissions
Please use this code for educational purposes, to satisfy your curiosity or to adapt parts or techniques for your own projects.

Do not redistribute this code unmodified in its entirety.

Do not redistribute or sell artworks generated from this code without significant modification.
