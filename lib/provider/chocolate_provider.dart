import 'package:chocolatecounting/provider/start_stop_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../mymodbus/mod_operation.dart';

class ChocolateProvider with ChangeNotifier {
  List<double> chocolateCount = [];
  List<double> batchCount = [];

  List<double> get getChocolateCounts => chocolateCount;

  List<double> get getBatchCounts => batchCount;

  double chocolateNo = 0.0;
  double batchNo = 0.0;

  double get getChocolateNo => chocolateNo;
  double get getBatchNo => batchNo;

  void initializeChocolateCounts(BuildContext context) async {
    while (context.read<StartStopProvider>().isStartedStatus) {
      print('taking readings from');
      chocolateNo = double.parse(
        await ModbusCommunication.read(0, 1),
      );

      batchNo = double.parse(
        await ModbusCommunication.read(2, 1),
      );

      chocolateCount.add(chocolateNo);
      batchCount.add(batchNo);
      notifyListeners();
    }
  }
}
