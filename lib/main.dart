import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color iconColor = Colors.black;
  int ledState = 0;
  Text textState = Text("ON");
  final dbR = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Iot App 08"),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text("LED 01"),
              SizedBox(height: 20),
              Icon(Icons.lightbulb, color: iconColor),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (ledState == 0) {
                      ledState = 1;
                      iconColor = Colors.yellow;
                      textState = Text("OFF");
                    } else {
                      ledState = 0;
                      iconColor = Colors.black;
                      textState = Text("ON");
                    }
                    dbR.child("light").set({"awitch": ledState});
                  });
                },
                child: textState,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
