#include <WiFiNINA.h>
#include <ArduinoOTA.h>
#include <WiFiClient.h>
#include <WiFiServer.h>
#include <WiFiSSLClient.h>
#include <WiFiUdp.h>
#include <MQTT.h>

#include <Ethernet.h>
#include <SPI.h>

//#define DEBUG
char major = '1';
char minor = '0';

#define MQTT_USERNAME "u"
#define MQTT_PASSWORD "p"

int ledpin = 6;
int ptright = 7; //yellow right
int ptleft = 10; //green left
int ptup = 8; //black down
int ptdown = 9; //blue up
int cameraswitch = 1; //camera switch
int ptswitch = 0; //camera switch
int buttondelay = 90;
int waitCameraLong = 5000;
int waitCamera = 2000;
int camIntstep = 0;

int cdel = A1;
int cdown = A2;
int cleft = A3;
int cset = A4;
int cup = A5;
int cright = A6;

//wifi var init
char ssid[] = "giammoro";     //  your network SSID (name)
char pass[] = "giammoro51"; // your network password
int keyIndex = 0;          // your network key Index number (needed only for WEP)
int status = WL_IDLE_STATUS;

byte mac[6]= {0x00, 0xAA, 0xBB, 0xCC, 0x55, 0x57};
char id[12] = {'a','b','c','d','e','f','g','h','i','j','k','l'};
//MQTT INBOUND path
//the arduino subscribes to all messages published on this topic (erlang publishes actions here)
//the 1,2,3 is just a place holder for the mac address
//char subPath[] = {'h', 'a', '/', 'l', 'u','m','x','x','/','i', 'n', '/', 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11,'/', '#', '\0'};
char subPath[27] = {'h', 'a', '/','l','u','m','i','x','/','i','n','/', id[0],id[1],id[2],id[3],id[4],id[5],id[6],id[7],id[8],id[9],id[10],id[11],'/', '#', '\0'};

WiFiClient net;
//we get fancy compile errors if we remove this define!
IPAddress MQTT_Server;
//end wifi var init

bool activeMode = true;
bool transmitting = false;
bool activatingCamera = false;
bool startbit = false;
byte reTransmitPending = 0; //0=false 1=true 2=done
volatile long lastCharTime = 0;
volatile long lastTxTime = 0;
byte chksum = false;
int charCount = 0;

//seed the initframe from the thermostat, with 40008000 in bytes usually filled with 0
unsigned char charBuff[13] = {0xA8, 0x41, 0x00, 0x00, 0x00, 0x00, 0x21, 0x00, 0x40, 0x00, 0x80, 0x00, 0x00};
unsigned char charBuffNext[13];
boolean changeWaiting = 0;

//Serial end
int i;

//debug bits
//boolean dataIsValid = 0;

byte powerByte = 0;
byte plasmaByte = 0;
byte esavingByte = 0;
byte fanByte = 0;
byte swingByte = 0;
byte modeByte = 0;
byte tempByte = 0;
byte zoneByte = 0;

//intervals
long previousMillis = 0;       // will store last time loop ran
long previousCamMillis = 0;
long previousMasterMillis = 0; // will store last a message from the master is received
//long interval = 1000;           // interval at which to limit loop
long keepAliveInterval = 20000; // interval at which to send keepalive packets to the AC in active mode (no other master)
long previousMQTTCommand = 0;
long waitForCommand = 1464; //min. time allowed between messages
long waitLongForCommand = 3464; //min. time allowed between messages
long waitExtraLongForCommand = 7464; //min. time allowed between messages
long airConditionIntervall = 1464; //min. time allowed between messages

//MQTT
MQTTClient MQTTClient;
const char mqttServer[] = "10.9.8.1";
const int mqttServerPort = 1883; // broker mqtt port
const char key[] = " ";          // broker key
const char secret[] = " ";       // broker secret
const char device[] = " ";       // broker device identifie



byte topicNumber = 12;

