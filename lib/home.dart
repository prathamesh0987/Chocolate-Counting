import 'package:chocolatecounting/provider/chocolate_provider.dart';
import 'package:chocolatecounting/provider/start_stop_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'mymodbus/mod_operation.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final textFieldKey = TextEditingController();

  @override
  void initState() {
    super.initState();
    connectToPLC();
  }

  void connectToPLC() async {
    print('connecting PLC');
    try {
      await ModbusCommunication.establishConnection(
        '192.168.0.12',
        502,
      );
      print('Connected to PLC');
      // ignore: use_build_context_synchronously
      Future.delayed(
        const Duration(seconds: 2),
        () {
          context.read<StartStopProvider>().isStartedChanged(true);
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 450,
                margin: const EdgeInsets.only(
                  top: 20,
                ),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black54,
                  ),
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 5.0,
                        bottom: 5.0,
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black38,
                          ),
                        ),
                      ),
                      child: const Text(
                        'Total Chocolate Count',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 5.0,
                      ),
                      child: Text(
                        context
                            .watch<ChocolateProvider>()
                            .getChocolateNo
                            .toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 450,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black54,
                  ),
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 5.0,
                        bottom: 5.0,
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black38,
                          ),
                        ),
                      ),
                      child: const Text(
                        'Total Batch Count',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 5.0,
                      ),
                      child: Text(
                        context
                            .watch<ChocolateProvider>()
                            .getBatchNo
                            .toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 650,
            height: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 8.0,
              ),
              onPressed: () {
                context.read<StartStopProvider>().isStartedChanged(false);
              },
              child: const Text(
                'STOP',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  left: 120,
                ),
                width: 300,
                height: 40,
                child: TextFormField(
                  controller: textFieldKey,
                  // style: const TextStyle(
                  //     // color: backgroundEndColor,
                  //     ),
                  // inputFormatters: [
                  //   FilteringTextInputFormatter.,
                  // ],
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        25,
                      ),
                      borderSide: const BorderSide(
                        width: 1,
                        // color: backgroundEndColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                        // color: backgroundEndColor,
                      ),
                      borderRadius: BorderRadius.circular(
                        25,
                      ),
                    ),
                    labelText: 'Search by Date',
                    // labelStyle: const TextStyle(
                    //   color: textColor,
                    // ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 350,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 8.0,
                  ),
                  onPressed: () {},
                  child: const Text(
                    'SEARCH',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
