#ifndef C02_
#define C02_

#include <arduino.h>
#include <Stdio.h>

class C02 {
  private:
   float C02Level;
   String C02Str; 
   char C02Buffer[30];
   String data;
   int r0;      //value of select pin at the 4051 (s0)
   int r1;      //value of select pin at the 4051 (s1)
   int r2;      //value of select pin at the 4051 (s2)
   int count;   //which y pin we are selecting
   int ProbePin; // the cell and 10K pulldown are connected to a0
   int ProbeReading; // the analog reading from the sensor divider
  public:
    C02();
    String generateC02(int);
    float readC02Sensor(int);
};

#endif
