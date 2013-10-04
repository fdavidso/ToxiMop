#include <Ethernet.h>
#include <SPI.h>
#include "DHT.h"
#include "floatToString.h"
#include "Temperature.h"
#include "Humidity.h"
#include "Light.h"
#include "SoilMoisture.h"
#include "aJSON.h"
#include "SetupMop.h"

#define DHTPIN 8     // what pin we're connected to
#define DHTTYPE DHT11   // DHT 11 

DHT dht(DHTPIN, DHTTYPE);

byte mac[] = {
  0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED}; // max address for ethernet shield
byte ip[] = {
  192,168,2,103}; // ip address for ethernet shield

String serverAddress = "192.168.2.107"; // ip address to ping
byte server[] = {
  192,168,2,107};
byte gateway[] = { 
  192,168,2,1 };	
String gatewayAddress = "192.168.2.1";
int port = 8080;
String ServletKey = "vhMPGBUHX7MLVMSG";
int loopCounter=0;

EthernetClient client;
Temperature temp = Temperature();
SetupMop setupMop = SetupMop();
Humidity humid = Humidity();
Light light = Light();
SoilMoisture soilMoisture = SoilMoisture();

String Project="Moptopus";
String Servlet="SensorData";
String NodeID ="1";
int TimeDelayBeingUpdates(5000);
int TimeDelayBeingCycles (30000);

char* SensorType[]={
  "temp", "humidity", "light", "water-level", "soil-moisture"};
String lightSensors[]={
  "0", "1", "2", "3"};
char* soilMoistureSensors[]={
  "4","5", "6", "7"};
char* waterLevelSensors[]={
  "1", "2", "3", "4"};
char* DHT11Sensors[]={
  "1", "2"};

void setup()
{
  Serial.begin(9600);

  displayWelcomeMessage();

  Serial.println("\n<------------------------------------------>");
  Serial.println("\t Initialising");
  Serial.println("<------------------------------------------>");

  setupMop.configurePinModes();
  setupMop.configureEthernetDHCP();
  setupMop.configureServerConnection();

  Serial.println("\n<------------------------------------------>");
  Serial.println("\t Set Up Complete");
  Serial.println("<------------------------------------------>");
}

void displayWelcomeMessage()
{
  Serial.println("<------------------------------------------>");
  Serial.println("\t Dundee iGem's Moptopus");
  Serial.println("<------------------------------------------>");
  Serial.println("\t Node Details  : \tNode 1 ");
  Serial.print("\t Server Address : \t");
  Serial.println(serverAddress);
  Serial.print("\t Gateway  : \t\t");
  Serial.println(gatewayAddress);
  Serial.print("\t Port : \t\t");
  Serial.println(port);
  Serial.print("\t Servlet Key : \t\t");
  Serial.println(ServletKey); 
}

void loop(){

  Serial.println("<------------------------------------------>");
  Serial.print("\t Loop");
  Serial.println(loopCounter);
  Serial.println("<------------------------------------------>");

  aJsonObject *msg = createMessage();
  char* jsonString = "";
 // jsonString = aJson.print(msg);
  Serial.println(jsonString);
  char* JSON = "mydata=";
  char* jsonvalues =  "";
  jsonvalues = strcat (JSON, jsonString);
 
  sendData(jsonvalues,"1","1","1");
  serialDebugData(jsonvalues,"1","1","1");  

  Serial.print("\t Values =  ");
  Serial.println(jsonString);

  msg = NULL;
  delete msg;

  boolean connection = ConnectToServlet("temp","1");
  if(connection){
    Serial.println("\t Server Connection : \t Available"); 
  }
  else{
    Serial.println("\t Server Connection : \t Unavailable"); 
  } 
  //ConnectToServlet("humidity","1");
  // ConnectToServlet("light","0");
  // ConnectToServlet("light","1");
  // ConnectToServlet("soil-moisture","4");

  delay(TimeDelayBeingCycles);
  loopCounter++;
}

