import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:immo/appartement/Appartement_model.dart';
import 'package:immo/batiment/batiment_model.dart';
import 'package:immo/contrat/contrat_model.dart';
import 'package:immo/main.dart';

import 'locataire_model.dart';

class CreateLocatairePage extends StatelessWidget {
  late LocataireModel locataire;
  late ContratModel contrat;
  late dynamic function;

  CreateLocatairePage(this.locataire, this.contrat, this.function, {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      // body: MyCreateLocatairePage(locataire,contrat, function),
    );
  }
}

class MyCreateLocatairePage extends StatefulWidget {
  late LocataireModel locataire;
  late ContratModel contrat;
  late AppartementModel appartement;

  late dynamic function;

  MyCreateLocatairePage(this.locataire,this.contrat, this.function, this.appartement, {super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyCreateLocatairePage(locataire,contrat, function, appartement);
  }
}

class _MyCreateLocatairePage extends State<MyCreateLocatairePage> {
  var nomController = TextEditingController();
  var prenomController = TextEditingController();
  var numeroController = TextEditingController();
  var sexeController = TextEditingController();
  var eauController = TextEditingController();
  var electriciteController = TextEditingController();
  var createdAtController = TextEditingController();
  var nombreDeMoisController = TextEditingController();
  var montantController = TextEditingController();
  var dateDeDebutController = TextEditingController();

  late LocataireModel locataire;
  late ContratModel contrat;
  late AppartementModel appartement;


  late dynamic function;

  _MyCreateLocatairePage(this.locataire,this.contrat, this.function, this.appartement){
    if(locataire.id.isNotEmpty){
      nomController.text = locataire.nom;
      prenomController.text = locataire.prenom;
      sexeController.text = locataire.sexe;
      numeroController.text = locataire.numero_telephone;

    }
    createdAtController.text = contrat.createdAt;
    nombreDeMoisController.text = contrat.nombreDeMois.toString();
    montantController.text = contrat.montant.toString();
    dateDeDebutController.text = contrat.dateDeDebut;
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
          // height: 500,
          width: 400,
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Center(
                  child: Title(
                      color: Colors.black,
                      child:  Text(
                        locataire.id.isEmpty?'Nouveau Locataire':'Modifier le Locataire',
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
                              return 'Veuillez entrer le nom de ce Locataire';
                            }
                            return null;
                          },

                          onSaved: (value) => locataire.nom = value!,
                        ),
                        const SizedBox(
                          height: 16.0,
                          width: 100,
                        ),
                        TextFormField(
                          controller: prenomController,
                          // initialValue: depence.id!= null? "${depence.libele}":"",
                          decoration: const InputDecoration(
                              labelText: 'Prenom'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer le prenom de ce Locataire';
                            } else if (userStatus.isNotEmpty) {
                              return message;
                            }
                            return null;
                          },

                          onSaved: (value) => locataire.prenom = value!,
                        ),
                        const SizedBox(
                          height: 16.0,
                          width: 25,
                        ),
                        TextFormField(
                          controller: numeroController,
                          // initialValue: depence.id!= null? "${depence.libele}":"",
                          decoration: const InputDecoration(
                              labelText: 'Numero'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer le numero du Locataire';
                            }
                            return null;
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(12,
                                maxLengthEnforcement:
                                MaxLengthEnforcement
                                    .truncateAfterCompositionEnds),
                            FilteringTextInputFormatter.digitsOnly
                            // ne permet que la saisie de chiffres
                          ],
                          onSaved: (value) => locataire.numero_telephone = value!,
                        ),
                        const SizedBox(
                          height: 16.0,
                          width: 25,
                        ),
                        TextFormField(
                          controller: sexeController,
                          // initialValue: depence.id!= null? "${depence.libele}":"",
                          decoration: const InputDecoration(
                              labelText: 'Sexe'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer le sexe du Locataire';
                            }
                            return null;
                          },

