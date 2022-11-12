import 'package:flutter/material.dart';
import 'package:flutter_animal_shelter/HomePage.dart';
import 'package:flutter_animal_shelter/textbox.dart';

class Update extends StatefulWidget {
  final Client _client;

  const Update(this._client);

  @override
  State<StatefulWidget> createState() => _Update();
} // end Update class

class _Update extends State<Update> {
  late TextEditingController controllerName;
  late TextEditingController controllerSurnameName;
  late TextEditingController controllerNumber;

  @override
  void initState() {
    Client c = widget._client;
    controllerName = new TextEditingController(text: c.name);
    controllerSurnameName = new TextEditingController(text: c.Surname);
    controllerNumber = new TextEditingController(text: c.phone);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Object"),
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
              child: Text("update object"))
        ],
      ),
    );
  }
}// end _Update class