Remote connect

adb tcpip 5555
<!-- adb connect 10.212.0.75:5555 -->
adb connect 192.168.2.20:5555

Run on mobile browser

1. flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0
2. Open cmd->type ipconfig->copy ip address
3. Open your mobile browser and type: http://<your-ip>:8080