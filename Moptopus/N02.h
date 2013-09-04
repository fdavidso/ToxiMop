#ifndef N0_
#define N0_

#include <arduino.h>
#include <Stdio.h>

class N0 {
  private:
   float N0Level;
   String N0Str; 
   char N0Buffer[30];
   String data;
   int r0;      //value of select pin at the 4051 (s0)
   int r1;      //value of select pin at the 4051 (s1)
   int r2;      //value of select pin at the 4051 (s2)
   int count;   //which y pin we are selecting
   int ProbePin; // the cell and 10K pulldown are connected to a0
   int ProbeReading; // the analog reading from the sensor divider
  public:
    N0();
    String generateN0(int);
    float readN0Sensor(int);
};

#endif
