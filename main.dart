import 'dart:convert';
import 'datapage.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;

void main() {
  runApp(MaterialApp(
      home: Scaffold(
    appBar: AppBar(
      title: Text("OTP Page"),
    ),
    body: MyApp(),
  )));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter Mobile Number',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => mobileNumber = value,
            ),
            ElevatedButton(
              onPressed: sendOTP,
              child: Text('Send OTP'),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter OTP',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ));
                },
                child: Text(" Submit"))
          ],
        ),
      ),
    );
  }

  var mobileNumber;
  var otp;
  var authToken = 'MW1LdTZRMFljdWpaYS9XTFZXRTRnZz09';
  Future<void> sendOTP() async {
    final uri1 =
        Uri.https('akshusofttech.com', '/philbrick/Philbrick_apis/app_login');
    final responseData = await https.post(
      uri1,
      headers: {
        'x-api-key': 'ehello',
        'Client-Service': 'secureclient',
        'Auth-Key': 'authforall',
      },
      body: {
        'mobile': mobileNumber,
      },
    );
    var data = json.decode(responseData.body);
    bool value = data['status'];

    print(value);

    if (value == true) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
    }
  }
}

Future<void> verifyOTP() async {
  var mobileNumber;
  var otp;
  var authToken = 'MW1LdTZRMFljdWpaYS9XTFZXRTRnZz09';
  final uri1 = Uri.parse('akshusofttech.com/philbrick/Philbrick_apis/chk_otp');
  final responseData = await https.post(uri1, headers: {
    'x-api-key': 'ehello',
    'Client-Service': 'secureclient',
    'Auth-key': 'authforall',
    'auth-token': authToken,
  }, body: {
    'otp': otp,
    'mobile': mobileNumber,
  });
  final data = json.decode(responseData.body);
  print(data);
}