                          onSaved: (value) => locataire.sexe= value!,
                        ),
                        const SizedBox(
                          height: 16.0,
                          width: 25,
                        ),
                        TextFormField(
                          controller: montantController,
                          // initialValue: depence.id!= null? "${depence.libele}":"",
                          decoration: const InputDecoration(
                              labelText: 'Sexe'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer le sexe du Locataire';
                            }
                            return null;
                          },

                          onSaved: (value) => contrat.montant= int.parse(value!),
                        ),
                        const SizedBox(
                          height: 16.0,
                          width: 25,
                        ),
                        TextFormField(
                          controller: dateDeDebutController,
                          // initialValue: depence.id!= null? "${depence.libele}":"",
                          decoration: const InputDecoration(
                              labelText: 'date de debut'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer la date de debut du contrat';
                            }
                            return null;
                          },

                          onSaved: (value) => contrat.dateDeDebut= value!,
                        ),
                        const SizedBox(
                          height: 16.0,
                          width: 25,
                        ),
                        TextFormField(
                          controller: nombreDeMoisController,
                          // initialValue: depence.id!= null? "${depence.libele}":"",
                          decoration: const InputDecoration(
                              labelText: 'Nombre de mois'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer la durée du contrat en mois';
                            }
                            return null;
                          },

                          onSaved: (value) => contrat.nombreDeMois= int.parse(value!),
                        ),
                        const SizedBox(
                          height: 16.0,
                          width: 25,
                        ),

                        TextFormField(
                          controller: eauController,
                          // initialValue: depence.id!= null? "${depence.libele}":"",
                          decoration: const InputDecoration(
                              labelText: 'Index eau'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer l\'index d\'eau';
                            }
                            return null;
                          },

                          onSaved: (value) => contrat.index_eau= int.parse(value!),
                        ),
                        const SizedBox(
                          height: 16.0,
                          width: 15,
                        ),
                        TextFormField(
                          controller: electriciteController,
                          // initialValue: depence.id!= null? "${depence.libele}":"",
                          decoration: const InputDecoration(
                              labelText: 'Index Electricite',
                          fillColor: Colors.grey),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer l\'index d\'ectricite';
                            }
                            return null;
                          },

                          onSaved: (value) => contrat.index_electricite = int.parse(value!),
                        ),
                        const SizedBox(
                          height: 16.0,
                          width: 25,
                        ),
                        /*TextFormField(
                          controller: descriptionController,
                          // minLines: 4,
                          // initialValue: depence.id!= null? "${depence.libele}":"",
                          decoration: const InputDecoration(
                              labelText: 'description'),
                          validator: (value) {
                            /*if (value!.isEmpty) {
                              return 'Veuillez entrer le quartier ou ce situe ce Locataire';
                            } else if (userStatus.isNotEmpty) {
                              return userStatus;
                            }*/
                            return null;
                          },

                          onSaved: (value) => locataire.description= value!,
                        ),*/
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
      if(locataire.id.isNotEmpty){
        locataire.update().then((re) {
          print(re);
          function();
          homeFunction();
          Navigator.pop(context);
        }).catchError((error){
          print(error);
          message = 'Un Locataire ayant ce code existe deja';
          userStatus = 'Un Locataire ayant ce code existe deja';
          _formkey.currentState!.validate();
          userStatus= '';
        });
      }

      locataire.save().then((re) {
        print(re);
        contrat.id_locataire = re.toString();
        return contrat.save().then((value) {
          print(value);
          homeFunction();
          appartement.etat = 'occupé';
          appartement.setMontant(contrat.montant);
          appartement.setIndex(contrat.index_eau, contrat.index_electricite);
          function();
          Navigator.pop(context);
        });
      }).catchError((error){
        print(error);
        message = 'Un Locataire ayant ce code existe deja';
        userStatus = 'Un Locataire ayant ce code existe deja';
        _formkey.currentState!.validate();
        userStatus= '';
      });
    }
    return 0;
  }
}
