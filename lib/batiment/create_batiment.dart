import 'package:flutter/material.dart';

import 'batiment_model.dart';

class CreateBatimentPage extends StatelessWidget {
  late BatimentModel batiment = BatimentModel('', '', '', '', '', '');
  late dynamic function;

  CreateBatimentPage(this.batiment, this.function, {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: MyCreateBatimentPage(batiment, function),
    );
  }
}

class MyCreateBatimentPage extends StatefulWidget {
  late BatimentModel batiment = BatimentModel('', '', '', '', '', '');

  late dynamic function;

  MyCreateBatimentPage(this.batiment, this.function, {super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyCreateBatimentPage(batiment, function);
  }
}

class _MyCreateBatimentPage extends State<MyCreateBatimentPage> {
  var nomController = TextEditingController();
  var quartierController = TextEditingController();
  var villeController = TextEditingController();
  var numeroController = TextEditingController();
  var descriptionController = TextEditingController();
  late BatimentModel batiment = BatimentModel('', '', '', '', '', '');


  late dynamic function;

  _MyCreateBatimentPage(this.batiment, this.function){
    if(batiment.id.isNotEmpty){
      nomController.text = batiment.nom;
      villeController.text = batiment.ville;
      descriptionController.text = batiment.description;
      quartierController.text = batiment.quartier;
      numeroController.text = batiment.numero;
    }
  }

  final _formkey = GlobalKey<FormState>();
  String message = '';
  String visibilityStatus = '';
  String userStatus = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        // color: Colors.cyan,
          constraints: BoxConstraints(maxHeight: double.infinity,),
          // padding: const EdgeInsets.symmetric(horizontal: 1),
          height: 500,
          width: 400,
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Center(
                  child: Title(
                      color: Colors.black,
                      child:  Text(
                        batiment.id.isEmpty?'Nouveau batiment':'Modifier le batiment',
                        style: TextStyle(fontSize: 25),
                      )),
                ),
                Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nomController,
                          // initialValue: depence.id!= null? "${depence.libele}":"",
                          decoration: const InputDecoration(
                              labelText: 'Nom'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer le nom de ce batiment';
                            }
                            return null;
                          },

                          onSaved: (value) => batiment.nom = value!,
                        ),
                        const SizedBox(
                          height: 16.0,
                          width: 100,
                        ),
                        TextFormField(
                          controller: numeroController,
                          // initialValue: depence.id!= null? "${depence.libele}":"",
                          decoration: const InputDecoration(
                              labelText: 'Code'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer le code de ce batiment';
                            } else if (userStatus.isNotEmpty) {
                              return message;
                            }
                            return null;
                          },

                          onSaved: (value) => batiment.numero = value!,
                        ),
                        const SizedBox(
                          height: 16.0,
                          width: 25,
                        ),
                        TextFormField(
                          controller: villeController,
                          // initialValue: depence.id!= null? "${depence.libele}":"",
                          decoration: const InputDecoration(
                              labelText: 'Ville'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer la ville ou ce situe ce batiment';
                            }
                            return null;
                          },

                          onSaved: (value) => batiment.ville = value!,
                        ),
                        const SizedBox(
                          height: 16.0,
                          width: 25,
                        ),
                        TextFormField(
                          controller: quartierController,
                          // initialValue: depence.id!= null? "${depence.libele}":"",
                          decoration: const InputDecoration(
                              labelText: 'Quatier'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer le quartier ou ce situe ce batiment';
                            }
                            return null;
                          },

                          onSaved: (value) => batiment.quartier= value!,
                        ),
                        const SizedBox(
                          height: 16.0,
                          width: 25,
                        ),
                        TextFormField(
                          controller: descriptionController,
                          // minLines: 4,
                          // initialValue: depence.id!= null? "${depence.libele}":"",
                          decoration: const InputDecoration(
                              labelText: 'description'),
                          validator: (value) {
                            /*if (value!.isEmpty) {
                              return 'Veuillez entrer le quartier ou ce situe ce batiment';
                            } else if (userStatus.isNotEmpty) {
                              return userStatus;
                            }*/
                            return null;
                          },

                          onSaved: (value) => batiment.description= value!,
                        ),
                        const SizedBox(
                          height: 16.0,
                          width: 25,
                        ),
                        Text(message,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 13)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Center(
                                child: ElevatedButton(
                                    onPressed: () {
                                      _submit(context);
                                    },
                                    child: const Text('Valider')),
                              ),
                            ),
                          ],
                        )
                      ],
                    ))
              ],
            ),
          ));
  }

  Future<int> _submit(BuildContext context) async {
    // jsonEncode(userBackend);
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      if(batiment.id.isNotEmpty){
        batiment.update().then((re) {
          print(re);
          function();
          Navigator.pop(context);
        }).catchError((error){
          message = 'Un batiment ayant ce code existe deja';
          userStatus = 'Un batiment ayant ce code existe deja';
          _formkey.currentState!.validate();
          userStatus= '';
        });
      }

      batiment.save().then((re) {
        print(re);
        function();
        Navigator.pop(context);
      }).catchError((error){
        message = 'Un batiment ayant ce code existe deja';
        userStatus = 'Un batiment ayant ce code existe deja';
        _formkey.currentState!.validate();
        userStatus= '';
      });
    }
    return 0;
  }
}