void sendConfig()
{
  charBuff[0] = 0xA8; // Slave
  //thats the write bit!
  bitWrite(charBuff[1], 0, 1);

  //Calculate the checksum for the data
  charBuff[12] = calcChecksum(charBuff);

  //Send it to the AC
  Serial.print("T:");
  for (int i = 0; i < 12; i++)
  {
    Serial.print(charBuff[i], HEX);
    Serial.print(",");
  }
  Serial.println(charBuff[12], HEX);
  transmitting = true;
  lastTxTime = millis();
  //todo add ptz code here
  changeWaiting = 0;




  
  publishSettings();
}

void mqttConnect()
{
  Serial.print("checking wifi...");
  int countdown=10;
  while (WiFi.status() != WL_CONNECTED && countdown !=0)
  {
    Serial.print(".");
    delay(1000);
    countdown=countdown-1;
  }
  if(WiFi.status() == WL_CONNECTED)
  {
    Serial.print("\nconnecting...");
    if(!MQTTClient.connect(id,MQTT_USERNAME , MQTT_PASSWORD))
    {
      Serial.print("mqttConnection failed, retry later ");      
    }else
    {
      Serial.println("\nconnected!");
      MQTTClient.subscribe(subPath,1);
    }
  }
  
}

void publishTopicValue(char *strString, char *value)
{
  //note we keep this only for printing nice values,
  //we actually use the Raw binary payload on the receiver side to reduce msgs
  Serial.print("S:");
  Serial.print(strString);
  Serial.print("/");
  Serial.println(value);
  MQTTClient.publish(strString, value);
}

void publishSettings()
{
  char strPath9[] = {'h', 'a', '/','l','u','m','i','x','/','o','u','t','/', id[0],id[1],id[2],id[3],id[4],id[5],id[6],id[7],id[8],id[9],id[10],id[11],'/', 'R', major, '.', minor, '\0'}; // raw State
  char sendArray[19] = {
      charBuff[0],
      charBuff[1],
      charBuff[2],
      charBuff[3],
      charBuff[4],
      charBuff[5],
      charBuff[6],
      charBuff[7],
      charBuff[8],
      charBuff[9],
      charBuff[10],
      charBuff[11],
      charBuff[12],
      charBuff[13],
      charBuff[14],
      charBuff[15],
      charBuff[16],
      charBuff[17],
      charBuff[18]};
  MQTTClient.publish(strPath9, sendArray, 19);
}

// end LG functions***********************************************
void setup()
{

  //PTZ setup
  pinMode(ptright, OUTPUT); //yellow right
  pinMode(ptup, OUTPUT); //blue up
  pinMode(ptdown, OUTPUT); //black down
  pinMode(ptleft, OUTPUT); //green left

  pinMode(A1, OUTPUT);
  pinMode(A2, OUTPUT);
  pinMode(A3, OUTPUT);
  pinMode(A4, OUTPUT);
  pinMode(A5, OUTPUT);
  pinMode(A6, OUTPUT);

  pinMode(cameraswitch, OUTPUT); //green left
  digitalWrite(cameraswitch, HIGH);

  pinMode(ptswitch, OUTPUT); //green left
  digitalWrite(ptswitch, HIGH);
    
  Serial.begin(9600); // initialize serial communication
  Serial.print("Start Serial ");

  pinMode(ledpin, OUTPUT); // set the LED pin mode
  // Check for the presence of the shield
  Serial.print("WiFi101 shield: ");
  if (WiFi.status() == WL_NO_SHIELD)
  {
    Serial.println("NOT PRESENT");
    return; // don't continue
  }
  Serial.println("DETECTED");
  // attempt to connect to Wifi network:
  while (status != WL_CONNECTED)
  {
    Serial.print("Attempting to connect to Network named: ");
    Serial.println(ssid); // print the network name (SSID);
    // Connect to WPA/WPA2 network. Change this line if using open or WEP network:
    status = WiFi.begin(ssid, pass);
    // wait 10 seconds for connection:
    delay(1000);
  }
  
  // start the WiFi OTA library with internal (flash) based storage
  ArduinoOTA.begin(WiFi.localIP(), "Arduino", "password", InternalStorage);
  digitalWrite(ledpin, HIGH);
  MQTTClient.begin(mqttServer, net);
  MQTTClient.onMessage(callback);  
  Serial.println("wifi ready connecting mqtt....");
  WiFi.macAddress(mac);
  
  sprintf(id, "%.2X%.2X%.2X%.2X%.2X%.2X", mac[5], mac[4], mac[3], mac[2], mac[1], mac[0]);
  //set the id in the topic name
  
  subPath[12]=id[0];
  subPath[13]=id[1];
  subPath[14]=id[2];
  subPath[15]=id[3];
  subPath[16]=id[4];
  subPath[17]=id[5];
  subPath[18]=id[6];
  subPath[19]=id[7];
  subPath[20]=id[8];
  subPath[21]=id[9];
  subPath[22]=id[10];
  subPath[23]=id[11];
  
  Serial.println(id);
  Serial.print("MAC: ");
  Serial.print(mac[5],HEX);
  Serial.print(":");
  Serial.print(mac[4],HEX);
  Serial.print(":");
  Serial.print(mac[3],HEX);
  Serial.print(":");
  Serial.print(mac[2],HEX);
  Serial.print(":");
  Serial.print(mac[1],HEX);
  Serial.print(":");
  Serial.println(mac[0],HEX);
  mqttConnect();
  
  Serial.println("starting PTZ connection");
  //todo add PTZ init code here
  Serial.println(subPath);
   MQTTClient.subscribe(subPath,1);
   Serial.println("Done with setup! enjoy.....");
   publishSettings();
}

