// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_animal_shelter/Update.dart';
import 'package:flutter_animal_shelter/add.dart';
import 'package:flutter_animal_shelter/messageResponse.dart';

class MyHomePage extends StatefulWidget {
  final String _title;
  MyHomePage(this._title);

  @override
  State<StatefulWidget> createState() => _MyhomePage();
}

class Test extends State<MyHomePage> {
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(widget._title)));
  }
}

class _MyhomePage extends State<MyHomePage> {
  List<Pet> clients = [
    Pet("Rio", "2", "Orange Tabby cat", "vaccinated", "needy"),
    Pet("Fio", "3", "cat", "unknow", "nice"),
    Pet("Max", "1", "dog", "vaccinated", "playfull"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
      ),
      body: ListView.builder(
          itemCount: clients.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Update(clients[index])))
                    .then((newObject) {
                  if (newObject != null) {
                    setState(() {
                      clients.removeAt(index);
                      clients.insert(index, newObject);
                      MessageRrsponse(context, newObject.name + " was updated");
                    });
                  }
                });
              },
              onLongPress: () {
                removeObject(context, index, clients[index].name);
              },
              title: Text(clients[index].name),
              subtitle:
                  Text(clients[index].species + "\n" + clients[index].age),
              leading: CircleAvatar(
                child: Text(clients[index].name.substring(0, 1)),
              ),
              trailing: Icon(
                Icons.info,
                color: Colors.blue,
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => addPet()))
              .then((Object) {
            if (Object != null) {
              setState(() {
                clients.add(Object);
                MessageRrsponse(context, Object.name + " was added");
              });
            }
          });
        },
        tooltip: "add",
        child: Icon(Icons.add),
      ),
    );
  }

  removeObject(BuildContext context, var index, var name) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("are you sure you want to delete this pet?"),
              content: Text("The pet " + name + " will be eliminated"),
              actions: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        this.clients.removeAt(index);
                        Navigator.pop(context);
                      });
                    },
                    child:
                        Text("Eliminate", style: TextStyle(color: Colors.red))),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel", style: TextStyle(color: Colors.blue)))
              ],
            ));
  }
}

class Pet {
  var name;
  var age;
  var species;
  var behaviour;
  var medical_records;

  Pet(String name, String age, String species, String beahaviour, String MD) {
    this.name = name;
    this.age = age;
    this.species = species;
    this.behaviour = beahaviour;
    this.medical_records = MD;
  }
}
