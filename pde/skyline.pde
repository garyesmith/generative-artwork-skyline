
// SKYLINE 
// A ProcessingJS/Canvas code-generated cityscape by Gary Smith (https://www.genartive.com)
// For educational purposes only: please do not redistribute for profit unmodified.

int calcWidth=250; // theoretical canvas width to use for calculations
int calcHeight=250; // theoretical canvas height to use for calculations

// Initialize the canvas and draw the artwork elements
void setup() {

  // clear the background
  background(0,0,0,0);
  fill(0,0,0,0); 

  // there is no animating loop, just a static image
  noLoop(); 

  size(640,640);

  smooth(); // smooth rendering

  textAlign(CENTER,CENTER); // position text to be centered on x,y coords

  strokeJoin(ROUND);

  colorMode(HSB, 360, 100, 100); // set colour mode to HSB (Hue/Saturation/Brightness)

  background(0,0,100); // white  

  int hue1 = random(1,360); // main colour
  int hue2 = colorSplitComplementLeft(hue1); // left split complement to main colour
  int hue3 = colorSplitComplementRight(hue1); // right split complement to main colour

  // draw sky
  drawTexture('!', calcWidth*0.0200, 0.006, calcWidth*0.02, calcHeight*0.030, calcWidth*0.963, calcHeight*0.666, hue1, random(20,40), random(0,5), random(84,94), random(96,100));

  // draw treeline
  drawTreeline(calcWidth*0.015,calcHeight*random(0.52,0.72),calcWidth*0.972,calcHeight*0.2, color(hue1,25,32,180),calcWidth*0.003);

  // draw skyline
  drawSkyline(calcWidth*0.015,calcHeight*0.7,calcWidth*0.972,calcHeight*0.42, hue1, hue2, hue3);

  // add signature
  PFont fontA = loadFont("Courier New");
  textFont(fontA, scalePixelsX(calcWidth*0.032)); 
  fill(0,0,0,300);
  text("GES",scalePixelsX(calcWidth*0.941), scalePixelsY(calcHeight*0.968));

  // draw a white border frame around the final artwork
  drawPictureFrame();  

}

// Draw a textured rectangle composed of overlapping characters
//  char - character(s) to draw
//  xLeft - left x position of rectangle
//  yTop - top y position of rectangle
//  w - width of rectangle
//  h - height of rectangle
//  hue - base hue for color
//  startSat - starting saturation range for color
//  endSat - ending saturation range for color
//  startBri - staring brightness range for color
//  endBri - ending brightness range for color
void drawTexture(string char, float txtSize, float variance, float x1, float y1, float w, float h, int hue, int startSat, int endSat, int startBri, int endBri) {
 
  int dw=calcWidth*0.006;
  int dh=calcHeight*0.008;

  float numRows=h/dh;
  float dSat = (endSat-startSat)/numRows;
  float dBri = (startBri-endBri)/numRows;

  textSize(scalePixelsX(txtSize));

  noStroke();
  for (int x=x1; x<x1+w; x+=dw){
    float sat=startSat;
    float bri=startBri;
    for (int y=y1; y<y1+h; y+=dh) {      
      fill(color(hue,sat,bri));
      sat+=dSat;
      bri-=dBri;
      for (int i=0; i<6; i++) {
        text(char,scalePixelsX(x+calcWidth*random(-variance, variance)),scalePixelsY(y+calcWidth*random(-variance, variance)));
      }
    }
 }
}

// Draw multiple rows of overlapping skyscrapers, top to bottom, gradually growing larger
//  xLeft - left x position of the skyline area
//  yBot - bottom y position of the skyline area
//  w - width of the skyline area
//  h - height of the skyline area
//  tallest - tallest possible height for a building
//  hue1 - first color hue to use
//  hue2 - second color hue to use
//  hue3 - third color hue to use
void drawSkyline(float xLeft, float yBot, float w, float tallest, color hue1, color hue2, color hue3) {
  
  float x=xLeft-(calcWidth*random(0.005,0.050));
  float minW=calcWidth*0.04;
  float maxW=calcWidth*0.12;
  float growRatioY=1.25;
  float growRatioX=1.4;
  float txtSize=calcWidth*0.011;
  float sat=int(random(10,25));
  int dSat=int(random(5,15));
  float bri=80;
  int dBri=int(random(2,10));

  while (yBot<calcHeight*1.6) {
    while (x<(w-xLeft)) {
      float buildingWidth=random(minW,maxW);
      float buildingHeight=random(tallest*0.3,tallest);
      if (yBot>calcHeight*0.6 || random(0,10)>2) {
        drawBuilding(x, yBot-buildingHeight, buildingWidth, buildingHeight, sat, bri, hue1, hue2, hue3, txtSize);
      }
      x+=buildingWidth+random(buildingWidth*0.05,buildingWidth*0.25);
    }
    x=xLeft-(calcWidth*random(0.005,0.050));
    if (yBot<height && random(0,10)>7) {
      drawTreeline(calcWidth*0.015,yBot,calcWidth*0.972,calcHeight*0.2, color(hue1,sat*1.2,bri*0.35,240),calcWidth*0.003);    
    }    
    yBot*=growRatioY;
    tallest*=growRatioY;
    minW*=growRatioX;
    maxW*=growRatioX;
    sat+=dSat;
    sat=min(sat,100);
    bri-=dBri;
    bri=max(0,bri);
    txtSize*=growRatioX;
  }

}

