
import 'package:flutter/material.dart';
import 'package:flutter_animal_shelter/HomePage.dart';


//void main() => runApp( Shelter());

class Shelter extends StatelessWidget{
  //const Shelter({super.key});

  //const Shelter({super.key});

  @override
  Widget build (BuildContext context)
  {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Shelter",
      home: MyHomePage("context"),
    );
  }

}