boolean ConnectToServlet(String SensorType,String SensorID)
{
  if (client.connect(server,port)) {
    Serial.println("\n\t Connecting to "+ SensorType+" Sensor ID "+SensorID);

    String thisData = "";

    if(SensorType=="temp"){
      thisData = temp.generateTemp();
    }
    else if( SensorType== "humidity"){
      thisData = humid.generateHumidity();
    }
    else if(SensorType=="light"){
      int LightSensorID =0;

      if(SensorID=="0")         {
        LightSensorID =0;
      } 
      else  if(SensorID=="1") {
        LightSensorID =1;
      } 
      else  if(SensorID=="2") {
        LightSensorID =2;
      } 
      else  if(SensorID=="3") {
        LightSensorID =3;
      } 

      thisData = light.generateLight(LightSensorID);
    }
    else if (SensorType=="soil-moisture"){
      int SoilSensorID =4;

      if(SensorID=="4") {
        SoilSensorID =4;
      } 
      else  if(SensorID=="5") {
        SoilSensorID =5;
      } 
      else  if(SensorID=="6") {
        SoilSensorID =6;
      } 
      else  if(SensorID=="7") {
        SoilSensorID =7;
      } 

      thisData = soilMoisture.generateSoilMoisture(SoilSensorID);
    }
    else
    {
      Serial.println("Failed to Connect");
      //delay(5000); 
      return false;
    }
    sendData(thisData,NodeID,SensorType,SensorID);
    serialDebugData(thisData,NodeID,SensorType,SensorID);
    Serial.println("");

  }

  if (client.connected())  {
    Serial.println("Disconnecting from "+ SensorType+" Sensor ID "+SensorID);
    client.stop();
    delay(TimeDelayBeingUpdates);
    return true;
  }
  else {
    Serial.println("\t Error Connecting");
    //retryConnection();
    return false;
  }
}

void retryConnection()
{
  Serial.println("\t Retry Connection");
  Ethernet.begin(mac,Ethernet.localIP(),gateway);

  for (byte thisByte = 0; thisByte < 4; thisByte++) {
    // print the value of each byte of the IP address:
    Serial.print(Ethernet.localIP()[thisByte], DEC);
    Serial.print("."); 
  } 
}

void sendData(String thisData, String NodeID,String SensorType, String SensorID) {

  // node / type / number / value
  client.println("POST /"+Project+"/"+Servlet+"/"+NodeID+"/"+SensorType+"/"+SensorID+"/"+ServletKey+" HTTP/1.1");
  client.println("Host: "+serverAddress);
  client.println("Content-Type: application/x-www-form-urlencoded");
  client.print("Content-Length: ");
  client.println(thisData.length());
  client.println();
  client.print(thisData);
  client.println();
}

void serialDebugData(String thisData, String NodeID,String SensorType, String SensorID) {

  Serial.println("\t Server Status : \t Connected\n");
  // node / type / number / value
  Serial.println("POST /"+Project+"/"+Servlet+"/"+NodeID+"/"+SensorType+"/"+SensorID+"/"+ServletKey+" HTTP/1.1");
  Serial.println("Host: "+serverAddress);
  Serial.println("Content-Type: application/x-www-form-urlencoded");
  Serial.print("Content-Length: ");
  Serial.println(thisData.length());
  Serial.println();
  Serial.print(thisData);
  Serial.println();
}


/* Generate message like: { "analog": [0, 200, 400, 600, 800, 1000] } */
aJsonObject *createMessage()
{
  aJsonObject *msg = aJson.createObject();

  int analogValues[6];
  for (int i = 0; i < 6; i++) {
    analogValues[i] = analogRead(i);
  }
  aJsonObject *analog = aJson.createIntArray(analogValues, 6);
  aJson.addItemToObject(msg, "analog", analog);

  return msg;
}