// Draw a single skyscraper building
//  x - left x position of the building
//  y -  top y position of the building
//  w - width of the building
//  h - height of the building
//  colorSat - HSB saturation level of the color
//  colorBri - HSB brightness level of the color
//  hue1 - first color hue to use
//  hue2 - second color hue to use
//  hue3 - third color hue to use
//  txtSize - 
void drawBuilding(float x, float y, float w, float h, int colorSat, int colorBri, color hue1, color hue2, color hue3, float txtSize) {

  int[] hues = { hue1, hue2, hue3 };

  color baseColor=color(hues[round(random(0,1))],colorSat,colorBri,360);
  color highlightColor=color(hue1,colorSat,100,360);
  color blackColor=color(hues[round(random(0,2))],0,colorBri*0.40,360);

  textSize(scalePixelsX(txtSize));

  int skipRow=0;
  if (random(0,100)>82) {
    skipRow=int(random(4,10));
  }

  int colSize=0;
  int numCols = int(random(10,20));
  while (colSize<2) {
    colSize=ceil(w/numCols);
    numCols--;
  }
  int colPadding=ceil(colSize*0.05);
  w=colPadding+(numCols*colSize)+colPadding;

  int rowSize=0;
  int numRows=int(random(30,50));
  while (rowSize<2) {
    rowSize=ceil(h/numRows);
    numRows--;
  }
  int rowPadding=ceil(rowSize*0.05);
  h=rowPadding+(numRows*rowSize)+rowPadding;

  // draw base rectangle of building
  drawTexture("x", calcWidth*random(0.008, 0.025), 0.002, x, y, w, h, hue(baseColor), colorSat*0.8, colorSat*1.25, colorBri*1.75, colorBri*0.2);

  // draw a dark outline around the building
  strokeWeight(w*0.06);  
  stroke(blackColor);
  noFill();
  scaleRect(x, y, w, h);

  fill(baseColor);

  // use a narrower stroke for building details
  strokeWeight(w*0.015); 

  // draw building details in dark backing first
  fill(blackColor);
  float dx=x+colPadding;
  float dy=y+rowPadding;
  int row=0;
  while (dy<y+h-rowSize) {
    if (row>0 || random(0,100)<90) {
      if (!(skipRow && row%skipRow==0)) {
        while (dx<x+w-colSize) {
          if (colSize>3) {
            scaleRect(dx+colPadding,dy+rowPadding,colSize-colPadding*2,rowSize-rowPadding*2);
          } else {
            scaleText('H',dx+colPadding,dy+rowPadding);
          }
          dx+=colSize;
        }
      }
    }
    // occassionally, make the building narrower
    dy+=rowSize;
    dx=x+colPadding;
    row++; 
  }

  // overlay window backings with a highlight color
  fill(highlightColor);
  noStroke();  
  colPadding*=1.5;  
  rowPadding*=1.5;  
  float dx=x+colPadding;
  float dy=y+rowPadding;
  dy=y+rowPadding;
  dx=x+colPadding;
  row=0;
  while (dy<y+h-rowSize) {
    if (!(skipRow && row%skipRow==0)) {  
      while (dx<x+w-colSize) {
        if (colSize>3) {
          scaleRect(dx+colPadding,dy+rowPadding,colSize-colPadding*2,rowSize-rowPadding*2);
        } else {
          scaleText('-',dx+colPadding,dy+rowPadding);
        }
        dx+=colSize;
      }
    }
    dy+=rowSize;
    dx=x+colPadding;
    row++;
  }  

  // overlay larger window backings with random shadows
  char[] letters = {'#',',','$',';'};
  fill(color(0,0,0,260)); // black
  noStroke(); 
  textSize(scalePixelsX(txtSize*0.25));
  float dx=x+colPadding;
  float dy=y+rowPadding;
  dy=y+rowPadding;
  dx=x+colPadding;
  row=0;
  while (dy<y+h-rowSize) {
    if (!(skipRow && row%skipRow==0)) {  
      while (dx<x+w-colSize) {
        if (colSize>3 && random(0,10)>6) {
          scaleText(String(letters[int(random(1,letters.length))-1]),dx+colSize*0.5,dy+rowSize*0.5);
          scaleText(String(letters[int(random(1,letters.length))-1]),dx+colSize*0.5,dy+rowSize*0.5);
        }
        dx+=colSize;
      }
    }
    dy+=rowSize;
    dx=x+colPadding;
    row++;
  }    

  // overlay window backings with a bright flare
  fill(color(0,0,100,360)); // white
  noStroke(); 
  textSize(scalePixelsX(txtSize*0.25));
  float dx=x+colPadding;
  float dy=y+rowPadding;
  dy=y+rowPadding;
  dx=x+colPadding;
  row=0;
  while (dy<y+h-rowSize) {
    if (!(skipRow && row%skipRow==0)) {  
      while (dx<x+w-colSize) {
        if (colSize>2) {
          scaleText(String(letters[int(random(1,letters.length))-1]),dx+colSize*0.5,dy+rowSize*0.5);
          scaleText(String(letters[int(random(1,letters.length))-1]),dx+colSize*0.5,dy+rowSize*0.5);
        }
        dx+=colSize;
      }
    }
    dy+=rowSize;
    dx=x+colPadding;
    row++;
  }    

}

