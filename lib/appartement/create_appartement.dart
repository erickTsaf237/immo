import 'package:flutter/material.dart';

import 'Appartement_model.dart';


class CreateAppartementPage extends StatelessWidget {
  late AppartementModel appartement = AppartementModel('', '', '', '', '');
  late dynamic function;

  CreateAppartementPage(this.appartement, this.function, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: MyCreateAppartementPage(appartement, function),
    );
  }
}

class MyCreateAppartementPage extends StatefulWidget {
  late AppartementModel appartement = AppartementModel('', '', '', 'libre', '');
  late dynamic function;

  MyCreateAppartementPage(this.appartement, this.function, {super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyCreateAppartementPage(appartement, function);
  }
}

class _MyCreateAppartementPage extends State<MyCreateAppartementPage> {
  var nomController = TextEditingController();
  var quartierController = TextEditingController();
  var villeController = TextEditingController();
  var numeroController = TextEditingController();
  var descriptionController = TextEditingController();
  late AppartementModel appartement = AppartementModel('', '', '', 'libre', '');


  late dynamic function;

  _MyCreateAppartementPage(this.appartement, this.function){
    if(appartement.id.isNotEmpty){
      descriptionController.text = appartement.description;
      numeroController.text = appartement.numero;
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
                        appartement.id.isEmpty?'Nouvel Appartement':'Modifier l\'appartement',
                        style: TextStyle(fontSize: 25),
                      )),
                ),
                Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: numeroController,
                          // initialValue: depence.id!= null? "${depence.libele}":"",
                          decoration: const InputDecoration(
                              labelText: 'Numero'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer le numero de ce Appartement';
                            } else if (userStatus.isNotEmpty) {
                              return message;
                            }
                            return null;
                          },

                          onSaved: (value) => appartement.numero = value!,
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
                              return 'Veuillez entrer le quartier ou ce situe ce Appartement';
                            } else if (userStatus.isNotEmpty) {
                              return userStatus;
                            }*/
                            return null;
                          },

                          onSaved: (value) => appartement.description= value!,
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
      if(appartement.id.isNotEmpty){
        appartement.update().then((re) {
          print(re);
          function();
          Navigator.pop(context);
        }).catchError((error){
          message = 'Un Appartement ayant ce code existe deja';
          userStatus = 'Un Appartement ayant ce code existe deja';
          _formkey.currentState!.validate();
          userStatus= '';
        });
      }
      appartement.save().then((re) {
        print(re);
        function();
        Navigator.pop(context);
      }).catchError((error){
        message = 'Un Appartement ayant ce code existe deja';
        userStatus = 'Un Appartement ayant ce code existe deja';
        _formkey.currentState!.validate();
        userStatus= '';
      });
    }
    return 0;
  }
}
