import 'package:flutter/material.dart';
import 'package:flutter_animal_shelter/HomePage.dart';
import 'package:flutter_animal_shelter/textbox.dart';

class addPet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _addPet();
}

class _addPet extends State<addPet> {
  late TextEditingController controllerName;
  late TextEditingController controllerSurnameName;
  late TextEditingController controllerNumber;

  @override
  void initState() {
    controllerName = new TextEditingController();
    controllerSurnameName = new TextEditingController();
    controllerNumber = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add a pet"),
      ),
      body: ListView(
        children: [
          TextBox(controllerName, "Name"),
          TextBox(controllerSurnameName, "Surname"),
          TextBox(controllerNumber, "Number"),
          ElevatedButton(
              onPressed: () {
                String name = controllerName.text;
                String phone = controllerNumber.text;
                String Surname = controllerSurnameName.text;
                if (name.isNotEmpty && Surname.isNotEmpty && phone.isNotEmpty) {
                  Navigator.pop(context, new Client(name, Surname, phone));
                }
              },
              child: Text("add object"))
        ],
      ),
    );
  } //build

}
