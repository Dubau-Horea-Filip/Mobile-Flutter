import 'package:flutter/material.dart';
import 'package:flutter_animal_shelter/HomePage.dart';
import 'package:flutter_animal_shelter/textbox.dart';

class addPet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _addPet();
}

class _addPet extends State<addPet> {
  late TextEditingController controllerName;
  late TextEditingController controllerAge;
  late TextEditingController controllerSpecies;
  late TextEditingController controllerBehaviour;
  late TextEditingController controllerMD;

  @override
  void initState() {
    controllerName = new TextEditingController();
    controllerAge = new TextEditingController();
    controllerSpecies = new TextEditingController();
    controllerBehaviour = new TextEditingController();
    controllerMD = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add an object"),
      ),
      body: ListView(
        children: [
          TextBox(controllerName, "Name"),
          TextBox(controllerAge, "age"),
          TextBox(controllerSpecies, "species"),
          TextBox(controllerBehaviour, "behaviour"),
          TextBox(controllerMD, "Mediacl Records"),
          ElevatedButton(
              onPressed: () {
                String name = controllerName.text;
                String age = controllerAge.text;
                String species = controllerSpecies.text;
                String behaviour = controllerBehaviour.text;
                String md = controllerMD.text;
                if (name.isNotEmpty &&
                    age.isNotEmpty &&
                    species.isNotEmpty &&
                    behaviour.isNotEmpty &&
                    md.isNotEmpty) {
                  Navigator.pop(
                      context, new Pet(name, age, species, behaviour, md));
                } else {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            //title: Text("opa"),
                            content: Text(
                                "All filds shoud be filled and age shoud be a number"),
                          ));
                }
              },
              child: Text("add pet"))
        ],
      ),
    );
  } //build

}
