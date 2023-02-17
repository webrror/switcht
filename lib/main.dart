import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => SwitchProvider(20), // Count of switches provided
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
          brightness: Brightness.dark,
        colorSchemeSeed: Colors.greenAccent
      ),
      home: const MySwitches(
        numSubSwitches: 20, // Count of switches provided
      ),
    );
  }
}

class MySwitches extends StatelessWidget {
  final int numSubSwitches;
  const MySwitches({
    Key? key,
    required this.numSubSwitches,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SwitchProvider>(
      builder: (context, model, child) {
        List<Widget> subSwitchListTiles = [];
        for (int i = 0; i < numSubSwitches; i++) {
          subSwitchListTiles.add(
            SwitchListTile(
              title: Text('Sub Switch ${i + 1}'),
              value: model.subSwitchValues[i],
              onChanged: (bool value) {
                List<bool> subSwitchValues = List.from(model.subSwitchValues);
                subSwitchValues[i] = value;
                model.subSwitchValues = subSwitchValues;
              },
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text("Switch Test"),
          ),
          extendBodyBehindAppBar: true,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SwitchListTile(
                    title: const Text('Master Switch'),
                    value: model.masterSwitchValue,
                    onChanged: (bool value) {
                      model.masterSwitchValue = value;
                    },
                  ),
                  ...subSwitchListTiles,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
