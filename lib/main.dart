import 'package:flutter/material.dart';
void main(){
  runApp(
    const MaterialApp(
      home: harryCurrency(),
    )
  );
}
class harryCurrency extends StatefulWidget {
  const harryCurrency({super.key});
  @override
  State<harryCurrency> createState() => _harryCurrencyState();
}
class _harryCurrencyState extends State<harryCurrency> {
  
  var bigValue=['first','second','third'];
  var smallValue='first';
  var theDisplay='';

  TextEditingController principalController=TextEditingController();
  TextEditingController roiController=TextEditingController();
  TextEditingController termController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
       child: Container(
        width: 480,
        child: Column(
          children: [
            Image.network('https://picsum.photos/250?image=9',height: 200,width: 200,),
            SizedBox(height: 10,),
            TextField(
              controller: principalController,
              decoration: InputDecoration(
                label: Text('Prncipal'),
                border:OutlineInputBorder(borderRadius: BorderRadius.circular(10))
              ),
            ),
            SizedBox(height: 10,),
             TextField(
              controller: roiController,
              decoration: InputDecoration(
                label: Text('Rate of Interest'),
                border:OutlineInputBorder(borderRadius: BorderRadius.circular(10))
              ),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                SizedBox(
                  width: 235,
                  child: TextField(
                    controller: termController,
                    decoration: InputDecoration(
                      label: Text('Term'),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                    ),
                  )
                  ),
                  SizedBox(width: 10,),
                  SizedBox(
                    width: 235,
                    child: Container(
                      decoration: BoxDecoration(
                       border: Border.all(width: 0.5),
                       borderRadius: BorderRadius.circular(10)
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                      borderRadius: BorderRadius.circular(10),
                      padding: EdgeInsets.only(left: 10),
                      value: smallValue,
                      items: bigValue.map((String newValue) {
                        return DropdownMenuItem<String>(
                          value: newValue,
                          child: Text(newValue),
                        );
                      }).toList(),
                      onChanged: <String>(someValue) {
                        setState(() {
                          smallValue=someValue;
                        });
                      },
                      ),
                      )
                      )
                  )
              ],
            ),
            SizedBox(height: 10,),
            Row(
            children: [
              SizedBox(
                width: 235,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 5, 126, 9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                    ),
                  clipBehavior: Clip.hardEdge,
                  onPressed: (){
                    setState(() {
                      this.theDisplay=caluculatTotalReturn();
                    });
                  }, 
                  child: Text('Calculate', style: TextStyle(color: Colors.white),)
                  ),
              ),
              SizedBox(width: 10,),
              SizedBox(
                width: 235,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 112, 101, 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                    ),
                  clipBehavior: Clip.hardEdge,
                  onPressed: (){
                   setState(() {
                     resatResulut();
                   });
                  }, 
                  child: Text('Resat',style: TextStyle(color: Colors.white),)
                  ),
              ),
            ],
            ),
            SizedBox(height: 15,),
            Text(theDisplay)
          ],
        ),
        
       ),
      ),
    );
  }
  String caluculatTotalReturn(){
    double principlal=double.parse(principalController.text);
    double roi=double.parse(roiController.text);
    double term=double.parse(termController.text);
    
    double totalAmoutPay=principlal+(principlal*roi*term)/100;
    String result= "after $term year you resulut will be $totalAmoutPay";
    return result;
  }
  void resatResulut(){
    principalController.text='';
    roiController.text='';
    termController.text='';
    theDisplay='';
    smallValue=bigValue[0];
  }
}