// Autor: Lucas Fonseca
// Titulo: Trabaho de sig
// Data: 05/06/2023
//.........................................................................................................................

#include <DHT.h>
#include <WiFi.h>
#include <HTTPClient.h>
#define DHTPIN 21      // Define o pino de conexão do sensor ao Arduino
#define DHTTYPE DHT11  // Define o tipo de sensor (DHT11 ou DHT22)
DHT dht(DHTPIN, DHTTYPE);
#define INTERVAL 1000  // Intervalo de Tempo entre medições (ms)
// integration
const char* ssid = "Lucas";
const char* password = "2014072276";
const String API_URL = "http://powerful-coast-66741-2297863c9d9a.herokuapp.com/json";

struct
{
  float temperature = 0;
  float humidity = 0;
} Data;

void setup() {
  Serial.begin(115200);
  delay(1000);
  Serial.println("\n\n Iniciando trabalho de sig \n");
  connectWifi();
  dht.begin();
}

void loop() {
  Serial.println("\nIniciando medições");
  long startTime = millis();
  while (millis() < startTime + INTERVAL) {}
  DHTRead();

  Serial.print("Umidade: ");
  Serial.print(Data.humidity);
  Serial.print("%\t");
  Serial.print("Temperatura: ");
  Serial.print(Data.temperature);
  Serial.println("°C");

  char json_output[255];
  const char* json_header ="{ \"timestamp\": %d, \"humidity\": %.2f, \"temperature\": %.2f }";
  sprintf(json_output, json_header, startTime + INTERVAL, Data.humidity, Data.temperature);
  sendMeasurement(json_output);
}

void DHTRead() {

  float humidity = dht.readHumidity();        // umidade relativa
  float temperature = dht.readTemperature();  //  temperatura em graus Celsius
  // Verifica se alguma leitura falhou
  if (isnan(humidity) || isnan(temperature)) {
    Serial.println("Falha ao ler o sensor DHT!");
    return;
  }

  Data.humidity = humidity;
  Data.temperature = temperature;
}


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