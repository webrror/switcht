import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (context) => SwitchProvider(), child: const MyApp(),));
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
        colorSchemeSeed: Colors.greenAccent
      ),
      home: const MySwitches(),
    );
  }
}

class MySwitches extends StatelessWidget {
  const MySwitches({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SwitchProvider>(
      builder: (context, model, child) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SwitchListTile(
                title: const Text('Master Switch'),
                value: model.masterSwitchValue,
                onChanged: (bool value) {
                  model.masterSwitchValue = value;
                },
              ),
              SwitchListTile(
                title: const Text('Sub Switch 1'),
                value: model.subSwitch1Value,
                onChanged: (bool value) {
                  model.subSwitch1Value = value;
                },
              ),
              SwitchListTile(
                title: const Text('Sub Switch 2'),
                value: model.subSwitch2Value,
                onChanged: (bool value) {
                  model.subSwitch2Value = value;
                },
              ),
              SwitchListTile(
                title: const Text('Sub Switch 3'),
                value: model.subSwitch3Value,
                onChanged: (bool value) {
                  model.subSwitch3Value = value;
                },
              ),
            ],
          ),
        );
      },
    );
  }
}