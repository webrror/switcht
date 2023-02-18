import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => AllProvider(2), // Count of switches provided
    child: const MyApp(),
  ));
}

enum ColorsForColorScheme {
  red,
  green,
  amber,
  pink,
  indigo,
  purple,
  orange,
  deeporange
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = context.watch<AllProvider>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter M3 Showcase',
      theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          colorSchemeSeed: provider.colorScheme),
      darkTheme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          colorSchemeSeed: provider.colorScheme),
      home: const MySwitches(
        numSubSwitches: 2, // Count of switches provided
      ),
    );
  }
}

class MySwitches extends StatefulWidget {
  final int numSubSwitches;
  const MySwitches({
    Key? key,
    required this.numSubSwitches,
  }) : super(key: key);

  @override
  State<MySwitches> createState() => _MySwitchesState();
}

class _MySwitchesState extends State<MySwitches> {
  int selectedIndex = 0;
  List<Map<String, dynamic>> allColorSchemes = [
    {
      'color': "Red",
      'value': Colors.red,
    },
    {
      'color': "Green",
      'value': Colors.green,
    },
    {'color': "Amber", 'value': Colors.amber},
    {'color': "Indigo", 'value': Colors.indigo},
    {'color': "Purple", 'value': Colors.purple},
    {'color': "Orange", 'value': Colors.orange},
    {'color': "Deep Orange", 'value': Colors.deepOrange}
  ];

  Future<void> _dialogBuilder(BuildContext context) {
    var provider = Provider.of<AllProvider>(context, listen: false);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select a color'),
          children: [
            ...allColorSchemes.map((value) {
              return RadioListTile(
                title: Text(value['color']),
                value: value['value'],
                groupValue: provider.colorScheme,
                onChanged: (value) {
                  provider.updateColorScheme(value);
                },
              );
            }),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<AllProvider>();
    List<Widget> subSwitchListTiles = [];
    for (int i = 0; i < widget.numSubSwitches; i++) {
      subSwitchListTiles.add(
        SwitchListTile(
          title: Text('Sub Switch ${i + 1}'),
          value: provider.subSwitchValues[i],
          onChanged: (bool value) async {
            await HapticFeedback.mediumImpact();
            List<bool> subSwitchValues = List.from(provider.subSwitchValues);
            subSwitchValues[i] = value;
            provider.subSwitchValues = subSwitchValues;
          },
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter M3 Showcase"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 5.0, bottom: 10),
                child: Text(
                  "Switches",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SwitchListTile(
                      enableFeedback: true,
                      title: const Text('Master Switch'),
                      value: provider.masterSwitchValue,
                      onChanged: (bool value) async {
                        await HapticFeedback.mediumImpact();
                        provider.masterSwitchValue = value;
                      },
                    ),
                    ...subSwitchListTiles,
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 5.0, bottom: 10),
                child: Text(
                  "Navigation Bar With Badges",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: NavigationBar(
                      onDestinationSelected: (int index) async {
                        await HapticFeedback.lightImpact();
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      selectedIndex: selectedIndex,
                      destinations: <Widget>[
                        const NavigationDestination(
                          icon: Icon(Icons.explore),
                          label: 'Explore',
                        ),
                        const NavigationDestination(
                          icon: Badge(child: Icon(Icons.commute)),
                          label: 'Commute',
                        ),
                        NavigationDestination(
                          selectedIcon: Badge.count(
                              count: 100, child: const Icon(Icons.bookmark)),
                          icon: Badge.count(
                              count: 100,
                              child: const Icon(Icons.bookmark_border)),
                          label: 'Saved',
                        ),
                      ],
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 5.0, bottom: 10),
                child: Text(
                  "Buttons",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                  onPressed: () async {
                                    await HapticFeedback.lightImpact();
                                  },
                                  child: const Text("Elevated")),
                              ElevatedButton.icon(
                                  onPressed: () async {
                                    await HapticFeedback.lightImpact();
                                  },
                                  icon: const Icon(Icons.add),
                                  label: const Text("Icon")),
                              const ElevatedButton(
                                  onPressed: null, child: Text("Elevated")),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FilledButton(
                                  onPressed: () async {
                                    await HapticFeedback.lightImpact();
                                  },
                                  child: const Text("Filled")),
                              FilledButton.icon(
                                  onPressed: () async {
                                    await HapticFeedback.lightImpact();
                                  },
                                  icon: const Icon(Icons.add),
                                  label: const Text("Icon")),
                              const FilledButton(
                                  onPressed: null, child: Text("Filled")),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FilledButton.tonal(
                                  onPressed: () async {
                                    await HapticFeedback.lightImpact();
                                  },
                                  child: const Text("Filled Tonal")),
                              FilledButton.tonalIcon(
                                  onPressed: () async {
                                    await HapticFeedback.lightImpact();
                                  },
                                  icon: const Icon(Icons.add),
                                  label: const Text("Icon")),
                              const FilledButton(
                                  onPressed: null, child: Text("Filled Tonal")),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              OutlinedButton(
                                  onPressed: () async {
                                    await HapticFeedback.lightImpact();
                                  },
                                  child: const Text("Outlined")),
                              OutlinedButton.icon(
                                  onPressed: () async {
                                    await HapticFeedback.lightImpact();
                                  },
                                  icon: const Icon(Icons.add),
                                  label: const Text("Icon")),
                              const OutlinedButton(
                                  onPressed: null, child: Text("Outlined")),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                  onPressed: () async {
                                    await HapticFeedback.lightImpact();
                                  },
                                  child: const Text("Text")),
                              TextButton.icon(
                                  onPressed: () async {
                                    await HapticFeedback.lightImpact();
                                  },
                                  icon: const Icon(Icons.add),
                                  label: const Text("Icon")),
                              const TextButton(
                                  onPressed: null, child: Text("Text")),
                            ],
                          )
                        ],
                      ))),
              const SizedBox(
                height: 120,
              )
            ],
          ),
        ),
      ),
      drawer: const Drawer(),
      floatingActionButton: FloatingActionButton.extended(
        enableFeedback: true,
        tooltip: 'Change color scheme',
        onPressed: () {
          _dialogBuilder(context);
        },
        icon: const Icon(Icons.palette_outlined),
        label: const Text("Theme"),
      ),
    );
  }
}
