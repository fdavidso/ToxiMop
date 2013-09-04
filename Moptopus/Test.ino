#include <arduino.h>
#include "Test.h"

Test::Test(){
  
}

void debugProbe()
{
     // read the analog in value:
    int sensorValue = analogRead(1);            
    // map it to the range of the analog out:
    int outputValue = map(sensorValue, 0, 1023, 0, 255);  

    // print the results to the serial monitor:
    Serial.print("sensor = " );                      
    Serial.print(sensorValue);      
    Serial.print("\t output = ");      
    Serial.println(outputValue);  
}
