#include <WiFi.h>
#include <WebServer.h>
#include <NimBLEDevice.h>
#include <NimBLEServer.h>
#include <NimBLEUtils.h>
#include <EEPROM.h>

const char* ssid = "ESP32_AP"; // nome da rede wifi
const char* password = "12345678"; // senha da rede wifi
const int bleDeviceNameAddr = 0; // Endereço na EEPROM para armazenar o nome do dispositivo BLE

WebServer server(80);
BLEServer *pServer = NULL;
BLECharacteristic *pCharacteristic = NULL;
bool deviceConnected = false;
bool oldDeviceConnected = false;
String dadosRecebidos;
String bleDeviceName;

void handleRoot() {
  // Imagem base64 do logotipo do Google
  const char* google_logo = "data:image/jpg;base64,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";
  // HTML com o fundo laranja e logotipo do Google
  String pagina = "<html><head>";
  pagina += "<meta charset='UTF-8'>";
  pagina += "<style>";
  pagina += "body { background-color: #FE6301; }";
  pagina += "h1 { color: white; }";
  pagina += "form { background-color: white; padding: 20px; border-radius: 10px; }";
  pagina += "</style>";
  pagina += "</head><body>";
  pagina += "<img src='" + String(google_logo) + "' alt='Logo Google' style='width:150px;'><br>";
  pagina += "<h1>Configuração do Beacon</h1>";
  pagina += "<form action='/configurar' method='POST'>";
  pagina += "Nome da Agência: <input type='text' name='nome' value='" + bleDeviceName + "'><br>";
  pagina += "<input type='submit' value='Salvar'>";
  pagina += "</form></body></html>";

  // Enviar a página HTML
  server.send(200, "text/html", pagina);
}





void handleConfigurar() {
  if (server.hasArg("nome")) {
    bleDeviceName = server.arg("nome");
    server.send(200, "text/plain", "Nome do dispositivo BLE configurado com sucesso!");
    // Atualiza o nome do dispositivo BLE
    NimBLEDevice::setDeviceName(bleDeviceName.c_str());
    // Armazena o nome na EEPROM
    EEPROM.writeString(bleDeviceNameAddr, bleDeviceName);
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
  bleDeviceName = EEPROM.readString(bleDeviceNameAddr);

  // Se o nome estiver vazio, define um valor padrão
  if (bleDeviceName.length() == 0) {
    bleDeviceName = "sem registro";
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
  
  // Configura o anúncio BLE
  NimBLEAdvertising *pAdvertising = NimBLEDevice::getAdvertising();
  pAdvertising->addServiceUUID(pService->getUUID()); // Adiciona o UUID do serviço ao anúncio
  // Aqui você pode adicionar mais informações de anúncio, como serviceUuids
  // Por exemplo, se você tiver vários serviços, pode adicionar seus UUIDs
  // pAdvertising->setScanResponse(true); // Se necessário, define como resposta de varredura
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
    oldDeviceConnected = deviceConnected;
  }
}