void loop()
{
  //attention wifi becomes unstable if this is commented
  ArduinoOTA.poll();

  unsigned long currentMillis = millis();

  //waiter loop to not flood out messages
  if ((currentMillis - previousMillis > waitForCommand) && (!changeWaiting) && (!transmitting) && (!charCount))
  {
    previousMillis = currentMillis;
    if (!MQTTClient.connected())
    {
       Serial.print(MQTTClient.lastError());
       mqttConnect();
    }
  }



if (activatingCamera) {
  
          if(camIntstep == 0){
            //start traversing menu to wifi
            if(!startbit){
              digitalWrite(cset, HIGH); //enter menu
              startbit = true;
              previousCamMillis = millis();
            }
            if (currentMillis - previousCamMillis > buttondelay){
              digitalWrite(cset, LOW);  
              Serial.println("set");
              camIntstep++;
              startbit = false;
            }
          }

          if(camIntstep == 1){
            if(!startbit){
              digitalWrite(cdown, HIGH); //enter menu
              startbit = true;
              previousCamMillis = millis();
            }
            if (currentMillis - previousCamMillis > buttondelay){
              digitalWrite(cdown, LOW);  
              Serial.println("move right");        
              camIntstep++;
              startbit = false;
            }
          }

          if(camIntstep == 2){
            if(!startbit){
              digitalWrite(cdown, HIGH); //enter menu
              startbit = true;
              previousCamMillis = millis();
            }
            if (currentMillis - previousCamMillis > buttondelay){
              digitalWrite(cdown, LOW);  
              Serial.println("move down");        
              camIntstep++;
              startbit = false;
            }
          }

          if(camIntstep == 3){                 
            if(!startbit){
              digitalWrite(cdown, HIGH); //enter menu
              startbit = true;
              previousCamMillis = millis();
            }
            if (currentMillis - previousCamMillis > buttondelay){
              digitalWrite(cdown, LOW);  
              Serial.println("move down");        
              camIntstep++;
              startbit = false;
            }
          }

          if(camIntstep == 4){
            if(!startbit){
              digitalWrite(cdown, HIGH); //enter menu
              startbit = true;
              previousCamMillis = millis();
            }
            if (currentMillis - previousCamMillis > buttondelay){
              digitalWrite(cdown, LOW);  
              Serial.println("move down"); 
              camIntstep++;
              startbit = false;
            }
          }

          if(camIntstep == 5){
            if(!startbit){
              digitalWrite(cdown, HIGH); //enter menu
              startbit = true;
              previousCamMillis = millis();
            }
            if (currentMillis - previousCamMillis > buttondelay){
              digitalWrite(cdown, LOW);  
              Serial.println("move down");
              camIntstep++;
              startbit = false;
            }
          }

          if(camIntstep == 6){
            if(!startbit){
              digitalWrite(cdown, HIGH); //enter menu
              startbit = true;
              previousCamMillis = millis();
            }
            if (currentMillis - previousCamMillis > buttondelay){
              digitalWrite(cdown, LOW);  
              Serial.println("move down");
              camIntstep++;
              startbit = false;
            }
          }
          
          if(camIntstep == 7){
            if(!startbit){
              digitalWrite(cset, HIGH); //enter menu
              startbit = true;
              previousCamMillis = millis();
            }
            if (currentMillis - previousCamMillis > buttondelay){
              digitalWrite(cset, LOW);  
              Serial.println("set");
              camIntstep++;
              startbit = false;
            }
          }

          if(camIntstep == 8){
            if(!startbit){
              startbit = true;
              previousCamMillis = millis();
            }
            if (currentMillis - previousCamMillis > waitCameraLong){
              Serial.println("waiting 5000ms");
              camIntstep++;
              startbit = false;
            }
          }

          if(camIntstep == 9){
            if(!startbit){
              digitalWrite(cset, HIGH); //enter menu
              startbit = true;
              previousCamMillis = millis();
            }
            if (currentMillis - previousCamMillis > buttondelay){
              digitalWrite(cset, LOW);  
              Serial.println("set");
              camIntstep++;
              startbit = false;
            }
          }

          if(camIntstep == 10){
            if(!startbit){
              startbit = true;
              previousCamMillis = millis();
            }
            if (currentMillis - previousCamMillis > waitCamera){
              Serial.println("waiting 5000ms");
              camIntstep++;
              startbit = false;
            }
          }

          if(camIntstep == 11){
            if(!startbit){
              digitalWrite(cset, HIGH); //enter menu
              startbit = true;
              previousCamMillis = millis();
            }
            if (currentMillis - previousCamMillis > buttondelay){
              digitalWrite(cset, LOW);  
              Serial.println("set");
              camIntstep++;
              startbit = false;
            }
          }

          if(camIntstep == 12){
            if(!startbit){
              startbit = true;
              previousCamMillis = millis();
            }
            if (currentMillis - previousCamMillis > waitCamera){
              Serial.println("waiting 5000ms");
              camIntstep++;
              startbit = false;
            }
          }

          if(camIntstep == 13){
            if(!startbit){
              digitalWrite(cset, HIGH); //enter menu
              startbit = true;
              previousCamMillis = millis();
            }
            if (currentMillis - previousCamMillis > buttondelay){
              digitalWrite(cset, LOW);  
              Serial.println("set");
              activatingCamera = false;
              camIntstep++;
              startbit = false;
            }
          }                    
          
} 


  //this is has the following conditions that must be met, adapt if needed
  //lastCharTime = ensure we have a space of 1.4s between each message that appears to be the default.
  //changeWaiting = there must be a pending change from sendConfig()
  //transmitting = we have no bytes in the serial port TX buffer
  //charCount = we are currently not receiving data from serial //todo i guess this should be removed
  //(currentMillis - previousMasterMillis > keepAliveInterval * 2) = we limit the time we block the overall network to *2 keepalive intervall 
  if ((millis() - lastCharTime > waitForCommand) && (changeWaiting) && (!transmitting) && (!charCount) && (currentMillis - previousMasterMillis < keepAliveInterval * 2))
  { 
      //patched sendconfig should apply the ptz positions stored inside the MQTT callback
      sendConfig(); 
  }
  MQTTClient.loop();
}

