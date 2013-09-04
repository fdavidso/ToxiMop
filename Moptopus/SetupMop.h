#ifndef SetupMop_
#define SetupMop_

#include <arduino.h>
#include <Stdio.h>

class SetupMop {
  private:

  public:
    SetupMop();
    void configurePinModes();
    void configureEthernetDHCP();
    void configureServerConnection();
};

#endif
