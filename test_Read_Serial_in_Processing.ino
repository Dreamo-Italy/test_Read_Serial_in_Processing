#include <eHealth.h>


int CON = 0;      // first analog sensor 
int RES = 0;      // second analog sensor
int CONV= 0;      // digital sensor
int inByte = 0;         // incoming serial byte

void setup() {
  // start serial port at 9600 bps:
  Serial.begin(9600);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }

  //establishContact();  // send a byte to establish contact until receiver responds
}
void loop() {
  
  float conductance = eHealth.getSkinConductance();
  float resistance = eHealth.getSkinResistance();
  float conductanceVol = eHealth.getSkinConductanceVoltage();

   if (Serial.available() > 0) 
   {
    // read first analog input:
    CON = conductance;
    // delay 10ms to let the ADC recover:
    delay(10);
    // read second analog input:
    RES = resistance;
    // read  switch
   CONV = conductanceVol;
    // send sensor values:
    Serial.write(CON);
    Serial.write(RES);
    Serial.write(CONV);
  }
  
    Serial.print("Conductance : ");       
    Serial.print(conductance, 2);  
    Serial.println("");         
  
    Serial.print("Resistance : ");       
    Serial.print(resistance, 2);  
    Serial.println("");    
  
    Serial.print("Conductance Voltage : ");       
    Serial.print(conductanceVol, 4);  
    Serial.println("");
  
    Serial.print("\n");
  
    delay(30);    //clock for reading the signal        
 }


/*void establishContact() {
  while (Serial.available() <= 0) {
    Serial.print('A');   // send a capital A
    delay(30);
  }
}*/
