//#include <Arduino.h>
#if defined(ARDUINO_SAMD_MKRWIFI1010)
  #include <WiFiNINA.h>
#else if defined(ARDUINO_SAMD_MKR1000)
  #include <WiFi101.h>
#endif
#include <ArduinoOTA.h>
#include <WiFiClient.h>
#include <WiFiServer.h>
#include <WiFiSSLClient.h>
#include <WiFiUdp.h>
//#include <SoftwareSerial.h>
#include <SlowSoftSerial.h>
#include <MQTT.h>

#include <Ethernet.h>
#include <SPI.h>
#include <DHT.h>

//#define DEBUG
char major = '1';
char minor = '0';

#define AC_RX_PIN 4
#define AC_TX_PIN 5
#define ONEWIRE false

#define MQTT_USERNAME "u"
#define MQTT_PASSWORD "p"

#define DHTPIN 2
#define DHTTYPE DHT11
DHT dht(DHTPIN, DHTTYPE);
int ledpin = 6;

//wifi var init
char ssid[] = "sheep";     //  your network SSID (name)
char pass[] = ""; // your network password
int keyIndex = 0;          // your network key Index number (needed only for WEP)
int status = WL_IDLE_STATUS;

byte mac[6]= {0x00, 0xAA, 0xBB, 0xCC, 0x55, 0x57};
char id[12] = {'0','1','2','3','4','5','6','7','8','9','10','11'};
char subPath[] = {'h', 'a', '/', 'l', 'u','m','i','x','/','i', 'n', '/','0','1','2','3','4','5','6','7','8','9','10','11','/', '#', '\0'};


WiFiClient net;
//we get fancy compile errors if we remove this define!
IPAddress MQTT_Server;
//end wifi var init


//serial
SlowSoftSerial swSer(AC_RX_PIN, AC_TX_PIN, ONEWIRE);

bool activeMode = true;
bool transmitting = false;
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
char ac_room_temp = 0x00;
char ts_room_temp = 0x00;
int sensor_hum = 101;
int sensor_temp = 26;
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
long previousMasterMillis = 0; // will store last a message from the master is received
//long interval = 1000;           // interval at which to limit loop
long keepAliveInterval = 20000; // interval at which to send keepalive packets to the AC in active mode (no other master)
long previousMQTTCommand = 0;
long waitForCommand = 1464; //min. time allowed between messages
long airConditionIntervall = 1464; //min. time allowed between messages

//MQTT
MQTTClient MQTTClient;
const char mqttServer[] = "192.168.178.201";
const int mqttServerPort = 1883; // broker mqtt port
const char key[] = " ";          // broker key
const char secret[] = " ";       // broker secret
const char device[] = " ";       // broker device identifie



byte topicNumber = 12;

void serialFlush()
{
  while (swSer.available() > 0)
  {
    char t = swSer.read();
  }
}

void sendConfig()
{
  charBuff[0] = 0xA8; // Slave
  //thats the write bit!
  bitWrite(charBuff[1], 0, 1);
  if (activeMode)
  {
    charBuff[7] = sensor_temp/100;
    Serial.print("active mode setting sensor temp:");
    Serial.println(charBuff[7],DEC);
  }
  else
  {    
    charBuff[7] = ts_room_temp; //we send with the last known room temperature, since what we have in buffer might come from the AC unit
  }  

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
  //swSer.write(charBuff, 13);
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
  char strPath9[] = {'h', 'a', '/','l','u','m','i','x','/','o','u','t','/', id[0], id[1], id[2], id[3],id[4],id[5], id[6],id[7],id[8],id[9],id[10],id[11],'/', 'R', major, '.', minor, '\0'}; // raw State
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
      highByte(sensor_temp),
      lowByte(sensor_temp),
      highByte(sensor_hum),
      lowByte(sensor_hum),
      ts_room_temp,
      ac_room_temp};
  MQTTClient.publish(strPath9, sendArray, 19);
}

