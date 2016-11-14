/**
  * This sketch demonstrates how to use the BeatDetect object song SOUND_ENERGY mode.<br />
  * You must call <code>detect</code> every frame and then you can use <code>isOnset</code>
  * to track the beat of the music.
  * <p>
  * This sketch plays an entire song, so it may be a little slow to load.
  * <p>
  * For more information about Minim and additional features, 
  * visit http://code.compartmental.net/minim/
  */
import processing.serial.*;  
import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
BeatDetect beat;
Bpm bpmo;

float eRadius;
int initTime, counter;
int BPM1=0;

//varialbes for serial communication
Serial myPort;  // Create object from Serial class
//values given by the galvanic skin response
// GSR[0] is CON, GSR[1] is RES, GSR[2] is CONV
int GSR[]={0,0,0};     // Data received from the serial port


void setup()
{
  size(200, 200, P2D);
  bpmo = new Bpm();
  minim = new Minim(this);
  song = minim.loadFile("song.mp3", 2048);
  song.play();
  // a beat detection object song SOUND_ENERGY mode with a sensitivity of 10 milliseconds
  beat = new BeatDetect(song.bufferSize(), song.sampleRate());
  
  bpmo.setInitTime(millis());
  bpmo.setCounter(0);
  
  ellipseMode(RADIUS);
  eRadius = 20;
  frameRate(30);
  beat.setSensitivity(400);
  
  
  // I know that the first port in the serial list on my mac
  // is Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
  
}

void draw()
{
  
  if ( myPort.available() > 0) 
  {  // If data is available,
  GSR[0] = myPort.read();         // read it and store it in GSR[0]
  GSR[1] = myPort.read();         // read it and store it in GSR[1]
  GSR[2] = myPort.read();         // read it and store it in GSR[2]

  } 
  println(GSR[0]); //print it out in the console
  println(GSR[1]);
  println(GSR[2]);
  
  background(0);
  beat.detect(song.mix);
  float a = map(eRadius, 20, 80, 60, 255);
  fill(60, 255, 0, a);
  if ( beat.isRange(1,1,1) ) { 
    eRadius = 80;
    bpmo.incrementCounter(); 
  }
  
  ellipse(width/2, height/2, eRadius, eRadius);
  eRadius *= 0.95;
  
  if ( eRadius < 20 ) eRadius = 20;
  BPM1 = bpmo.getBPM( 1500 );
  //println(bpmo.timeLength);
  //BPM1 = getBPM(1000,initTime,counter);
  //      println("outside"+initTime);
  

  
}