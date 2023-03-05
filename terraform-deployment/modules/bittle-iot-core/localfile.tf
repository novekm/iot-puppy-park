// Bittles
resource "local_file" "device_certificate_bittle" {
  for_each = var.all_bittles == null ? {} : var.all_bittles
  filename = "${path.module}/ESP8266_AWS_IOT/${each.value.name}/${each.value.name}-device-certificate.pem"
  content  = aws_iot_certificate.cert_bittles[each.key].certificate_pem
}
resource "local_file" "private_key_bittle" {
  for_each = var.all_bittles == null ? {} : var.all_bittles
  filename = "${path.module}/ESP8266_AWS_IOT/${each.value.name}/${each.value.name}-private-key.pem.key"
  content  = aws_iot_certificate.cert_bittles[each.key].private_key
}
resource "local_file" "public_key_bittle" {
  for_each = var.all_bittles == null ? {} : var.all_bittles
  filename = "${path.module}/ESP8266_AWS_IOT/${each.value.name}/${each.value.name}-public-key.pem.key"
  content  = aws_iot_certificate.cert_bittles[each.key].public_key
}

// Gas Sensors
resource "local_file" "device_certificate_gas_sensor" {
  for_each = var.all_gas_sensors == null ? {} : var.all_gas_sensors
  filename = "${path.module}/M5STICKCPLUS_AWS_IOT/${each.value.name}/${each.value.name}-device-certificate.pem"
  content  = aws_iot_certificate.cert_gas_sensors[each.key].certificate_pem
}
resource "local_file" "private_key_gas_sensor" {
  for_each = var.all_gas_sensors == null ? {} : var.all_gas_sensors
  filename = "${path.module}/M5STICKCPLUS_AWS_IOT/${each.value.name}/${each.value.name}-private-key.pem.key"
  content  = aws_iot_certificate.cert_gas_sensors[each.key].private_key
}
resource "local_file" "public_key_gas_sensor" {
  for_each = var.all_gas_sensors == null ? {} : var.all_gas_sensors
  filename = "${path.module}/M5STICKCPLUS_AWS_IOT/${each.value.name}/${each.value.name}-public-key.pem.key"
  content  = aws_iot_certificate.cert_gas_sensors[each.key].public_key
}