// end LG functions***********************************************
void setup()
{
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
    digitalWrite(ledpin, LOW);
    Serial.print("Attempting to connect to Network named: ");
    Serial.println(ssid); // print the network name (SSID);
    digitalWrite(ledpin, HIGH);
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
  dht.begin();
  WiFi.macAddress(mac);
  sprintf(id, "%.2X%.2X%.2X%.2X%.2X%.2X", mac[5], mac[4], mac[3], mac[2], mac[1], mac[0]);
  //set the id in the topic name
  subPath[9]=id[0];
  subPath[10]=id[1];
  subPath[11]=id[2];
  subPath[12]=id[3];
  subPath[13]=id[4];
  subPath[14]=id[5];
  subPath[15]=id[6];
  subPath[16]=id[7];
  subPath[17]=id[8];
  subPath[18]=id[9];
  subPath[19]=id[10];
  subPath[20]=id[11];
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
   MQTTClient.subscribe(subPath,1);
   Serial.println("Done with setup! enjoy.....");
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
    sensor_hum = (int)dht.readHumidity() * 100;
    sensor_temp = (int)dht.readTemperature() * 100;
    if (!MQTTClient.connected())
    {
       mqttConnect();
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
  // If there has been no MQTT message received for a bit...
  if ((millis() - previousMQTTCommand > waitForCommand) && (changeWaiting == 0))
  {
    previousMQTTCommand = millis();
  }
  if (topic[21] == '/')
  {
    if (topic[22] == 'Z')
    {
      changeWaiting = 1;
      //Serial.println("Zones");
      if (payload[3] == '1')
      {
        bitWrite(charBuff[5], 3, 1);
      }
      else
      {
        bitWrite(charBuff[5], 3, 0);
      }
      if (payload[2] == '1')
      {
        bitWrite(charBuff[5], 4, 1);
      }
      else
      {
        bitWrite(charBuff[5], 4, 0);
      }
      if (payload[1] == '1')
      {
        bitWrite(charBuff[5], 5, 1);
      }
      else
      {
        bitWrite(charBuff[5], 5, 0);
      }
      if (payload[0] == '1')
      {
        bitWrite(charBuff[5], 6, 1);
      }
      else
      {
        bitWrite(charBuff[5], 6, 0);
      }
      //Serial.println(charBuff[6],BIN);
    }
    if (topic[22] == 'M')
    {
      changeWaiting = 1;
      if (payload[0] == '0')
      { //Cooling
        bitWrite(charBuff[1], 2, 0);
        bitWrite(charBuff[1], 3, 0);
        bitWrite(charBuff[1], 4, 0);
      }
      if (payload[0] == '4')
      { //Dehumidify
        bitWrite(charBuff[1], 2, 1);
        bitWrite(charBuff[1], 3, 0);
        bitWrite(charBuff[1], 4, 0);
      }
      if (payload[0] == '3')
      { //Fan only
        bitWrite(charBuff[1], 2, 0);
        bitWrite(charBuff[1], 3, 1);
        bitWrite(charBuff[1], 4, 0);
      }
      if (payload[0] == '2')
      { //Auto
        bitWrite(charBuff[1], 2, 1);
        bitWrite(charBuff[1], 3, 1);
        bitWrite(charBuff[1], 4, 0);
      }
      if (payload[0] == '1')
      { //Heating
        bitWrite(charBuff[1], 2, 0);
        bitWrite(charBuff[1], 3, 0);
        bitWrite(charBuff[1], 4, 1);
      }
    }
    if (topic[22] == 'T')
    {
      changeWaiting = 1;
      const char tmpChar[3] = {payload[0], payload[1], '\0'}; // Convert it to a null terminated string.
      unsigned int tempval = atoi(tmpChar) - 15;              // Take off the offset of 15 Degrees.
      bitWrite(charBuff[6], 0, bitRead(tempval, 0));          // Write the bits
      bitWrite(charBuff[6], 1, bitRead(tempval, 1));
      bitWrite(charBuff[6], 2, bitRead(tempval, 2));
      bitWrite(charBuff[6], 3, bitRead(tempval, 3));
    }
    if (topic[22] == 'F')
    {
      changeWaiting = 1;
      if (payload[0] == '1')
      { //Low
        bitWrite(charBuff[1], 5, 0);
        bitWrite(charBuff[1], 6, 0);
      }
      if (payload[0] == '2')
      { //Med
        bitWrite(charBuff[1], 5, 1);
        bitWrite(charBuff[1], 6, 0);
      }
      if (payload[0] == '3')
      { //High
        bitWrite(charBuff[1], 5, 0);
        bitWrite(charBuff[1], 6, 1);
      }
      if (payload[0] == '0')
      { //auto
        bitWrite(charBuff[1], 5, 1);
        bitWrite(charBuff[1], 6, 1);
      }
    }
    if (topic[22] == 'P')
    {
      changeWaiting = 1;
      //Serial.println("Power");
      if (payload[0] == '1')
      {
        bitWrite(charBuff[1], 1, 1);
      }
      else
      {
        bitWrite(charBuff[1], 1, 0);
      }
    }
    if (topic[22] == 'J')
    {
      changeWaiting = 1;
      //Serial.println("Jet");
      if (payload[0] == '1')
      {
        bitWrite(charBuff[1], 7, 1);
      }
      else
      {
        bitWrite(charBuff[1], 7, 0);
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
