import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class RandomNumber extends StatefulWidget{
  const RandomNumber({super.key});

  @override
  State<RandomNumber> createState() => _RandomNumberState();
}

// Define a corresponding State class.
// This class holds data related to the Form.
class _RandomNumberState extends State<RandomNumber> {
  // Create Two text controllers. These will hold the variables of
  // the textfileds

  final upperBound = TextEditingController();
  int _value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random Number Generator",
        style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Column(     
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,       
            children: [
              SizedBox(
                height: 75,
                child: Column(
                  children: [
                    Text(
                      "Use the built in numberpad.",
                      style: Theme.of(context).textTheme.headlineSmall
                    ),
                    Text(
                      "Do not use an external keyboard to enter numbers.",
                      style: Theme.of(context).textTheme.bodyMedium
                    ),
                  ],
                ),
              ),
              Text(
                "The lower bound is 0.\nEnter the upper bound",
                style: Theme.of(context).textTheme.bodyLarge
              ),
              TextField(
                controller: upperBound,
                decoration: const InputDecoration(labelText: "Enter the Upper Bound"),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                ],
              ),
              //Text(upperBound.text),
              Text("Number: $_value",
                style: Theme.of(context).textTheme.bodyLarge
              ),
              SizedBox(
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,     
                  children: [
                    FilledButton(
                      child: const Text('Generate Random Number'),
                      onPressed: () {
                          setState(() {
                            //print(upperBound.text); 
                            if (upperBound.text != "" && upperBound.text != "0"){
                              var upperNumber = int.parse(upperBound.text)+1;
                              _value = Random().nextInt(upperNumber);
                              debugPrint(upperBound.text);
                              debugPrint("Total number is: $_value");
                            }
                          }
                        );
                      },
                    ),
                    FilledButton.tonal(
                      child: const Text('Copy Number To Clipboard'),
                      onPressed:  () async {
                        await Clipboard.setData(ClipboardData(text: _value.toString()));
                      },
                    ), 
                  ],
                ),
              ),   
            ],
          )
        )
      ) 
    );
  }
}

