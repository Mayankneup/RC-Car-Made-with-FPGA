#include <WiFi.h>
#include <WebServer.h>

// WiFi AP credentials
const char* ssid = "ESP32_AP";
const char* password = "12345678";

// Create a web server on port 80
WebServer server(80);

// UART pins for DE10 communication (adjust as needed)
#define RX_PIN 1
#define TX_PIN 3

// Define GPIO pins for control actions
  #define FORWARD_PIN 15
  #define BACKWARD_PIN 2
  #define LEFT_PIN 4
  #define RIGHT_PIN 0

// This function serves a simple HTML page with buttons that use mousedown/up events
void handleRoot() {
  String page = "<html><head><title>Remote Control</title></head><body>";
  page += "<h1>Remote Control</h1>";
  // For each button, send _ON on mousedown and _OFF on mouseup
  page += "<button onmousedown=\"sendCommand('FORWARD_ON')\" onmouseup=\"sendCommand('FORWARD_OFF')\">Forward</button><br><br>";
  page += "<button onmousedown=\"sendCommand('BACKWARD_ON')\" onmouseup=\"sendCommand('BACKWARD_OFF')\">Backward</button><br><br>";
  page += "<button onmousedown=\"sendCommand('LEFT_ON')\" onmouseup=\"sendCommand('LEFT_OFF')\">Left</button><br><br>";
  page += "<button onmousedown=\"sendCommand('RIGHT_ON')\" onmouseup=\"sendCommand('RIGHT_OFF')\">Right</button><br><br>";
  page += "<script>";
  page += "function sendCommand(cmd){";
  page += " var xhr = new XMLHttpRequest();";
  page += " xhr.open('GET', '/' + cmd, true);";
  page += " xhr.send();";
  page += "}";
  page += "</script></body></html>";
  server.send(200, "text/html", page);
}

// Handler for commands from the web page
void handleCommand() {
  String command = server.uri().substring(1); // remove the leading '/'
  Serial.print("Received command: ");
  Serial.println(command);

  // Process the command by checking its suffix (_ON or _OFF) and updating the appropriate GPIO pin
  if (command == "FORWARD_ON") {
    digitalWrite(FORWARD_PIN, HIGH);
    Serial.println("FORWARD: GPIO15 set HIGH");
  } else if (command == "FORWARD_OFF") {
    digitalWrite(FORWARD_PIN, LOW);
    Serial.println("FORWARD: GPIO15 set LOW");
  } else if (command == "BACKWARD_ON") {
    digitalWrite(BACKWARD_PIN, HIGH);
    Serial.println("BACKWARD: GPIO2 set HIGH");
  } else if (command == "BACKWARD_OFF") {
    digitalWrite(BACKWARD_PIN, LOW);
    Serial.println("BACKWARD: GPIO2 set LOW");
  } else if (command == "LEFT_ON") {
    digitalWrite(LEFT_PIN, HIGH);
    Serial.println("LEFT: GPIO0 set HIGH");
  } else if (command == "LEFT_OFF") {
    digitalWrite(LEFT_PIN, LOW);
    Serial.println("LEFT: GPIO0 set LOW");
  } else if (command == "RIGHT_ON") {
    digitalWrite(RIGHT_PIN, HIGH);
    Serial.println("RIGHT: GPIO4 set HIGH");
  } else if (command == "RIGHT_OFF") {
    digitalWrite(RIGHT_PIN, LOW);
    Serial.println("RIGHT: GPIO4 set LOW");
  } else {
    Serial.println("Unknown command");
  }
  
  // Send the command via UART to the DE10 board
  Serial2.println(command);
  
  // Respond back to the client
  server.send(200, "text/plain", "Command processed: " + command);
}

void setup() {
  // Start Serial Monitor for debugging
  Serial.begin(115200);
  while (!Serial) { ; }
  
  // Initialize UART for communication with the DE10 board
  Serial2.begin(115200, SERIAL_8N1, RX_PIN, TX_PIN);
  
  // Set up the GPIO pins as outputs and initialize them to LOW
  pinMode(FORWARD_PIN, OUTPUT);
  pinMode(BACKWARD_PIN, OUTPUT);
  pinMode(LEFT_PIN, OUTPUT);
  pinMode(RIGHT_PIN, OUTPUT);
  digitalWrite(FORWARD_PIN, LOW);
  digitalWrite(BACKWARD_PIN, LOW);
  digitalWrite(LEFT_PIN, LOW);
  digitalWrite(RIGHT_PIN, LOW);
  
  // Set up the ESP32 as an access point
  WiFi.softAP(ssid, password);
  IPAddress IP = WiFi.softAPIP();
  Serial.print("AP IP address: ");
  Serial.println(IP);
  
  // Define web server routes
  server.on("/", handleRoot);
  server.onNotFound(handleCommand);
  
  // Start the web server
  server.begin();
  Serial.println("HTTP server started");
}

void loop() {
  server.handleClient();
}
