import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class TemperatureConverter extends StatefulWidget{
  const TemperatureConverter({super.key});

  @override
  State<TemperatureConverter> createState() => _TemperatureConverterState();
}

// Define a corresponding State class.
// This class holds data related to the Form.
class _TemperatureConverterState extends State<TemperatureConverter> {
  // Create Two text controllers. These will hold the variables of
  // the textfileds

  final _input = TextEditingController();
  final tempInputController = TextEditingController();
  final tempOutputController = TextEditingController();
  TempInput? selectedInput;
  TempOutput? selectedOutput;
  double _output = 0;

  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    _input.addListener(_printLatestValue);

  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _input.dispose();

    super.dispose();
  }

  void _printLatestValue() {
    setState(() {
      Text(_input.text); 

      var inputType = selectedInput?.tempInput;
      var outputType = selectedOutput?.tempOutput;
      var inputNumber = double.tryParse(_input.text);
      if (inputNumber != null){
        
        _output = inputNumber;
        if (inputType == outputType) {
          _output = inputNumber;
        } else if (inputType == "f"){
          switch(outputType){
            case "c":
              _output = (inputNumber - 32) * (5/9);
              break;
            case "k":
              _output = (inputNumber - 32) * (5/9) + 273.15;
              break;
          }
        } else if (inputType == "c"){
          switch(outputType){
            case "f":
              _output = (inputNumber * (9/5)) + 32;
              break;
            case "k":
              _output = inputNumber + 273.15;
              break;
          }
        } else {
          switch(outputType){
            case "f":
              _output = ((inputNumber - 273.15) * (9/5)) + 32;
              break;
            case "c":
              _output = inputNumber - 273.15;
              break;
          }
        }
        _output = double.parse(_output.toStringAsFixed(2));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    
    final List<DropdownMenuEntry<TempInput>> tempInputEntries =
        <DropdownMenuEntry<TempInput>>[];
    for (final TempInput tempInput in TempInput.values) {
      tempInputEntries.add(DropdownMenuEntry<TempInput>(
        value: tempInput, label: tempInput.label));
    }

    final List<DropdownMenuEntry<TempOutput>> tempOutputEntries =
        <DropdownMenuEntry<TempOutput>>[];
    for (final TempOutput tempOutput in TempOutput.values) {
      tempOutputEntries.add(DropdownMenuEntry<TempOutput>(
        value: tempOutput, label: tempOutput.label));
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Temperature Converter",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DropdownMenu<TempInput>(
                    width: 150,
                    //initialSelection: TempInput.green,
                    controller: tempInputController,
                    label: const Text('From'),
                    dropdownMenuEntries: tempInputEntries,
                    onSelected: (TempInput? tempInput) {
                      //print(tempInput?.tempInput);
                      setState(() {
                        selectedInput = tempInput;
                        //print(selectedInput?.tempInput);
                        _printLatestValue();
                      });
                    },
                  ),
                  const SizedBox(width: 20),
                  DropdownMenu<TempOutput>(
                    width: 150,
                    controller: tempOutputController,
                    label: const Text('To'),
                    dropdownMenuEntries: tempOutputEntries,
                    onSelected: (TempOutput? tempOutput) {
                      //print(tempOutput?.tempOutput);
                      setState(() {
                        selectedOutput = tempOutput;
                        //print(selectedOutput?.tempOutput);
                        _printLatestValue();
                      });
                    },
                  )
                ],
              ),
              /*Text(
                "Enter the upper bound",
                style: Theme.of(context).textTheme.bodyLarge
              ),*/
              TextField(
                controller: _input,
                decoration: const InputDecoration(labelText: "Temperature"),
                  keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: true),
                  /*inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                ],*/
              ),
              //Text(_input.text),
              Text("Output: $_output degrees",
                style: Theme.of(context).textTheme.bodyLarge
              ),
              /*SizedBox(
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,     
                  children: [
                    FilledButton(
                      child: const Text('Generate Random Number'),
                      onPressed: () {
                          setState(() {
                            print(_input.text); 
                            if (_input.text != "" && _input.text != "0"){
                              var upperNumber = int.parse(_input.text);
                              _value = Random().nextInt(upperNumber);
                              debugPrint(_input.text);
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
              ),*/ 
              FilledButton.tonal(
                child: const Text('Copy Number To Clipboard'),
                onPressed:  () async {
                  await Clipboard.setData(ClipboardData(text: _output.toString()));
                },
              ), 
            ],
          )
        )
      ) 
    );
  }
}


enum TempInput {
  fahrenheit('Fahrenheit', 'f'),
  celcius('Celsius', 'c'),
  kelvin('Kelvin', 'k');

  const TempInput(this.label, this.tempInput);
  final String label;
  final String tempInput;
}

enum TempOutput {
  fahrenheit('Fahrenheit', 'f'),
  celcius('Celsius', 'c'),
  kelvin('Kelvin', 'k');

  const TempOutput(this.label, this.tempOutput);
  final String label;
  final String tempOutput;
}