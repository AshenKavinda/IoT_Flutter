import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // Ensure Flutter bindings are initialized before Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color iconColor = Colors.black;
  int ledState = 0;
  final dbR = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("IoT App 08"),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("LED 01"),
              const SizedBox(height: 20),
              Icon(Icons.lightbulb, color: iconColor, size: 60),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (ledState == 0) {
                      ledState = 1;
                      iconColor = Colors.yellow;
                    } else {
                      ledState = 0;
                      iconColor = Colors.black;
                    }
                    // Write to Firebase
                    dbR.child("light").set({"awitch": ledState});
                  });
                },
                child: Text(ledState == 0 ? "ON" : "OFF"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
