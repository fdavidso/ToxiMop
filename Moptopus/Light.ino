#include <arduino.h>
#include "Light.h"

Light::Light() {
   r0 = 0;      //value of select pin at the 4051 (s0)
   r1 = 0;      //value of select pin at the 4051 (s1)
   r2 = 0;      //value of select pin at the 4051 (s2)
   photocellPin = 0; // the cell and 10K pulldown are connected to a0
}

Light::Light(int analoguePin) {
   r0 = 0;      //value of select pin at the 4051 (s0)
   r1 = 0;      //value of select pin at the 4051 (s1)
   r2 = 0;      //value of select pin at the 4051 (s2)
   photocellPin = analoguePin; // the cell and 10K pulldown are connected to a0
}

float Light::readLightSensor(int lightID)
{
    float lightSensorValue=0.00;
 
    Serial.print("Light id = ");
    Serial.print(lightID);
    Serial.println("");
 
    r0 = bitRead(lightID,0);    // use this with arduino 0013 (and newer versions)    
    r1 = bitRead(lightID,1);    // use this with arduino 0013 (and newer versions)    
    r2 = bitRead(lightID,2);    // use this with arduino 0013 (and newer versions)    

    digitalWrite(2, r0);
    digitalWrite(3, r1);
    digitalWrite(4, r2);

    //Either read or write the multiplexed pin here

    photocellReading = analogRead(photocellPin);
    //Serial.print("Analog reading = ");
    //Serial.println(photocellReading); // the raw analog reading
    // LED gets brighter the darker it is at the sensor
    // that means we have to -invert- the reading from 0-1023 back to 1023-0
     lightSensorValue = photocellReading;
 
 return lightSensorValue; 
}

String Light::generateLight (int lightID) 
{
  //Control for resetting temperature
  LightLevel = 0;
  LightLevel = readLightSensor(lightID);

  // check if returns are valid, if they are NaN (not a number) then something went wrong!
  if (isnan(LightLevel))
  {
    Serial.println("Failed to read from Sensor");
    LightStr = "OutOfBounds";
  } else 
  {
    LightStr = floatToString(LightBuffer,LightLevel,0,0,true); 
    Serial.print("Light : "+LightStr+" %"); 
  }
  
  data="";
  data+="value="+LightStr+"&submit=Submit"; // Use HTML encoding for comma's
  
  return data;
}

void Light::setupPinMode()
{
   pinMode(2, OUTPUT);    // s0
   pinMode(3, OUTPUT);    // s1
   pinMode(4, OUTPUT);    // s2 
}

int* Light::getLightArray(int analoguePin)
{
  int* pointer;
  
  int oLDR[8];
  pointer=oLDR;

  int r0 = 0;      //value of select pin at the 4051 (s0)
  int r1 = 0;      //value of select pin at the 4051 (s1)
  int r2 = 0;      //value of select pin at the 4051 (s2)

  for (int count=0; count<8; count++) {

    // select the bit    
    r0 = bitRead(count,0); 
    r1 = bitRead(count,1);  
    r2 = bitRead(count,2);   

    digitalWrite(2, r0);
    digitalWrite(3, r1);
    digitalWrite(4, r2);

    //Either read or write the multiplexed pin here
    int LDRReading = analogRead(photocellPin); 
    oLDR[count] = LDRReading;
      
  }
  
  return pointer;
}

  /* Generate message like: { "analog": [0, 200, 400, 600, 800, 1000] } */
    aJsonObject *createJSON(int* lightArray)
    {
      int lightReadings [8];
      if(lightArray)
      {
        for(int i=0; i<8;i++)
        {
         lightReadings[i] = lightArray[i];
        }
      }
      
      aJsonObject *msg = aJson.createObject();
    
      int analogValues[6];
      for (int i = 0; i < 6; i++) {
        analogValues[i] = analogRead(i);
      }
      aJsonObject *analog = aJson.createIntArray(analogValues, 6);
      aJson.addItemToObject(msg, "analog", analog);
    
      return msg;
    }


