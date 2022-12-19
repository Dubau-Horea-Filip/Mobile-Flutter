// ignore_for_file: file_names, non_constant_identifier_names, avoid_types_as_parameter_names, prefer_const_constructors

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
  List<Pet> _pets = [];

  // final List<Pet> _pets = [
  //   Pet(
  //       name: "Rio",
  //       age: 2,
  //       species: "Orange Tabby cat",
  //       medical_records: "vaccinated",
  //       behaviour: "needy"),
  //   Pet(
  //       name: "Fio",
  //       age: 3,
  //       species: "cat",
  //       medical_records: "unknow",
  //       behaviour: "nice"),
  //   Pet(
  //       name: "Max",
  //       age: 1,
  //       species: "dog",
  //       medical_records: "vaccinated",
  //       behaviour: "playfull"),
  // ];

  // List<Pet> _pets = [
  //   Pet("Rio", "2", "Orange Tabby cat", "vaccinated", "needy"),
  //   Pet("Fio", "3", "cat", "unknow", "nice"),
  //   Pet("Max", "1", "dog", "vaccinated", "playfull"),
  // ];

  //This function is used to fetch all data from the database
  void _refresh() async {
    final data = await DataBaseHelper.getPets();
    setState(() {
      _pets = data!;
    });
  }

  @override
  void initState() {
    super.initState();

    // DataBaseHelper.addPet(Pet(
    //     name: "Rio",
    //     age: 2,
    //     species: "Orange Tabby cat",
    //     MD: "vaccinated",
    //     behaviour: "needy",
    //     id: 1));
    //
    // DataBaseHelper.addPet(Pet(
    //     name: "Fio",
    //     age: 3,
    //     species: "cat",
    //     MD: "vaccinated",
    //     behaviour: "nice",
    //     id: 2));

    _refresh(); // Loading the diary when the app starts
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
                      DataBaseHelper.updatePet(newObject);
                      _refresh();
                      // _pets.removeAt(index);
                      //_pets.insert(index, newObject);
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
          Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const addPet()))
              .then((Object) {
            if (Object != null) {
              setState(() async {
                await DataBaseHelper.addPet(Object);
                _refresh();
                _pets.add(Object);
                // ignore: use_build_context_synchronously
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
                        DataBaseHelper.deletePet(_pets[index]);
                        _refresh();
                        // _pets.removeAt(index);
                        Navigator.pop(context);
                      });
                    },
                    child: const Text("Eliminate",
                        style: TextStyle(color: Colors.red))),
                TextButton(
                    onPressed: () {
                      _refresh();
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel",
                        style: TextStyle(color: Colors.blue)))
              ],
            ));
  }
}
