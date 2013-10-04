#ifndef Dissolved02_
#define Dissolved02_

#include <arduino.h>
#include <Stdio.h>

class Dissolved02 {
  private:
   float Dissolved02Level;
   String Dissolved02Str; 
   char Dissolved02Buffer[30];
   String data;
   int count;   //which y pin we are selecting
   int ProbePin; // the cell and 10K pulldown are connected to a0
   int ProbeReading; // the analog reading from the sensor divider
  public:
    Dissolved02();
    String generateDissolved02(int);
    float readDissolved02Sensor(int);
};

#endif