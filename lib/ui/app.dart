import 'package:flutter/material.dart';
import '../bloc/provider.dart';
import 'bmi.dart';


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BLoCProvider(
      child: MaterialApp(
        theme: ThemeData(
            textTheme: TextTheme(
              button: TextStyle(color: Colors.white, fontSize: 22.0, fontFamily: 'UbuntuCondensed-Regular'),
              body1: TextStyle(color: Colors.white, fontSize: 60.0, fontFamily: 'UbuntuCondensed-Regular'),
              body2: TextStyle(color: Colors.white, fontSize: 20.0, fontFamily: 'UbuntuCondensed-Regular'),
              title: TextStyle(color: Colors.white, fontSize: 40.0, fontFamily: 'UbuntuCondensed-Regular'),
            )
        ),
        home: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF4ABECB), Color(0xFFC779CF), Color(0xFFFEAC60)]
              )
          ),
          child: BMI(),
        ),
      ),
    );
  }
}