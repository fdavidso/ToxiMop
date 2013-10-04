
/*
This software was made ... by Naz :|
*/

//For serial communication with Pi!
#include <Wire.h>


// include the LCD library:
#include <LiquidCrystal.h>

// initialize the library with the numbers of the interface pins
LiquidCrystal lcd(53, 51, 49, 47, 45, 43);

//Temperature sensor library and info
#include <Sensirion.h>
 
const uint8_t dataPin  =  2;
const uint8_t clockPin =  3;

float temperature;
float humidity;
float dewpoint;

Sensirion tempSensor = Sensirion(dataPin, clockPin);




//Data storage and states for the pH and DO stamps
String inputstring = "";                                                       //a string to hold incoming data from the PC
String sensorstringp = "";                                                      //a string to hold the data from the Atlas Scientific product
String sensorstringd = "";

boolean input_stringcomplete = false;                                          //have we received all the data from the PC
boolean sensor_stringcompleted = false;                                         //have we received all the data from the Atlas Scientific product
boolean sensor_stringcompletep = false;
int k = 0;


//Data storage
int light = 0;                  
int lightPin=A0;                //lightPin
int lightValue = 0;             //light
char temperaturestring[10];     //temperature
char humiditystring[10];        //humidity

int led = 13;                   //LED pin
int bri = 0;                    //for pulsing

//Data for serial transfer of data
#define SLAVE_ADDRESS 0x04
int input = 0;                  //Serial communication
int data = 0;

//Pulsing and timing variables
boolean dir = true;
int timer = 0;
boolean displcd = false;
int lcdtime = 0;









void setup(){  //set up the hardware
    //Setup LCD
    lcd.begin(16, 2);
    lcd.print("UoD iGEM");
     
    //Begin serial comm for pH and DO
    Serial.begin(38400);                                                      //set baud rate for the hardware serial port_0 to 38400
    Serial2.begin(38400);                                                     //set baud rate for software serial port_2 to 38400
    Serial3.begin(38400);                                                     //set baud rate for software serial port_3 to 38400
    inputstring.reserve(5);                                                   //set aside some bytes for receiving data from the PC
    sensorstringp.reserve(30);                                                 //set aside some bytes for receiving data from Atlas Scientific product
    sensorstringd.reserve(30);
    
    Serial.println("Ready!");
    
    
    // initialize i2c as slave
    Wire.begin(SLAVE_ADDRESS);
 
    // define callbacks for i2c communication
    Wire.onReceive(receiveData);
    Wire.onRequest(sendData);

      
}
 
 
 
 










 void loop(){   //here we go....

  
  
  if (input_stringcomplete){                                                   //if a string from the PC has been recived in its entierty 
    Serial3.print(inputstring);                                              //send that string to the Atlas Scientific product
    Serial2.print(inputstring);                                              //send that string to the Atlas Scientific product
    inputstring = "";                                                        //clear the string:
    input_stringcomplete = false;                                            //reset the flage used to tell if we have recived a completed string from the PC
  }

  if (sensor_stringcompleted){                                                   //if a string from the Atlas Scientific product has been recived in its entierty 
    Serial.println(sensorstringd);                                            //send that string to to the PC's serial monitor
    sensorstringd = "";                                                       //clear the string:
    sensor_stringcompleted = false;                                           //reset the flage used to tell if we have recived a completed string from the Atlas Scientific product
  }
  
  if (sensor_stringcompletep){                                                   //if a string from the Atlas Scientific product has been recived in its entierty 
    Serial.println(sensorstringp);                                            //send that string to to the PC's serial monitor
    sensorstringp = "";                                                       //clear the string:
    sensor_stringcompletep = false;                                           //reset the flage used to tell if we have recived a completed string from the Atlas Scientific product
  }
}






// callback for received data

