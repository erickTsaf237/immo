import 'package:flutter/material.dart';
import 'package:immo/appartement/Appartement_model.dart';
import 'package:immo/appartement/appartement_item.dart';
import 'package:immo/appartement/create_appartement.dart';

import 'batiment_model.dart';
import 'create_batiment.dart';

class BatimentPage extends StatelessWidget {
  BatimentPage(this.batiment, this.function, {Key? key}) : super(key: key);
  late BatimentModel batiment;
  late Function function;

  @override
  Widget build(BuildContext context) {
    return MyBatimentPage(batiment, function);
  }
}

class MyBatimentPage extends StatefulWidget {
  late BatimentModel batiment;
  late Function function;

  MyBatimentPage(this.batiment, this.function, {Key? key}) : super(key: key);

  @override
  _MyBatimentPage createState() => _MyBatimentPage(batiment, function);
}

class _MyBatimentPage extends State<MyBatimentPage> {
  late BatimentModel batiment;
  late Function function;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Batiment ${batiment.numero} (${batiment.nom})'),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          content: MyCreateBatimentPage(batiment, () {
                        function();
                        setState(() {});
                      }));
                    });
              },
              icon: Icon(Icons.pending_actions)),
        ],
      ),
      body: getAppartementListItem(context, () {
        setState(() {});
        function();
      }, batiment),
      floatingActionButton: ElevatedButton(
          child: const Text('Ajouter un appartement'),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                      content: MyCreateAppartementPage(
                          AppartementModel(batiment.id, '', '', '', ''), () {
                    setState(() {});
                    function();
                  }));
                });
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _MyBatimentPage(this.batiment, this.function);
}