// Draw a line of trees
//  xLeft - left x position of treeline
//  yBot - bottom y position of treeline
//  w - width of treeline
//  maxcalcHeight - maximum high treeline can reach
//  ORA - color of treeline
//  blobSize - size of characters used to draw treeline elements
void drawTreeline(float xLeft, float yBot, float w, float maxcalcHeight, color ORA, void blobSize) {
  stroke(ORA);
  fill(ORA);
  textSize(scalePixelsX(calcWidth*0.0225));
  float mountaincalcHeight=round(maxcalcHeight*random(0.5,1));
  float mountainDelta=-4;
  for (x=xLeft; x<xLeft+w; x+=blobSize*0.8) {
    for (y=calcHeight; y>yBot-mountaincalcHeight; y-=blobSize*0.8) {
      if (random(0,100)>50) {
        text("*",scalePixelsX(x+calcWidth*random(-0.002,0.002)),scalePixelsY(y+calcWidth*random(-0.002,0.002))); 
      } else {
        text("^",scalePixelsX(x+calcWidth*random(-0.002,0.002)),scalePixelsY(y+calcWidth*random(-0.002,0.002))); 
      }
    }
    if (random(1,10)>4) {
      mountaincalcHeight+=mountainDelta;
    }
    if (mountaincalcHeight>maxcalcHeight) {
      mountaincalcHeight-=abs(mountainDelta);
      mountainDelta-=random(0,5);
    }
    if (mountaincalcHeight<(maxcalcHeight/2)) {
      mountaincalcHeight+=abs(mountainDelta);
      mountainDelta+=random(0,5);
    }
    if (random(1,10)>9) {
      mountainDelta+=random(-5,5);
    }
  }
}

// Return the left split complementary color for a given hue
//  hue - hue to split
color colorSplitComplementLeft(int h) {
  h+=150;
  h=h%360;
  return h;
}

// Return the right split complementary color for a given hue
//  hue - hue to split
color colorSplitComplementRight(int h) {
  h+=210;
  h=h%360;
  return h;
}

// Scale a horizontal (x) position on the canvas to the width of the canvas
// This allows calculations to be done independent of canvas size
//  px - The horizontal x position to scale
float scalePixelsX(px) {
  return int(px*(width/calcWidth));
}

// Scale a vertical (y) position on the canvas to the width of the canvas
// This allows calculations to be done independent of canvas size
//  py - The vertical y position to scale
float scalePixelsY(px) {
  return int(px*(height/calcHeight));
}

// Scale a rectangle's coordinates on the canvas to the width of the canvas
// This allows calculations to be done independent of canvas size
//  x - left x position of the rectangle
//  y - top y position of the rectangle
//  w - width of the rectangle
//  h - height of the rectangle
void scaleRect(float x, float y, float w, float h) {
  rect(scalePixelsX(x), scalePixelsY(y), scalePixelsX(w), scalePixelsY(h));
}

// Scale text coordinates on the canvas to the width of the canvas
//  txt - text string to render
//  x - left x position of the text
//  y - top y position of the text
void scaleText(string txt, float x, float y) {
  text(txt, scalePixelsX(x), scalePixelsY(y));
}

// Draw a white border frame around the final artwork
// Use characters to make the frame look a bit "ragged"
void drawPictureFrame() {
  fill(0,0,100,360);   
  noStroke();
  
  scaleRect(0,0,calcWidth,calcHeight*0.021);
  drawTexture('!', calcWidth*0.0200, 0.004, 0,0,calcWidth,calcHeight*0.021, 0, 0, 0, 100, 100);

  scaleRect(0,calcHeight*0.985,calcWidth,calcHeight*0.05);
  drawTexture('"', calcWidth*0.0200, 0.0014, 0,calcHeight*0.987,calcWidth,calcHeight*0.05, 0, 0, 0, 100, 100);

  scaleRect(0,0,calcWidth*0.017,calcHeight*1.01);
  drawTexture('!', calcWidth*0.0200, 0.004, 0,0,calcWidth*0.019,calcHeight*1.01, 0, 0, 0, 100, 100);

  scaleRect(calcWidth*0.982,0,calcWidth,calcHeight*1.1);
  drawTexture('!', calcWidth*0.0200, 0.004, calcWidth*0.982,0,calcWidth,calcHeight*1.1, 0, 0, 0, 100, 100);
}