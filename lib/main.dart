import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  

  final String title;



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
  


static const platform = MethodChannel('samples.flutter.dev/battery');
String batterLevel = "Unknown Battery level";
Future<void> _getBatteryLevel() async {
  String _batteryLevel;
  try {
    final int result = await platform.invokeMethod('getBatteryLevel');
    _batteryLevel = 'Battery level at $result %';
  } on PlatformException catch (e) {
    _batteryLevel = "Failed to get battery level: ${e.message}";
    
  }
  setState(() {
    batterLevel= _batteryLevel;
  });

}


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
       
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
       
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: () {
              _getBatteryLevel();
            }, 
            child: Text('Get Battery Level')),
            Text(batterLevel),
          ],
        ),
      )
      
    );
  }
}
