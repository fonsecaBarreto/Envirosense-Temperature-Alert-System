// Autor: Lucas Fonseca
// Titulo: Trabaho de sig
// Data: 05/06/2023
//.........................................................................................................................

#include <DHT.h>
#include "integration.h"
#define DHTPIN 21      // Define o pino de conexão do sensor ao Arduino
#define DHTTYPE DHT11  // Define o tipo de sensor (DHT11 ou DHT22)
DHT dht(DHTPIN, DHTTYPE);
#define INTERVAL 1000  // Intervalo de Tempo entre medições (ms)
#define DEBOUNCE_DELAY 25

void setup() {
  Serial.begin(115200);
  delay(1000);
  Serial.println("\n\n Iniciando trabalho de sig \n");
  // integrações
  connectWifi();
  dht.begin();
}

struct
{
  float temperature = 0;
  float humidity = 0;
} Data;

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

  const char* csv_header ="timestamp,humidity,temperature\n%d,%.2f,%.2f";
  char csv_output[255];
  sprintf(csv_output, csv_header, startTime + INTERVAL, Data.humidity,Data.temperature);
  sendMeasurement(csv_output);
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