// Bittles
resource "local_file" "dynamic_secrets_h_bittles" {
  for_each = var.all_bittles == null ? {} : var.all_bittles
  filename = "${path.module}/ESP8266_AWS_IOT/${each.value.name}/BittleIoTCommands-${each.value.name}/Secrets-${each.value.name}.h"
  content  = <<-EOF
  #include <pgmspace.h>

  #define SECRET

  const char WIFI_SSID[] = "${var.bc_wifi_ssid_1}";    // Your Local SSID/Network Name
  const char WIFI_PASSWORD[] = "${var.bc_wifi_password_1}";   //Your Local Network Password

  #define THINGNAME "${each.value.name}"
  // const char THINGNAME[] = "MyTestBittle1";

  int8_t TIME_ZONE = -5; //NYC(USA): -5 UTC

  const char MQTT_HOST[] = "${data.aws_iot_endpoint.current.endpoint_address}";

  // Insert AWS Root CA1 contents below
  static const char cacert[] PROGMEM = R"EOF(
  -----BEGIN CERTIFICATE-----
  MIIDQTCCAimgAwIBAgITBmyfz5m/jAo54vB4ikPmljZbyjANBgkqhkiG9w0BAQsF
  ADA5MQswCQYDVQQGEwJVUzEPMA0GA1UEChMGQW1hem9uMRkwFwYDVQQDExBBbWF6
  b24gUm9vdCBDQSAxMB4XDTE1MDUyNjAwMDAwMFoXDTM4MDExNzAwMDAwMFowOTEL
  MAkGA1UEBhMCVVMxDzANBgNVBAoTBkFtYXpvbjEZMBcGA1UEAxMQQW1hem9uIFJv
  b3QgQ0EgMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALJ4gHHKeNXj
  ca9HgFB0fW7Y14h29Jlo91ghYPl0hAEvrAIthtOgQ3pOsqTQNroBvo3bSMgHFzZM
  9O6II8c+6zf1tRn4SWiw3te5djgdYZ6k/oI2peVKVuRF4fn9tBb6dNqcmzU5L/qw
  IFAGbHrQgLKm+a/sRxmPUDgH3KKHOVj4utWp+UhnMJbulHheb4mjUcAwhmahRWa6
  VOujw5H5SNz/0egwLX0tdHA114gk957EWW67c4cX8jJGKLhD+rcdqsq08p8kDi1L
  93FcXmn/6pUCyziKrlA4b9v7LWIbxcceVOF34GfID5yHI9Y/QCB/IIDEgEw+OyQm
  jgSubJrIqg0CAwEAAaNCMEAwDwYDVR0TAQH/BAUwAwEB/zAOBgNVHQ8BAf8EBAMC
  AYYwHQYDVR0OBBYEFIQYzIU07LwMlJQuCFmcx7IQTgoIMA0GCSqGSIb3DQEBCwUA
  A4IBAQCY8jdaQZChGsV2USggNiMOruYou6r4lK5IpDB/G/wkjUu0yKGX9rbxenDI
  U5PMCCjjmCXPI6T53iHTfIUJrU6adTrCC2qJeHZERxhlbI1Bjjt/msv0tadQ1wUs
  N+gDS63pYaACbvXy8MWy7Vu33PqUXHeeE6V/Uq2V8viTO96LXFvKWlJbYK8U90vv
  o/ufQJVtMVT8QtPHRh8jrdkPSHCa2XV4cdFyQzR1bldZwgJcJmApzyMZFo6IQ6XU
  5MsI+yMRQ+hDKXJioaldXgjUkK642M4UwtBV8ob2xJNDd2ZhwLnoQdeXeGADbkpy
  rqXRfboQnoZsG4q5WTP468SQvvG5
  -----END CERTIFICATE-----

  )EOF";


  // Copy contents from XXXXXXXX-certificate.pem.crt here ▼
  // device certificate
  static const char client_cert[] PROGMEM = R"KEY(
  ${aws_iot_certificate.cert_bittles[each.key].certificate_pem}
  )KEY";


  // Copy contents from  XXXXXXXX-private.pem.key here ▼
  // device private key
  static const char privkey[] PROGMEM = R"KEY(
  ${aws_iot_certificate.cert_bittles[each.key].private_key}
  )KEY";

  EOF

}
resource "local_file" "dynamic_ino_bittles" {
  for_each = var.all_bittles == null ? {} : var.all_bittles
  filename = "${path.module}/ESP8266_AWS_IOT/${each.value.name}/BittleIoTCommands-${each.value.name}/BittleIoTCommands-${each.value.name}.ino"
  # content  = aws_iot_certificate.cert.public_key
  content = <<-EOF
    #include <ESP8266WiFi.h>
    #include <WiFiClientSecure.h>
    #include <PubSubClient.h>
    #include <ArduinoJson.h>
    #include <time.h>
    #include "Secrets-${each.value.name}.h"
    // #include <Dictionary.h> //https://www.arduino.cc/reference/en/libraries/dictionary/

    // #include "actions.h"

    #define BUILTIN_LED 2

    // // dict object for action
    // Dictionary *actions = new Dictionary(30);


    // humidity
    float h ;
    // temperature
    float t;
    //battery percentage (static for now until fetched using OpenCat)
    float bp;


    unsigned long lastMillis = 0;
    unsigned long previousMillis = 0;
    const long interval = 5000;


    // These must match what is in IoT Core
    #define AWS_IOT_PUBLISH_TOPIC   "${each.value.name}/pub"
    #define AWS_IOT_SUBSCRIBE_TOPIC "${each.value.name}/sub"
    #define AWS_IOT_PUBLISH_TOPIC_GLOBAL   "bittles-global/pub"
    #define AWS_IOT_SUBSCRIBE_TOPIC_GLOBAL "bittles-global/sub"

    WiFiClientSecure net;

    BearSSL::X509List cert(cacert);
    BearSSL::X509List client_crt(client_cert);
    BearSSL::PrivateKey key(privkey);

    PubSubClient client(net);

    time_t now;
    time_t nowish = 1510592825;


    void NTPConnect(void)
    {
      Serial.print("Setting time using SNTP");
      configTime(TIME_ZONE * 3600, 0 * 3600, "pool.ntp.org", "time.nist.gov");
      now = time(nullptr);
      while (now < nowish)
      {
        delay(500);
        Serial.print(".");
        now = time(nullptr);
      }
      Serial.println("done!");
      struct tm timeinfo;
      gmtime_r(&now, &timeinfo);
      Serial.print("Current time: ");
      Serial.print(asctime(&timeinfo));
    }


    void messageReceived(char *topic, byte *payload, unsigned int length)
    {

      // - IMPORTANT: Uncomment these for testing with serial monitor ONLY. These can cause false Bittle commands which can cause unintended movements. -

      // Serial.print("Received [");
      // Serial.print(topic);
      // Serial.print("]: ");
      // for (int i = 0; i < length; i++)
      // {
      //   Serial.print((char)payload[i]);

      // }
      // Serial.println();


      // - Parse the JSON MQTT message using the deserializeJson feature of ArduinoJson Library (https://arduinojson.org/) -
      // - 32 (bytes) is used since the messages are quite small, 16 would probably even be fine. You can test this with the assistant here: (https://arduinojson.org/v6/assistant/#/step1) -
      DynamicJsonDocument doc(32);
      DeserializationError error = deserializeJson(doc, payload);
      if (!error) {
        const char* message_value = doc["message"];

        // println is not being used because during testing, printing each command to a new line caused issues with Bittle's movements.
        Serial.print(message_value);

      } else {
          // error handling
          Serial.print(F("deserializeJson() failed:" ));
          Serial.println(error.f_str());
          return;
      }
    }

    // Lines 101-120 are currently being tested to use a dictionary to allow for more human readable MQTT messages.

    //   /**
    //  * @brief get command argument from request and send to opencat
    //  * @return result
    //  **/
    // String sendCmd(message_value) {
    //   String argname = message_value;

    //   if (actions->search(argname).isEmpty())
    //   {
    //       Serial.print(argname);
    //   }
    //   else
    //   {
    //       Serial.print((*actions)[argname]);
    //   }

    //   // read result
    //   String ret = Serial.readString();
    //   return ret;
    // }


    // Function to Connect to AWS. WiFI Info is defined in the 'Secrets.h' file.
    void connectAWS()
    {
      delay(3000);
      WiFi.mode(WIFI_STA);
      WiFi.begin(WIFI_SSID, WIFI_PASSWORD);

      Serial.println(String("Attempting to connect to SSID: ") + String(WIFI_SSID));

      while (WiFi.status() != WL_CONNECTED)
      {
        Serial.print(".");
        delay(1000);
      }

      NTPConnect();

      net.setTrustAnchors(&cert);
      net.setClientRSACert(&client_crt, &key);

      client.setServer(MQTT_HOST, 8883);
      client.setCallback(messageReceived);


      Serial.println("Connecting to AWS IOT");

      while (!client.connect(THINGNAME))
      {
        Serial.print(".");
        delay(1000);
      }

      if (!client.connected()) {
        Serial.println("AWS IoT Timeout!");
        return;
      }
      // Subscribe to a topic
      client.subscribe(AWS_IOT_SUBSCRIBE_TOPIC);
      client.subscribe(AWS_IOT_SUBSCRIBE_TOPIC_GLOBAL);

      Serial.println("AWS IoT Connected!");
    }

    // Publishes message to IoT Core
    void publishMessage()
    {
      // eventually battery percentage can be a value that is also published
      StaticJsonDocument<200> doc;
      doc["time"] = millis();
      doc["humidity"] = h;
      doc["temperature"] = t;
      doc["battery_percentage"] = bp;
      char jsonBuffer[512];
      serializeJson(doc, jsonBuffer); // print to client

      client.publish(AWS_IOT_PUBLISH_TOPIC, jsonBuffer);
    }


    void setup()
    {
      Serial.begin(115200);
      connectAWS();
      // dht.begin();
    }


    void loop()
    {
      // static values for testing connectivity. For demo there would be variables for actual battery pecentage
      // as well as air quality metrics from the attached sensor.
      h = 10.0;
      t = 45.0;
      bp = 13.47;


      // if (isnan(h) || isnan(t) )  // Check if any reads failed and exit early (to try again).
      // {
      //   Serial.println(F("Failed to read from DHT sensor!"));
      //   return;
      // }

      // Serial.println(F("Device Name: "));
      // Serial.print(THINGNAME);
      // Serial.print(F("  Battery: "));
      // Serial.print(battery_life);
      // Serial.print(F("%  Humidity: "));
      // Serial.print(h);
      // Serial.print(F("%  Temperature: "));
      // Serial.print(t);
      // Serial.println(F("°C "));
      // delay(2000);

      now = time(nullptr);

      if (!client.connected())
      {
        connectAWS();
      }
      else
      {
        client.loop();
        if (millis() - lastMillis > 5000)
        {
          lastMillis = millis();
          publishMessage();
        }
      }
    }

  EOF

}

