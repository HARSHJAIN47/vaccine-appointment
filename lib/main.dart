import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vaccine_appointment/slots.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vaccine Appointer',
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.teal),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //---------------------------------------------------------------//
  TextEditingController pincodecontroller = TextEditingController();
  TextEditingController daycontroller = TextEditingController();
  String dropdownValue = '01';
  List slots = [];
  //---------------------------------------------------------------//

  fetchslots() async {
    await http
        .get(Uri.parse(
            'https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=' +
                pincodecontroller.text +
                '&date=' +
                daycontroller.text +
                '-' +
                dropdownValue +
                '-2021'))
        .then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        slots = result['sessions'];
      });

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Slot(
                    slots: slots,
                  )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vaccination slots'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                child: Image.asset(
                  'assets/vaccine.jpg',
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                maxLength: 6,
                controller: pincodecontroller,
                decoration: InputDecoration(
                  hintText: 'Enter Pin Code',
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 60,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: daycontroller,
                        decoration: InputDecoration(
                          hintText: 'Enter Date',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 54,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.white),
                        underline: Container(
                          height: 2,
                          color: Colors.teal,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: <String>[
                          '01',
                          '02',
                          '03',
                          '04',
                          '05',
                          '06',
                          '07',
                          '08',
                          '09',
                          '10',
                          '11',
                          '12'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    fetchslots();
                  },
                  child: Text('Find Slots'),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor)),
                ),
              ),
              SizedBox(height: 50),
              Text('Developed By Harsh Jain'),
            ],
          ),
        ),
      ),
    );
  }
}
