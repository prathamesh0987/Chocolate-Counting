import 'package:modbus/modbus.dart' as modbus;

class ModbusCommunication {
  static late modbus.ModbusClient client;

  static Future<void> establishConnection(String address, int port) async {
    client = modbus.createTcpClient(
      address,
      port: port,
    );
    await client.connect();
  }

  static Future<int> send(int address, int value) async {
    return client.writeSingleRegister(address, value);
  }

  static Future<String> read(int address, int amount) async {
    var data = await client.readHoldingRegisters(address, amount);
    String registerData = "";
    //print(data);

    for (int i = 0; i < data.length; i++) {
      registerData = data.elementAt(i).toString();
      // registerData += data.elementAt(i).toStringAsFixed(3);
    }
    return registerData;
  }
}
