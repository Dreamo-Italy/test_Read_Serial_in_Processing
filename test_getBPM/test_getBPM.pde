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
  
import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
BeatDetect beat;
Bpm bpmo;

float eRadius;
int initTime, counter;
int BPM1=0;

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
  
}

void draw()
{
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