void receiveData(int byteCount){
    while(Wire.available()) {
        input = Wire.read();
        Serial.print("data received: ");
        Serial.println(input);
 
        if (input == 1){
            //read the value from the ldr:
            lightValue = analogRead(lightPin);
            //light = (120/(10/((1023/lightValue)-1)));
            //lcd.print("Light level: ");
            lcd.clear();
            lcd.print("UoD iGEM");
            lcd.setCursor(0,1);
            lcd.print("Light:"); lcd.print(light); lcd.print("Lux");
            displcd = true;
            lcdtime = 1;
            data = lightValue;
        }
        
        else if (input == 2){
            //Temperature
            tempSensor.measure(&temperature, &humidity, &dewpoint);  
            lcd.clear();
            lcd.print("UoD iGEM");
            lcd.setCursor(0,1);
            lcd.setCursor(0,1); 
            //lcd.print("Light level: ");
            lcd.print("Temp: "); lcd.print(temperature,2); lcd.print("C");
            displcd = true;
            lcdtime = 1;
            dtostrf(temperature, 4, 2, temperaturestring);
            int temp = atoi(temperaturestring);
            data = temp;
       }
       else if (input == 3){
            //Humidity
            tempSensor.measure(&temperature, &humidity, &dewpoint);  
            lcd.clear();
            lcd.print("UoD iGEM");
            lcd.setCursor(0,1);
            //lcd.print("Light level: ");
            lcd.print("Humidity: "); lcd.print(humidity,2); lcd.print("%");
            displcd = true;
            lcdtime = 1;
            dtostrf(humidity, 1, 2, humiditystring);
            int humi = atoi(humiditystring);
            data = humi;
       }
       
       else if (input == 4){
            Serial2.print("R\r");
            //Serial3.print("R\r");
            Serial.print(sensorstringd);
            lcd.clear();
            lcd.print("UoD iGEM");
            lcd.setCursor(0,1);
            int D0 = sensorstringd.toInt();
            lcd.print("D.O.: "); lcd.print(sensorstringd); lcd.print("mg/L");
            displcd = true;
            lcdtime = 1;
            data = D0;
      }   
      
      else if (input == 5){
            Serial3.print("R\r");
            //Serial3.print("R\r");
            Serial.print(sensorstringp);
            lcd.clear();
            lcd.print("UoD iGEM");
            lcd.setCursor(0,1);
            int pH = sensorstringp.toInt();
            lcd.print("pH: "); lcd.print(sensorstringp);
            displcd = true;
            lcdtime = 1;
            data = pH;
      }   
     }
}




// callback for sending data
void sendData(){
    Wire.write(int(data));
}




    


    
    //Serial Sending data confirmation + storage
void serialEvent() {                                                         //if the hardware serial port_0 receives a char              
    char inchar = (char)Serial.read();                                       //get the char we just received
    inputstring += inchar;                                                   //add it to the inputString
    if(inchar == '\r') {input_stringcomplete = true;}                        //if the incoming character is a <CR>, set the flag
}  

//pH Serial data confirmation + storage
void serialEvent2(){                                                         //if the hardware serial port_3 receives a char 
    char inchar = (char)Serial2.read();                                      //get the char we just received
    sensorstringd += inchar;                                                 //add it to the inputString
    if(inchar == '\r') {sensor_stringcompleted = true;}                      //if the incoming character is a <CR>, set the flag 
}


//DO Serial data confirmation + storage
void serialEvent3(){                                                         //if the hardware serial port_3 receives a char 
    char inchar = (char)Serial3.read();                                      //get the char we just received
    sensorstringp += inchar;                                                 //add it to the inputString
    if(inchar == '\r') {sensor_stringcompletep = true;}                      //if the incoming character is a <CR>, set the flag 
}
    
    
  //Light Pulsing Script
  //timer=0;
  //while (timer < 50){  
  //    if (bri == 254){
  //      dir = false;
  //   }
  //    else if (bri == 0){
  //      dir = true;
  //    }
  //    if (dir){
  //      analogWrite(led,bri);
  //      bri=bri+2;
  //      delay(10);
  //    }
  //    else{
  //      bri = bri-2;
  //      analogWrite(led,bri);
  //      delay(10);  
  //    }
  //    timer = timer+10;
  //}



