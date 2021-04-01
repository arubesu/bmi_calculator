import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _heightController = TextEditingController();
  var _weightController = TextEditingController();
  var _bmiResult = "";
  var _formKey = GlobalKey<FormState>();

  void _resetFields() {
    _heightController.text = "";
    _weightController.text = "";

    setState(() {
      _bmiResult = "";
    });
  }

  void _calculate() {
    setState(() {
      var weight = double.parse(_weightController.text);
      var height = double.parse(_heightController.text) / 100;
      var bmi = weight / (height * height);
      var category = "";

      if (bmi < 18.6) {
        category = "Underweight";
      } else if (bmi > 18.6 && bmi < 25) {
        category = "Normal";
      } else if (bmi >= 25 && bmi < 30) {
        category = "Overweight";
      } else if (bmi >= 30) {
        category = "Obesity";
      }
      _bmiResult = "$category (${bmi.toStringAsPrecision(3)})";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("BMI Calculator"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [
            IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields)
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Icon(Icons.person_outline, size: 120, color: Colors.green),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Weigth is required!";
                    }
                  },
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Weight (kg)",
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25)),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Height is required!";
                    }
                  },
                  controller: _heightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Height (cm)",
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25)),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Container(
                height: 50,
                child: ElevatedButton(
                  child: Text("Calculate",
                      style: TextStyle(color: Colors.white, fontSize: 25)),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _calculate();
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                ),
              ),
            ),
            Text("$_bmiResult",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25)),
          ]),
        )));
  }
}
