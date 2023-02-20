resource "local_file" "device_certificate" {
  for_each = var.all_bittles == null ? {} : var.all_bittles
  filename = "${path.module}/ESP8266_AWS_IOT/${each.value.name}/${each.value.name}-device-certificate.pem"
  content  = aws_iot_certificate.cert[each.key].certificate_pem
}
resource "local_file" "private_key" {
  for_each = var.all_bittles == null ? {} : var.all_bittles
  filename = "${path.module}/ESP8266_AWS_IOT/${each.value.name}/${each.value.name}-private-key.pem.key"
  content  = aws_iot_certificate.cert[each.key].private_key
}
resource "local_file" "public_key" {
  for_each = var.all_bittles == null ? {} : var.all_bittles
  filename = "${path.module}/ESP8266_AWS_IOT/${each.value.name}/${each.value.name}-public-key.pem.key"
  content  = aws_iot_certificate.cert[each.key].public_key
}



resource "local_file" "dynamic_secrets_h" {
  for_each = var.all_bittles == null ? {} : var.all_bittles
  filename = "${path.module}/ESP8266_AWS_IOT/${each.value.name}/BittleIoTCommands-${each.value.name}/Secrets-${each.value.name}.h"
  content  = <<-EOF
  #include <pgmspace.h>

  #define SECRET

  const char WIFI_SSID[] = "${var.bc_local_ssid}";    // Your Local SSID/Network Name
  const char WIFI_PASSWORD[] = "${var.bc_local_network_password}";   //Your Local Network Password

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
  ${aws_iot_certificate.cert[each.key].certificate_pem}
  )KEY";


  // Copy contents from  XXXXXXXX-private.pem.key here ▼
  // device private key
  static const char privkey[] PROGMEM = R"KEY(
  ${aws_iot_certificate.cert[each.key].private_key}
  )KEY";

  EOF

}
resource "local_file" "dynamic_ino" {
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

resource "local_file" "outputs" {
  filename = "${path.module}/outputs.json"
  content = jsonencode({
    comments = "DO NOT MODIFY THIS FILE MANUALLY. IT IS AUTOGENERATED ON SUCCESSFUL TERRAFORM APPLY. MAKE ANY NECESSARY CHANGES IN localfile.tf"
    outputs = {
      bc_aws_current_region = {
        value = "${data.aws_region.current.name}"
      },
      # IoT
      bc_iot_endpoint = {
        value = "${data.aws_iot_endpoint.current.endpoint_address}"
      }
      # AppSync
      bc_appsync_graphql_api_region = {
        value = "${data.aws_region.current.name}"
      },
      bc_appsync_graphql_api_id = {
        value = "${aws_appsync_graphql_api.bc_appsync_graphql_api.id}"
      },
      bc_appsync_graphql_api_uris = {
        value = {
          GRAPHQL  = "${aws_appsync_graphql_api.bc_appsync_graphql_api.uris.GRAPHQL}",
          REALTIME = "${aws_appsync_graphql_api.bc_appsync_graphql_api.uris.REALTIME}"
        }
      },
      # Cognito
      bc_user_pool_region = {
        value = "${data.aws_region.current.name}"
      },
      bc_user_pool_id = {
        value = "${aws_cognito_user_pool.bc_user_pool.id}"
      },
      bc_user_pool_client_id = {
        value = "${aws_cognito_user_pool_client.bc_user_pool_client.id}"
      },
      bc_identity_pool_id = {
        value = "${aws_cognito_identity_pool.bc_identity_pool.id}"
      },
      # S3
      bc_landing_bucket = {
        value = "${aws_s3_bucket.bc_landing_bucket.id}"
      },
      bc_input_bucket = {
        value = "${aws_s3_bucket.bc_input_bucket.id}"
      },
      bc_devices_bucket = {
        value = "${aws_s3_bucket.bc_devices_bucket.id}"
      },
      bc_app_storage_bucket = {
        value = "${aws_s3_bucket.bc_app_storage_bucket.id}"
      },

    }
  })
}



