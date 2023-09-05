import 'package:flutter/material.dart';
import 'package:immo/appartement/Appartement_model.dart';

import 'create_appartement.dart';



class AppartementPage extends StatelessWidget {
  AppartementPage(this.appartement, this.function, {Key? key}) : super(key: key);
  late AppartementModel appartement;
  late Function function;

  @override
  Widget build(BuildContext context) {
    return MyAppartementPage(appartement, function);
  }
}

class MyAppartementPage extends StatefulWidget {
  late AppartementModel appartement;
  late Function function;

  MyAppartementPage(this.appartement, this.function, {Key? key}) : super(key: key);

  @override
  _MyAppartementPage createState() => _MyAppartementPage(appartement, function);
}

class _MyAppartementPage extends State<MyAppartementPage> {
  late AppartementModel appartement;
  late Function function;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appartement ${appartement.numero}'),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          content: MyCreateAppartementPage(appartement as AppartementModel, () {
                            function();
                            setState(() {});
                          }));
                    });
              },
              icon: Icon(Icons.pending_actions)),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                            'Appartement ${appartement.numero})'),
                        content: Container(
                          child: const Text(
                              'Le Appartement va etre suprimé, aucun retour en arriere ne sera possible'),
                        ),
                        icon: Icon(Icons.delete),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Annuler'),
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(Colors.green)),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              appartement.delete().then((value) {
                                if (value >= 1) {
                                  Navigator.pop(context);
                                  function();
                                  // Navigator.pop(context);
                                }
                              });
                              function();
                              Navigator.pop(context);
                            },
                            child: Text('Valider'),
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                          ),
                        ],
                      );
                    });
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              )),
        ],
      ),
      body: Container(),
      floatingActionButton:appartement.etat == 'libre'? ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
          child: const Text('Nouveau locataire'),
          onPressed: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context)=> MyPersonneCreationPage(PersonneModel('','','','','',''))));
          }):ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.redAccent)),
          child: const Text('Rompre le contrat'),
          onPressed: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context)=> MyPersonneCreationPage(PersonneModel('','','','','',''))));
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _MyAppartementPage(this.appartement, this.function);
}
