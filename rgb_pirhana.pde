/**
 * Subtractive Color Wheel 
 * by Ira Greenberg. 
 * Tint routine modified by Miles DeCoster
 * 
 * The primaries are red, yellow, and blue. The secondaries are green, 
 * purple, and orange. The tertiaries are  yellow-orange, red-orange, 
 * red-purple, blue-purple, blue-green, and yellow-green.
 *
 * Updated 10 January 2013.
 
 * Arduino Serial Interface to RGB LED
 * by Rishi F.
 * 
 * Transmits RGB packet over serial port to Arduino UNO3 board
 * to which a Piranha RGB LED is connected to the PWM pins. Find the 
 * 
 *
 * Updated 5 December 2013
 */

import processing.serial.*;

int segs = 12;
int steps = 6;
float rotAdjust = TWO_PI / segs / 2;
float radius;
float segWidth;
float interval = TWO_PI / segs;

color bc =  color(0, 0, 0);
byte [] rgbdata = new byte[64];


Serial ardPort;

void setup() {

  size(600, 600);
  background(0);
  smooth();
  ellipseMode(RADIUS);
  noStroke();

  // make the diameter 90% of the sketch area
  radius = min(width, height) * 0.45;
  segWidth = radius / steps;

  println(Serial.list());
  ardPort = new Serial(this, Serial.list()[3], 9600);

  drawTintWheel();
}

void draw() {
  // rectMode(CORNER);
  bc = get(mouseX, mouseY);
  println("R G B = " + int(red(bc)) + " " + int(green(bc)) + " " + int(blue(bc)));
  rgbdata[0] = (byte(int(red(bc))));
  rgbdata[1] = (byte(int(green(bc))));
  rgbdata[2] = (byte(int(blue(bc))));

  // hold the last value when mouse moves away from the wheel
  if ((rgbdata[0] ^ rgbdata[1] ^ rgbdata[2]) != 0) {
    ardPort.write(rgbdata[0]);
    ardPort.write(rgbdata[1]);
    ardPort.write(rgbdata[2]);
  }
}



void drawTintWheel() {
  for (int j = 0; j < steps; j++) {
    color[] cols = { 
      color(255, 255, ((255/(steps-1))*j)), 
      color(255, ((170)+(170/steps)*j), 255/steps*j), 
      color(255, ((127)+(127/steps)*j), (255/steps)*j), 
      color(255, ((102)+(102/(steps-2))*j), (255/steps)*j), 

      color(255, (255/steps)*j, ((255)/steps)*j), 
      color(255, (255/steps)*j, ((127)+(127/steps)*j)), 
      color(255, (255/steps)*j, 255), 
      color(((127)+(127/steps)*j), (255/steps)*j, 255), 

      color(((255)/steps)*j, (255/steps)*j, 255), 
      color((255/steps)*j, 255, ((102)+(102/steps)*j)), 
      color((255/(steps))*j, 255, (255/(steps))*j), 
      color(((127)+(127/steps)*j), 255, (255/steps)*j)
    };
    for (int i = 0; i < segs; i++) {
      fill(cols[i]);
      arc(width/2, height/2, radius, radius, 
      interval*i+rotAdjust, interval*(i+1)+rotAdjust);
    }
    radius -= segWidth;
  }
}