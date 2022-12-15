import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

messageRrsponse(BuildContext context, String name) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            //title: Text("opa"),
            content: Text("alo $name"),
          ));
}
