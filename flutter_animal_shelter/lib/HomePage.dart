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
  List<Client> clients = [
    Client("Filip", "Dubau", "79"),
    Client("Iulian", "Deac", "78"),
    Client("Diana", "Dumitru", "77"),
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
                removeObject(context, clients[index]);
              },
              title: Text(clients[index].name + " " + clients[index].Surname),
              subtitle: Text(clients[index].phone),
              leading: CircleAvatar(
                child: Text(clients[index].name.substring(0, 1)),
              ),
              trailing: Icon(
                Icons.call,
                color: Colors.red,
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

  removeObject(BuildContext context, Client client) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("are you sure you want to delete this item?"),
              content:
                  Text("The element " + client.name + " will be eliminated"),
              actions: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        this.clients.remove(client);
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

class Client {
  var name;
  var Surname;
  var phone;
  Client(this.name, this.Surname, this.phone);
}