void printWifiStatus()
{
  // print the SSID of the network you're attached to:
  Serial.print("SSID: ");
  Serial.println(WiFi.SSID());

  // print your WiFi shield's IP address:
  IPAddress ip = WiFi.localIP();
  Serial.print("IP Address: ");
  Serial.println(ip);

  // print the received signal strength:
  long rssi = WiFi.RSSI();
  Serial.print("signal strength (RSSI):");
  Serial.print(rssi);
  Serial.println(" dBm");
  // print where to go in a browser:
  Serial.print("To see this page in action, open a browser to http://");
  Serial.println(ip);
}

//*******************************
//      FUNCTIONS

void callback(String &topic, String &payload)  
{
  Serial.print(topic);
  Serial.print(" ");  
  Serial.print(payload);
  Serial.print(" ");   
  Serial.println("mqtt callback");
  // If there has been no MQTT message received for a while...
  if ((millis() - previousMQTTCommand > waitForCommand) && (changeWaiting == 0))
  {
    previousMQTTCommand = millis();
  }

Serial.println("THE ANSWER:");
Serial.println(topic);

Serial.println("THE ENDPOINT:");
Serial.println(topic[25] && topic[26]);

Serial.println("THE TOPIC:");
Serial.println(topic[28]);

Serial.println("THE PAYLOAD:");
Serial.println(payload);
 
  if (topic[24] == '/')
  {
    if (topic[25] && topic[26] == '1')
    {
      if (topic[28] == 'L')
      {
        changeWaiting = 1;
        int pan = payload.toInt();
        if (pan == 255) //engage wifi
        {
          Serial.println("start Wifi");
          digitalWrite(cset, HIGH);
          digitalWrite(cset, LOW);  
          Serial.println("set"); 
        }   
      }
      if (topic[28] == 'P')
      {
      
        changeWaiting = 1;
        if (payload[0] == '1')
        {
          bitWrite(charBuff[1], 1, 1); //on
          digitalWrite(cameraswitch, LOW);
          Serial.println("cam on");
        }
        else
        {
          bitWrite(charBuff[1], 1, 0); //off
          digitalWrite(cameraswitch, HIGH);
          Serial.println("cam off");
        }
      }
    }
    if (topic[25] && topic[26] == '2')
    {
      if (topic[28] == 'L')
      {
        changeWaiting = 1;
        int pan = payload.toInt();
        if (pan == 128)
        {
            Serial.println("panning stopped");
            digitalWrite(ptup, LOW);
            digitalWrite(ptdown, LOW);

        }
        if (pan < 128)
        {
            Serial.println("panning up");
            digitalWrite(ptdown, LOW);
            digitalWrite(ptup, HIGH);
        }
        if (pan > 128)
        {
            Serial.println("panning down");
            digitalWrite(ptup, LOW);
            digitalWrite(ptdown, HIGH);
        }      
      }
      
      if (topic[28] == 'P')
      {
      
        changeWaiting = 1;
        if (payload[0] == '1')
        {
          bitWrite(charBuff[1], 1, 1); //on
          activatingCamera = true;
          Serial.println("activationg wifi");

        }
        else
        {
          bitWrite(charBuff[1], 1, 0); //off
          camIntstep = 0;
          activatingCamera = false;
          Serial.println("reset menu");
        }
      }
    }
    if (topic[25] && topic[26] == '3')
    {
      if (topic[28] == 'L')
      {
        changeWaiting = 1;
        int pan = payload.toInt();
        if (pan == 128)
        {
            Serial.println("panning stopped");
            digitalWrite(ptright, LOW);
            digitalWrite(ptleft, LOW);

        }
        if (pan < 128)
        {
            Serial.println("panning left");
            digitalWrite(ptright, LOW);
            digitalWrite(ptleft, HIGH);
        }
        if (pan > 128)
        {
            Serial.println("panning right");
            digitalWrite(ptleft, LOW);
            digitalWrite(ptright, HIGH);
        }      
      }
      
      if (topic[28] == 'P')
      {
      
        changeWaiting = 1;
        if (payload[0] == '1')
        {
          bitWrite(charBuff[1], 1, 1); //on
          digitalWrite(ptswitch, LOW);
          Serial.println("pt on");
        }
        else
        {
          bitWrite(charBuff[1], 1, 0); //off
          digitalWrite(ptswitch, HIGH);
          Serial.println("pt off");
        }
      }
    } 
  }
  //make sure we send the message twice and discard any old retransmission
  reTransmitPending = 0;
}

byte calcChecksum(unsigned char payload[])
{
  unsigned int checksum2;

  checksum2 = 0;
  for (int i = 0; i < 12; i++)
  {
    //Serial.print(charBuff[i]);
    //Serial.print(".");
    checksum2 = checksum2 + payload[i];
  }

  return (checksum2 ^ 0x55) - 256;
}
