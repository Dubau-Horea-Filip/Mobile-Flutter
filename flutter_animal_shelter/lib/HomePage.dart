// ignore_for_file: file_names, non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:flutter_animal_shelter/Update.dart';
import 'package:flutter_animal_shelter/add.dart';
import 'package:flutter_animal_shelter/messageResponse.dart';
import 'Services/Database_Helper.dart';
import 'models/Pet_model.dart';

class MyHomePage extends StatefulWidget {
  final String _title;

  const MyHomePage(this._title, {super.key});

  @override
  State<StatefulWidget> createState() => _MyhomePage();
}

class _MyhomePage extends State<MyHomePage> {
  // List<Pet> _pets = [
  //   Pet("Rio", "2", "Orange Tabby cat", "vaccinated", "needy"),
  //   Pet("Fio", "3", "cat", "unknow", "nice"),
  //   Pet("Max", "1", "dog", "vaccinated", "playfull"),
  // ];

  List<Pet> _pets = [];

  // This function is used to fetch all data from the database
  void _refreshJournals() async {
    final data = await DataBaseHelper.getPets();
    setState(() {
      _pets = data as List<Pet>;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals(); // Loading the diary when the app starts
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
      ),
      body: ListView.builder(
          itemCount: _pets.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.push(context,
                        MaterialPageRoute(builder: (_) => Update(_pets[index])))
                    .then((newObject) {
                  if (newObject != null) {
                    setState(() {
                      _pets.removeAt(index);
                      _pets.insert(index, newObject);
                      messageRrsponse(context, newObject.name + " was updated");
                    });
                  }
                });
              },
              onLongPress: () {
                removeObject(context, index, _pets[index].name);
              },
              title: Text(_pets[index].name),
              subtitle: Text("${_pets[index].species}\n${_pets[index].age}"),
              leading: CircleAvatar(
                child: Text(_pets[index].name.substring(0, 1)),
              ),
              trailing: const Icon(
                Icons.info,
                color: Colors.blue,
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const addPet()))
              .then((Object) {
            if (Object != null) {
              setState(() {
                Pet ob = Object;
                DataBaseHelper.addPet(ob);
                _refreshJournals();
                //clients.add(Object);
                messageRrsponse(context, Object.name + " was added");
              });
            }
          });
        },
        tooltip: "add",
        child: const Icon(Icons.add),
      ),
    );
  }

  removeObject(BuildContext context, var index, var name) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text("are you sure you want to delete this pet?"),
              content: Text("The pet  $name will be eliminated"),
              actions: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        _pets.removeAt(index);

                        Navigator.pop(context);
                      });
                    },
                    child: const Text("Eliminate",
                        style: TextStyle(color: Colors.red))),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel",
                        style: TextStyle(color: Colors.blue)))
              ],
            ));
  }
}
