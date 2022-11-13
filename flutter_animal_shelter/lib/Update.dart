import 'package:flutter/material.dart';
import 'package:flutter_animal_shelter/HomePage.dart';
import 'package:flutter_animal_shelter/textbox.dart';

class Update extends StatefulWidget {
  final Pet _pet;

  const Update(this._pet);

  @override
  State<StatefulWidget> createState() => _Update();
} // end Update class

class _Update extends State<Update> {
  late TextEditingController controllerName;
  late TextEditingController controllerAge;
  late TextEditingController controllerSpecies;
  late TextEditingController controllerBehaviour;
  late TextEditingController controllerMD;

  @override
  void initState() {
    Pet c = widget._pet;
    controllerName = new TextEditingController(text: c.name);
    controllerAge = new TextEditingController(text: c.age);
    controllerSpecies = new TextEditingController(text: c.species);
    controllerBehaviour = new TextEditingController(text: c.behaviour);
    controllerMD = new TextEditingController(text: c.medical_records);
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
                    _isNumeric(age) &&
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
              child: Text("update pet"))
        ],
      ),
    );
  }

  bool _isNumeric(String str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }
}// end _Update class