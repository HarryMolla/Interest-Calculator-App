import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: harryCurrency(),
  ));
}

class harryCurrency extends StatefulWidget {
  const harryCurrency({super.key});
  @override
  State<harryCurrency> createState() => _harryCurrencyState();
}

class _harryCurrencyState extends State<harryCurrency> {
  var _formKey = GlobalKey<FormState>();
  var bigValue = ['Birr', 'Dollar', 'Pound'];
  var smallValue = null;
  var theDisplay = '';

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();
  String? principalError;
  String? termError;
  String? RoiError;
  bool _isWhite=true;
  void _bagroundColorToggle(){
    setState(() {
      _isWhite=!_isWhite;
    });
  }

  void validatePrincipal(String value) {
    setState(() {
      if (value.isEmpty) {
        principalError = 'Principal is required';
      } else if (int.tryParse(value) == null) {
        principalError = 'Please type only numbers';
      } else {
        principalError = null; // Clear error if valid
      }
    });
  }

  void validateRoi(String value) {
    setState(() {
      if (value.isEmpty) {
        RoiError = 'Rate of Interest is required';
      } else if (int.tryParse(value) == null) {
        RoiError = "Type only numbers";
      } else {
        RoiError = null;
      }
    });
  }

  void validateTerm(String value) {
    setState(() {
      if (value.isEmpty) {
        termError = "Term is required";
      } else if (int.tryParse(value) == null) {
        termError = "Type only numbers";
      } else {
        termError = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isWhite? const Color.fromARGB(255, 240, 240, 240):Colors.black,
      appBar: AppBar(
        backgroundColor: _isWhite? const Color.fromARGB(255, 240, 240, 240):Colors.black,
        actions: [
          IconButton(
            onPressed: _bagroundColorToggle, 
            icon: Icon(
              _isWhite? Icons.sunny:Icons.dark_mode
              ),
              color: _isWhite? Colors.black:Colors.white,
              ),
              Icon(Icons.abc, color: Color.fromRGBO(0, 0, 0, 0),)
          ],),
      body: SingleChildScrollView(child: 
      Center(
        child: Form(
          key: _formKey,
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image.asset('lib/Img/interst.png',
                          width: 200, height: 200),
                      const Text(
                        'Interest Calculator',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Color.fromRGBO(2, 55, 55, 1),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                 SizedBox(
                  width: 480,
                  child:  TextFormField(
                    onChanged: validatePrincipal,
                    controller: principalController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: Text('Principal'),
                      errorText: principalError,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                 ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 480,
                    child: TextFormField(
                    onChanged: validateRoi,
                    controller: roiController,
                    decoration: InputDecoration(
                        errorText: RoiError,
                        label: Text('Rate of Interest'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    
                    child: 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 235,
                          child: TextFormField(
                            onChanged: validateTerm,
                            controller: termController,
                            decoration: InputDecoration(
                                errorText: termError,
                                label: Text('Term'),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                          width: 235,
                          height: 55,
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 235, 235, 235),
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  borderRadius: BorderRadius.circular(10),
                                  hint: Text('Select Curruncy'),
                                  value: smallValue,
                                  padding: EdgeInsets.only(left: 40, right: 45),
                                  items: bigValue.map((String newValue) {
                                    return DropdownMenuItem<String>(
                                      value: newValue,
                                      child: Center(child: Text(newValue)),
                                    );
                                  }).toList(),
                                  onChanged: <String>(someValue) {
                                    setState(() {
                                      smallValue = someValue;
                                    });
                                  },
                                ),
                              )))
                    ],
                  ),),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 235,
                        height: 55,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 5, 126, 9),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            clipBehavior: Clip.hardEdge,
                            onPressed: () {
                              validatePrincipal(principalController.text);
                              validateRoi(roiController.text);
                              validateTerm(termController.text);

                              if (_formKey.currentState != null &&
                                  _formKey.currentState!.validate()) {
                                this.theDisplay = caluculatTotalReturn();
                              }
                            },
                            child: Text(
                              'Calculate',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 235,
                        height: 55,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                side: BorderSide(width: 1, color: Colors.red),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () {
                              setState(() {
                                resatResulut();
                              });
                            },
                            child: Text(
                              'Reset',
                              style: TextStyle(color: Colors.red),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Result:'),
                  Text(theDisplay)
                ],
              )),
        ),
      )),
    );
  }

  String caluculatTotalReturn() {
    double principlal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmoutPay = principlal + (principlal * roi * term) / 100;
    String result = "After $term years interest rate will be $totalAmoutPay";
    return result;
  }

  void resatResulut() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    theDisplay = '';
    smallValue = bigValue[0];
  }
}