// Gas Sensors
resource "local_file" "dynamic_secrets_h_gas_sensors" {
  for_each = var.all_gas_sensors == null ? {} : var.all_gas_sensors
  filename = "${path.module}/M5STICKCPLUS_AWS_IOT/${each.value.name}/GasSensorIoT-${each.value.name}/Secrets-${each.value.name}.h"
  content  = <<-EOF
  #include <pgmspace.h>

  #define SECRET

  #define THINGNAME "${each.value.name}"

  #define AWS_IOT_ENDPOINT        "${data.aws_iot_endpoint.current.endpoint_address}"

  #define BITTLE_PUB_TOPIC        "Bittle1/pub"
  #define BITTLE_SUB_TOPIC        "Bittle1/sub"
  #define BITTLE_ACTION_SELF      "khi"

  #define BITTLE_GLOBAL_PUB_TOPIC "bittles-global/pub"
  #define BITTLE_GLOBAL_SUB_TOPIC "bittles-global/sub"
  #define BITTLE_ACTION_GLOBAL    "kck"

  #define DATA_PUB_TOPIC          "${each.value.name}/pub"
  #define DATA_SUB_TOPIC          "${each.value.name}/sub"
  #define SHADOW_GET_PUB_TOPIC    "$aws/things/${each.value.name}/shadow/name/State/get"
  #define SHADOW_GET_SUB_TOPIC    "$aws/things/${each.value.name}/shadow/name/State/get/accepted"
  #define SHADOW_UPDATE_PUB_TOPIC "$aws/things/${each.value.name}/shadow/name/State/update"

  #define WIFI_SSID_1        "${var.bc_wifi_ssid_1}"
  #define WIFI_PASSWORD_1    "${var.bc_wifi_password_1}"
  #define WIFI_SSID_2        "${var.bc_wifi_ssid_2}"
  #define WIFI_PASSWORD_2    "${var.bc_wifi_password_2}"
  #define WIFI_SSID_3        "${var.bc_wifi_ssid_3}"
  #define WIFI_PASSWORD_3    "${var.bc_wifi_password_3}"
  #define WIFI_SSID_4        "${var.bc_wifi_ssid_4}"
  #define WIFI_PASSWORD_4    "${var.bc_wifi_password_4}"


  // Obsolete
  #define DEVICE_NO "1"
  #define GET_ENDPOINT_PUB_TOPIC  "device_init/request_endpoint"
  #define GET_ENDPOINT_SUB_TOPIC  "device_init/down/${each.value.name}"

  // Insert AWS Root CA1 contents below
  static const char AWS_CERT_CA[] PROGMEM = R"EOF(
  -----BEGIN CERTIFICATE-----
  MIIDQTCCAimgAwIBAgITBmyfz5m/jAo54vB4ikPmljZbyjANBgkqhkiG9w0BAQsF
  ADA5MQswCQYDVQQGEwJVUzEPMA0GA1UEChMGQW1hem9uMRkwFwYDVQQDExBBbWF6
  b24gUm9vdCBDQSAxMB4XDTE1MDUyNjAwMDAwMFoXDTM4MDExNzAwMDAwMFowOTEL
  MAkGA1UEBhMCVVMxDzANBgNVBAoTBkFtYXpvbjEZMBcGA1UEAxMQQW1hem9uIFJv
  b3QgQ0EgMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALJ4gHHKeNXj
  ca9HgFB0fW7Y14h29Jlo91ghYPl0hAEvrAIthtOgQ3pOsqTQNroBvo3bSMgHFzZM
  9O6II8c+6zf1tRn4SWiw3te5djgdYZ6k/oI2peVKVuRF4fn9tBb6dNqcmzU5L/qw
  IFAGbHrQgLKm+a/sRxmPUDgH3KKHOVj4utWp+UhnMJbulHheb4mjUcAwhmahRWa6
  VOujw5H5SNz/0egwLX0tdHA114gk957EWW67c4cX8jJGKLhD+rcdqsq08p8kDi1L
  93FcXmn/6pUCyziKrlA4b9v7LWIbxcceVOF34GfID5yHI9Y/QCB/IIDEgEw+OyQm
  jgSubJrIqg0CAwEAAaNCMEAwDwYDVR0TAQH/BAUwAwEB/zAOBgNVHQ8BAf8EBAMC
  AYYwHQYDVR0OBBYEFIQYzIU07LwMlJQuCFmcx7IQTgoIMA0GCSqGSIb3DQEBCwUA
  A4IBAQCY8jdaQZChGsV2USggNiMOruYou6r4lK5IpDB/G/wkjUu0yKGX9rbxenDI
  U5PMCCjjmCXPI6T53iHTfIUJrU6adTrCC2qJeHZERxhlbI1Bjjt/msv0tadQ1wUs
  N+gDS63pYaACbvXy8MWy7Vu33PqUXHeeE6V/Uq2V8viTO96LXFvKWlJbYK8U90vv
  o/ufQJVtMVT8QtPHRh8jrdkPSHCa2XV4cdFyQzR1bldZwgJcJmApzyMZFo6IQ6XU
  5MsI+yMRQ+hDKXJioaldXgjUkK642M4UwtBV8ob2xJNDd2ZhwLnoQdeXeGADbkpy
  rqXRfboQnoZsG4q5WTP468SQvvG5
  -----END CERTIFICATE-----

  )EOF";


  // Copy contents from XXXXXXXX-certificate.pem.crt here ▼
  // device certificate
  static const char AWS_CERT_CRT[] PROGMEM = R"KEY(
  ${aws_iot_certificate.cert_gas_sensors[each.key].certificate_pem}
  )KEY";


  // Copy contents from  XXXXXXXX-private.pem.key here ▼
  // device private key
  static const char AWS_CERT_PRIVATE[] PROGMEM = R"KEY(
  ${aws_iot_certificate.cert_gas_sensors[each.key].private_key}
  )KEY";

  EOF

}
resource "local_file" "dynamic_ino_gas_sensors" {
  for_each = var.all_gas_sensors == null ? {} : var.all_gas_sensors
  filename = "${path.module}/M5STICKCPLUS_AWS_IOT/${each.value.name}/GasSensorIoT-${each.value.name}/GasSensorIoT-${each.value.name}.ino"
  # content  = aws_iot_certificate.cert.public_key
  content = <<-EOF
    // Includes
    #include <M5StickCPlus.h>
    #include <Wire.h>
    #include <Adafruit_SGP30.h>
    #include <ArduinoJson.h>
    #include <time.h>
    #include <WiFiClientSecure.h>
    #include <MQTTClient.h>
    #include "Secrets-${each.value.name}.h"


    // Define parameters
    #define SAMPLE_PERIOD   1  // Frequency to send telemetry updates, seconds
    #define ALARM_OFF   false  // Value for no alarm
    #define ALARM        true  // Value for alarm state
    #define SENSOR_MAX  60000  // Max reading of gas sensor, used for converting to %
    #define BATTERY_MIN  2300  // Min capacity reading of battery
    #define BATTERY_MAX  2888  // Max capacity reading of battery
    #define NET_DISC     "WiFi Disc"      // Text to display when WiFi is disconnected
    #define NET_WIFI     "AWS Disc"       // WiFI connected, AWS disconnected
    #define NET_AWS      "AWS Connected"  // WiFi/AWS is connected

    // Init clients
    WiFiClientSecure wifi_client = WiFiClientSecure();
    MQTTClient mqtt_client = MQTTClient(1024);
    Adafruit_SGP30 sgp;

    // Init variables
    const char*     ntpServer        = "pool.ntp.org";    // Where to get NTP time, needed for TimeStream or SiteWise
    const long      gmtOffset_sec    = 0;
    const int       daylightOffset_sec = 3600;            // Offset correction for time
    static uint16_t alarm_threshold  = 10;                // Threshold to go into alarm state locally
    static bool     alarm_local      = false;             // Is device in alarm due to local sensor readings
    static bool     alarm_remote     = false;             // Is there an alarm from another device
    static float    gas_reading      = 0;                 // Current sensor readings
    long int        start_time       = millis();
    const char*     endpoint         = AWS_IOT_ENDPOINT;  // Phone-home endpoint
    bool            got_endpoint     = true;              // Did I get a new endpoint yet
    int             battery_capacity = -1;                // Battery capacity from device
    int             battery_level    = -1;                // estimate battery percentage, very inaccurate
    const char*     network_state    = NET_DISC;          // Network state to write on screen
    bool            alarm_actioned   = false;             // Keep track if alarm has sent bittle command yet
    bool            alarm_prev       = false;             // Used to track when alarm is reset

    // Define task handle names
    TaskHandle_t CommunicationTaskHandle;     // Handles all WiFi and AWS connectivity and communication
    TaskHandle_t SensorTaskHandle;            // Handles sensor readings
    TaskHandle_t ButtonTaskHandle;            // Handles button presses, M5 button (on front) resets device


    ///////////////////////////////////////////////////////////////////////////////
    // Setup

    void setup(){
        Serial.begin(115200);
        M5.begin();  // Init M5StickCPlus

        // LCD display setup
        M5.Axp.ScreenBreath(10);
        M5.Lcd.setRotation(3);
        M5.Lcd.setTextSize(2);
        M5.Lcd.fillScreen(WHITE);
        M5.Lcd.setTextColor(BLACK);
        M5.Lcd.setCursor(10, 10);
        M5.Lcd.printf(THINGNAME);
        M5.Lcd.setCursor(10, 50);
        M5.Lcd.print("Startup");

        // Init and get the time
        configTime(gmtOffset_sec, daylightOffset_sec, ntpServer);

        // Start tasks
        xTaskCreatePinnedToCore(CommunicationTask, "CommunicationTask", 10000, NULL, 0, &CommunicationTaskHandle, 1);
        xTaskCreatePinnedToCore(SensorTask, "SensorTask", 10000, NULL, 0, &SensorTaskHandle, 0);
        xTaskCreatePinnedToCore(ButtonTask, "ButtonTask", 10000, NULL, 0, &ButtonTaskHandle, 0);
    }


    ///////////////////////////////////////////////////////////////////////////////
    // Loop & Tasks

    // Using main loop for display and other misc tasks
    void loop() {
        // Set alarm state and configure LCD color and message
        if (alarm_local != alarm_prev) {
            if (!alarm_local) {
                alarm_actioned = false;
            }
        }
        alarm_prev = alarm_local;

        if(gas_reading > alarm_threshold) {
            alarm_local = ALARM;
            M5.Lcd.fillScreen(RED);
            M5.Lcd.setTextColor(WHITE);
            M5.Lcd.setCursor(120, 10, 2);
            M5.Lcd.printf("Danger!");
        } else if(alarm_remote == ALARM) {
            alarm_local = ALARM_OFF;
            M5.Lcd.fillScreen(YELLOW);
            M5.Lcd.setTextColor(BLACK);
            M5.Lcd.setCursor(120, 10, 2);
            M5.Lcd.printf("Caution!");
        } else {
            alarm_local = ALARM_OFF;
            M5.Lcd.fillScreen(GREEN);
            M5.Lcd.setTextColor(BLACK);
            M5.Lcd.setCursor(120, 10, 2);
            M5.Lcd.printf("Safe");
        }

        // Update Display
        M5.Lcd.setCursor(10, 10, 1);
        M5.Lcd.printf(THINGNAME);
        M5.Lcd.setCursor(10, 50, 1);
        M5.Lcd.printf("Gas: %3d/%3d", (uint16_t) gas_reading, (uint16_t) alarm_threshold);

        // Battery reporting
        battery_capacity = M5.Axp.GetVapsData();
        if (battery_capacity < BATTERY_MIN) {battery_level = 0;}
        else if (battery_capacity > BATTERY_MAX) {battery_level = 100;}
        else {battery_level = ((battery_capacity - BATTERY_MIN) * 100) / (BATTERY_MAX - BATTERY_MIN);}
        M5.Lcd.setCursor(10, 70, 1);
        M5.Lcd.printf("Bat: %3d/%3d", (uint16_t) battery_level, (uint16_t) battery_capacity);

        // Network state
        M5.Lcd.setCursor(10, 90, 1);
        M5.Lcd.printf("Net: ");
        M5.Lcd.printf(network_state);

        // Wait before doing another loop
        delay(SAMPLE_PERIOD * 1000);
    }


    // Task for communicating with AWS
    void CommunicationTask(void * parameter) {
        connectWiFi();
        //getEndpoint();
        connectAWS();

        for(;;) {
            // If Wifi loses connection, reconnect
            while (WiFi.status() != WL_CONNECTED){
                network_state = NET_DISC;
                Serial.print("WiFi disconnected, reconnecting to WiFi.");
                connectWiFi();
                delay(500);
            }
            network_state = NET_WIFI;

            // If lost connection to AWS, reconnect
            if(!mqtt_client.connected()){
                network_state = NET_WIFI;
                Serial.print("AWS disconnected, reconnecting to AWS.");
                connectAWS();
                delay(500);
            }
            network_state = NET_AWS;

            // Publish message to AWS
            publishMessage();

            // Request shadow
            triggerShadowGet();

            // Pull any messages on subscribed topics
            mqtt_client.loop();

            if (alarm_local) {
                if (!alarm_actioned) {
                    publishActionSelf();
                    delay(1000);
                    publishActionGlobal();

                    alarm_actioned = true;
                }
            }

            delay(SAMPLE_PERIOD * 1000);
        }
    }


    // Task for reading sensors
    void SensorTask(void * parameter) {
          //Init the VOC sensor
        if (!sgp.begin()){
            M5.Lcd.println("Sensor not found");
            delay(1000);
        }

        for(;;) {
            // Commands the sensor to take a single eCO2/VOC measurement.
            if(! sgp.IAQmeasure()) {
                Serial.println("Measurement failed");
            }

            gas_reading = (sgp.TVOC * 100) / SENSOR_MAX;
            //Serial.print("TVOC="); Serial.println(sgp.TVOC);

            delay(SAMPLE_PERIOD * 1000);
        }
    }


    // Task for responding to buttons
    void ButtonTask(void * parameter) {
        // Buttons
        pinMode(M5_BUTTON_HOME,INPUT_PULLUP);

        for(;;) {
            // Buttons
            if(digitalRead(M5_BUTTON_HOME) == LOW){
                ESP.restart();
            }

            delay(10);
        }
    }


    ///////////////////////////////////////////////////////////////////////////////
    // Functions

    // Connects/Reconnects WiFi
    void connectWiFi() {
        Serial.print("Connecting to Wi-Fi");

        WiFi.mode(WIFI_STA);

        int n = WiFi.scanNetworks();
        Serial.print(n); Serial.println(" network(s) found: ");

        for(int i = 0; i < n; i++) {
            Serial.print(i+1); Serial.print(". "); Serial.println(WiFi.SSID(i));
        }

        for(int i = 0; i < n; i++) {
            if(WiFi.SSID(i) == WIFI_SSID_1) {
                Serial.print("Connecting to "); Serial.print(WiFi.SSID(i));
                WiFi.begin(WIFI_SSID_1, WIFI_PASSWORD_1);
                while (WiFi.status() != WL_CONNECTED){
                    delay(1000);
                    Serial.print(".");
                }
                Serial.println("Wi-Fi connected!");
                network_state = NET_WIFI;
                return;
            } else if(WiFi.SSID(i) == WIFI_SSID_2) {
                Serial.print("Connecting to "); Serial.print(WiFi.SSID(i));
                WiFi.begin(WIFI_SSID_2, WIFI_PASSWORD_2);
                while (WiFi.status() != WL_CONNECTED){
                    delay(1000);
                    Serial.print(".");
                }
                Serial.println("Wi-Fi connected!");
                network_state = NET_WIFI;
                return;
            } else if(WiFi.SSID(i) == WIFI_SSID_3) {
                Serial.print("Connecting to "); Serial.print(WiFi.SSID(i));
                WiFi.begin(WIFI_SSID_3, WIFI_PASSWORD_3);
                while (WiFi.status() != WL_CONNECTED){
                    delay(1000);
                    Serial.print(".");
                }
                Serial.println("Wi-Fi connected!");
                network_state = NET_WIFI;
                return;
            } else if(WiFi.SSID(i) == WIFI_SSID_4) {
                Serial.print("Connecting to "); Serial.print(WiFi.SSID(i));
                WiFi.begin(WIFI_SSID_4, WIFI_PASSWORD_4);
                while (WiFi.status() != WL_CONNECTED){
                    delay(1000);
                    Serial.print(".");
                }
                Serial.println("Wi-Fi connected!");
                network_state = NET_WIFI;
                return;
            }
        }
    }


    // Phone's home and gets a new endpoint
    void getEndpoint() {
        // Configure WiFiClientSecure to use the AWS IoT device credentials
        wifi_client.setCACert(AWS_CERT_CA);
        wifi_client.setCertificate(AWS_CERT_CRT);
        wifi_client.setPrivateKey(AWS_CERT_PRIVATE);

        // Connect to the MQTT broker on the AWS endpoint we defined earlier
        mqtt_client.begin(AWS_IOT_ENDPOINT, 8883, wifi_client);

        // Create a message handler
        mqtt_client.onMessage(messageHandler);

        Serial.print("Connecting to AWS IOT for new endpoint");

        while (!mqtt_client.connect(THINGNAME)) {
            Serial.print(".");
            delay(100);
        }
        Serial.println("AWS IoT Connected!");

        // Subscribe to topic for new endpoint
        mqtt_client.subscribe(GET_ENDPOINT_SUB_TOPIC);

        // Craft message with needed values
        StaticJsonDocument<1024> doc;
        doc["device_id"] = THINGNAME;
        doc["device_no"] = DEVICE_NO;

        char jsonBuffer[1024];
        serializeJson(doc, jsonBuffer); // print to client
        mqtt_client.publish(GET_ENDPOINT_PUB_TOPIC, jsonBuffer);

        // Wait until received new endpoint before returning
        Serial.print("Waiting for endpoint response");
        while(!got_endpoint) {
            Serial.print(".");
            mqtt_client.loop();
            delay(500);
        }
        Serial.println("Got new endpoint.");
    }


    // Connect/reconnect to AWS
    void connectAWS() {
        // Configure WiFiClientSecure to use the AWS IoT device credentials
        wifi_client.setCACert(AWS_CERT_CA);
        wifi_client.setCertificate(AWS_CERT_CRT);
        wifi_client.setPrivateKey(AWS_CERT_PRIVATE);

        // Connect to the MQTT broker on the AWS endpoint we defined earlier
        mqtt_client.begin(endpoint, 8883, wifi_client);

        // Create a message handler
        mqtt_client.onMessage(messageHandler);

        Serial.print("Connecting to AWS IOT");

        while (!mqtt_client.connect(THINGNAME)) {
            Serial.print(".");
            delay(100);
        }

        if(!mqtt_client.connected()){
            Serial.println("AWS IoT Timeout!");
            return;
        }

        // Subscribe to a topic
        mqtt_client.subscribe(SHADOW_GET_SUB_TOPIC);

        Serial.println("AWS IoT Connected!");
        network_state = NET_AWS;
    }


    // Publish message to AWS IoT with sensor readings and other info
    void publishMessage() {
        StaticJsonDocument<1024> doc;

        doc["device_id"]        = THINGNAME;
        doc["time"]             = GetEpochTime();
        doc["gas_reading"]      = gas_reading;
        doc["alarm_local"]      = alarm_local;
        doc["alarm_threshold"]  = alarm_threshold;
        doc["battery_capacity"] = battery_capacity;
        doc["battery_level"]    = battery_level;

        char jsonBuffer[1024];
        serializeJson(doc, jsonBuffer); // print to client

        mqtt_client.publish(DATA_PUB_TOPIC, jsonBuffer);
    }


    // Publish message to assigned Bittle
    void publishActionSelf() {
        StaticJsonDocument<1024> doc;

        doc["message"] = BITTLE_ACTION_SELF;

        char jsonBuffer[1024];
        serializeJson(doc, jsonBuffer); // print to client

        mqtt_client.publish(BITTLE_SUB_TOPIC, jsonBuffer);
    }


    // Publish message to Bittle group
    void publishActionGlobal() {
        StaticJsonDocument<1024> doc;

        doc["message"] = BITTLE_ACTION_GLOBAL;

        char jsonBuffer[1024];
        serializeJson(doc, jsonBuffer); // print to client

        mqtt_client.publish(BITTLE_GLOBAL_SUB_TOPIC, jsonBuffer);
    }


    // Send message to Shadow Get topic to illicit a response with shadow data
    void triggerShadowGet() {
        StaticJsonDocument<1024> doc;
        doc["device_id"] = THINGNAME;
        char jsonBuffer[1024];
        serializeJson(doc, jsonBuffer); // print to client
        mqtt_client.publish(SHADOW_GET_PUB_TOPIC, jsonBuffer);
    }


    // Handles incoming messages from subscribed topics
    void messageHandler(String &topic, String &payload) {
        //Serial.println("Incoming: " + topic + " - " + payload);
        StaticJsonDocument<1024> doc;
        deserializeJson(doc, payload);

        // Handle shadow messages
        if(topic == SHADOW_GET_SUB_TOPIC) {
            alarm_remote = doc["state"]["desired"]["alarm_remote"];
            alarm_threshold = doc["state"]["desired"]["alarm_threshold"];
        }

        // Handle new endpoint message
        if(topic == GET_ENDPOINT_SUB_TOPIC) {
            endpoint = doc["endpoint"];
            got_endpoint = true;
        }
    }


    // Function that gets current epoch time
    unsigned long GetEpochTime() {
        time_t now;
        struct tm timeinfo;
        if (!getLocalTime(&timeinfo)) {
            //Serial.println("Failed to obtain time");
            return(0);
        }
        time(&now);
        return now;
    }

  EOF

}
resource "local_file" "env" {
  filename = "${path.root}/../bc-web-app/src/.env"
  content  = <<-EOF
  VITE_REGION=${data.aws_region.current.name}
  VITE_API_ID=${aws_appsync_graphql_api.bc_appsync_graphql_api.id}
  VITE_GRAPHQL_URL=${aws_appsync_graphql_api.bc_appsync_graphql_api.uris.GRAPHQL}
  VITE_IDENTITY_POOL_ID=${aws_cognito_identity_pool.bc_identity_pool.id}
  VITE_USER_POOL_ID=${aws_cognito_user_pool.bc_user_pool.id}
  VITE_APP_CLIENT_ID=${aws_cognito_user_pool_client.bc_user_pool_client.id}
  VITE_IOT_ENDPOINT=${data.aws_iot_endpoint.current.endpoint_address}
  EOF


}



