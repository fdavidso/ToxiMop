#include <arduino.h>
#include "SetupMop.h"



SetupMop::SetupMop(){

}

void SetupMop::configurePinModes()
{
    //Setting up pinModes
 // Serial.println("Pinmode Config : \t Starting..."); 
  pinMode(9, OUTPUT);  
  Serial.println("\t Pinmode Config : \t Complete"); 
}

void SetupMop::configureEthernetDHCP()
{
    Serial.println("\t Ethernet DHCP : \t Starting...");
     // start the Ethernet connection:
    if (Ethernet.begin(mac) == 0) {
      Serial.println("Failed to configure Ethernet using DHCP");
    }else{
      Serial.println("\t Ethernet DHCP : \t Configured Ethernet Using DHCP"); 
    }

    // Find Local IP Address
    Ethernet.begin(mac,Ethernet.localIP(),gateway);

    // print the value of each byte of the IP address:
    Serial.print("\t Local IP : \t\t ");
    for (byte thisByte = 0; thisByte < 4; thisByte++)     {
      Serial.print(Ethernet.localIP()[thisByte], DEC);
      Serial.print(".");
    } 
}

void SetupMop::configureServerConnection()
{
 //Attempting to conenct to Server
  if (client.connect(server,port)) {
   Serial.println("\n\t Server : \t\t Connected to Server\n"); 
  }
  else {
    Serial.println("\n\t Server : \t\t Connection Failed \n");
  } 
}
