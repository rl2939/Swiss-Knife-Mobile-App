import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TipCalculator extends StatefulWidget{
  const TipCalculator({super.key});

  @override
  State<TipCalculator> createState() => _TipCalculatorState();
}

// Define a corresponding State class.
// This class holds data related to the Form.
class _TipCalculatorState extends State<TipCalculator> {
  // Create Two text controllers. These will hold the variables of
  // the textfileds

  final moneyAmount = TextEditingController();
  final tipAmount = TextEditingController();
  double _value = 0;
  //var result = 


  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    moneyAmount.addListener(_printLatestValue);
    tipAmount.addListener(_printLatestValue);

  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    moneyAmount.dispose();
    tipAmount.dispose();

    super.dispose();
  }

  void _printLatestValue() {
    setState(() {
      Text(moneyAmount.text); 
      Text(tipAmount.text); 
      var moneyInt = double.tryParse(moneyAmount.text);
      var tipInt = double.tryParse(tipAmount.text);
      if (moneyInt != null && tipInt != null){
        if (moneyInt >= 0 && tipInt >= 0){
          _value = moneyInt + (moneyInt * (tipInt* .01));
          _value = double.parse(_value.toStringAsFixed(2));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tip Calculator",
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
                "Step 1: Enter Cash Amount",
                style: Theme.of(context).textTheme.bodyLarge
              ),
              TextField(
                controller: moneyAmount,
                decoration: const InputDecoration(labelText: "Enter Cash Amount (USD)"),
                  keyboardType: TextInputType.number,
                  /*inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                ],*/
              ),
              //Text(moneyAmount.text),
              Text(
                "Step 2: Enter Tip",
                style: Theme.of(context).textTheme.bodyLarge
              ),
              TextField(
                controller: tipAmount,
                decoration: const InputDecoration(labelText: "Enter Tip Percentage"),
                  keyboardType: TextInputType.number,
                  /*inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                ],*/
              ),
              //Text(tipAmount.text),
              Text("The total value is $_value.",
                style: Theme.of(context).textTheme.bodyLarge
              ),  
              FilledButton.tonal(
                child: const Text('Copy Tip To Clipboard'),
                onPressed:  () async {
                  await Clipboard.setData(ClipboardData(text: _value.toString()));
                },
              ), 
            ],
          )
        )
      ) 
    );
  }
}

