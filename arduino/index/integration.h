// Autor: Lucas Fonseca
// Titulo: Trabaho de sig
// Data: 05/06/2023
//.........................................................................................................................
#include <WiFi.h>
#include <HTTPClient.h>

const char* ssid = "Lucas";
const char* password = "2014072276";
const String API_URL = "https://powerful-coast-66741-2297863c9d9a.herokuapp.com/json";


int connectWifi() {

  WiFi.mode(WIFI_STA);  //Optional
  WiFi.begin(ssid, password);
  Serial.println("\nConnecting");

  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(100);
  }

  Serial.println("\nConnected to the WiFi network");
  Serial.print("Local ESP32 IP: ");
  Serial.println(WiFi.localIP());
  return 1;
}


int sendMeasurement(const char* csv) {

  if (WiFi.status() != WL_CONNECTED) { return 0; }

  WiFiClient client;
  HTTPClient http;

  http.begin(client, API_URL);
  http.addHeader("Content-Type", "text/plain");

  Serial.println("\n[HTTP] POST : " + API_URL);

  int httpCode = http.POST(csv);
  Serial.printf("--> code: %d\n\n", httpCode);

  if (httpCode == HTTP_CODE_OK) {
    const String& payload = http.getString();
    Serial.println("received payload:\n<<");
    Serial.println(payload);
    Serial.println(">>");
  }

  http.end();

  return 1;
}