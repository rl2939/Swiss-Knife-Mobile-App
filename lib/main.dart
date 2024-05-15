import 'package:flutter/material.dart';
import 'temperature_converter.dart';
import 'tip_calculator.dart';

import 'random_number.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18),
          //bodySmall: TextStyle(fontSize: 16),
        )
      ),
      home: const MyHomePage(title: 'Swiss Knife Toolbox'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Card(
              color: Colors.white60,
              child: SizedBox(
                height: 50,
                child: Center(
                  child: Text("Pick a tool:",
                    style: Theme.of(context).textTheme.titleLarge
                  ),
                )
              ),
            ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              children: [
                // function 1
                Card(
                  clipBehavior: Clip.hardEdge,
                  color: Theme.of(context).colorScheme.secondary,
                  child: InkWell(
                    splashColor: Theme.of(context).colorScheme.tertiary,
                    onTap: (){             
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const TipCalculator()));    
                    },
                    child: SizedBox(
                      height: 75,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              Icons.paid,
                              color: Colors.white,
                              size: 40.0,
                              semanticLabel: 'Coin for Tipping',
                            ),
                            Text("Tip Calculator",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),)
                          ],
                        )
                      ),
                    ),
                  )
                ),
                // function 2
                Card(
                  clipBehavior: Clip.hardEdge,
                  color: Theme.of(context).colorScheme.secondary,
                  child: InkWell(
                    splashColor: Theme.of(context).colorScheme.tertiary,
                    onTap: (){
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const TemperatureConverter()));
                    },
                    child: SizedBox(
                      height: 75,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              Icons.thermostat,
                              color: Colors.white,
                              size: 40.0,
                              semanticLabel: 'Thermostat for Temperature',
                            ),
                            Text("Temperature Converter",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                            )
                          ],
                        )
                      ),
                    ),
                  )
                ),
                // function 3
                Card(
                  clipBehavior: Clip.hardEdge,
                  color: Theme.of(context).colorScheme.secondary,
                  child: InkWell(
                    splashColor: Theme.of(context).colorScheme.tertiary,
                    onTap: (){ 
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const RandomNumber()));       
                    },
                    child: SizedBox(
                      height: 75,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              Icons.casino,
                              color: Colors.white,
                              size: 40.0,
                              semanticLabel: 'Dice for Random Numbers',
                            ),
                            Text("Random Number",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                            )
                          ],
                        )
                      ),
                    ),
                  )
                )
              ],
            )
          ],
        )
      )
    );
  }
}