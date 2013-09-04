#ifndef PH_
#define PH_

#include <arduino.h>
#include <Stdio.h>

class PH {
  private:
   float PHLevel;
   String PHStr; 
   char PHBuffer[30];
   String data;
   int count;   //which y pin we are selecting
   int ProbePin; // the cell and 10K pulldown are connected to a0
   int ProbeReading; // the analog reading from the sensor divider
  public:
    PH();
    String generatePH(int);
    float readPHSensor(int);
};

#endif