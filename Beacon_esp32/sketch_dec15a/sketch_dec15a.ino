#include <WiFi.h>
#include <WebServer.h>
#include <NimBLEDevice.h>
#include <NimBLEServer.h>
#include <NimBLEUtils.h>
#include <EEPROM.h>

const char* ssid = "ESP32_AP";
const char* password = "123456789";
const int bleDeviceNameAddr = 0; // Endereço na EEPROM para armazenar o nome do dispositivo BLE

WebServer server(80);
BLEServer *pServer = NULL;
BLECharacteristic *pCharacteristic = NULL;
bool deviceConnected = false;
bool oldDeviceConnected = false;
String dadosRecebidos;
String bleDeviceName;

void handleRoot() {
  String pagina = "<html><body>";
  pagina += "<h1>Configuração do Dispositivo BLE</h1>";
  pagina += "<form action='/configurar' method='POST'>";
  pagina += "Nome do Dispositivo BLE: <input type='text' name='nome' value='" + bleDeviceName + "'><br>";
  pagina += "<input type='submit' value='Salvar'>";
  pagina += "</form></body></html>";
  server.send(200, "text/html", pagina);
}

void handleConfigurar() {
  if (server.hasArg("nome")) {
    bleDeviceName = server.arg("nome");
    server.send(200, "text/plain", "Nome do dispositivo BLE configurado com sucesso!");
    // Atualiza o nome do dispositivo BLE
    NimBLEDevice::setDeviceName(bleDeviceName.c_str());
    // Armazena o nome na EEPROM
    EEPROM.put(bleDeviceNameAddr, bleDeviceName);
    EEPROM.commit();
  } else {
    server.send(400, "text/plain", "Requisição inválida - nome ausente");
  }
}

void setup() {
  Serial.begin(115200);

  // Inicializa a memória EEPROM
  EEPROM.begin(512);

  // Lê o nome do dispositivo BLE da EEPROM
  EEPROM.get(bleDeviceNameAddr, bleDeviceName);

  // Se o nome estiver vazio, define um valor padrão
  if (bleDeviceName.length() == 0) {
    bleDeviceName = "MeuDispositivoBLE";
  }

  // Configura BLE
  NimBLEDevice::init(bleDeviceName.c_str());
  NimBLEDevice::setPower(ESP_PWR_LVL_P9); // Configura a potência do BLE (opcional)
  pServer = NimBLEDevice::createServer();
  NimBLEService *pService = pServer->createService(NimBLEUUID("4fafc201-1fb5-459e-8fcc-c5c9c331914b"));
  pCharacteristic = pService->createCharacteristic(
      NimBLEUUID("beb5483e-36e1-4688-b7f5-ea07361b26a8"),
      NIMBLE_PROPERTY::READ | NIMBLE_PROPERTY::WRITE | NIMBLE_PROPERTY::NOTIFY
  );
  pService->start();
  NimBLEAdvertising *pAdvertising = pServer->getAdvertising();
  pAdvertising->start();

  // Configura Wi-Fi
  WiFi.softAP(ssid, password);
  IPAddress IP = WiFi.softAPIP();
  Serial.print("Endereço IP do AP: ");
  Serial.println(IP);
  server.on("/", HTTP_GET, handleRoot);
  server.on("/configurar", HTTP_POST, handleConfigurar);
  server.begin();
}

void loop() {
  server.handleClient();

  if (deviceConnected) {
    pCharacteristic->notify();
    delay(1000);
  }

  if (!deviceConnected && oldDeviceConnected) {
    delay(500);
    pServer->startAdvertising(); // Inicia o advertising novamente
    Serial.println("start advertising");
    oldDeviceConnected = deviceConnected;
  }
  
  if (deviceConnected && !oldDeviceConnected) {
    // do stuff here on connecting
    oldDeviceConnected = deviceConnected;
  }
}
