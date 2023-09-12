import 'package:flutter/material.dart';
import 'package:immo/contrat/contrat_model.dart';
import 'package:immo/locataire/create_Locataire.dart';
import 'package:immo/locataire/locataire_model.dart';
import 'package:shimmer/shimmer.dart';

import 'Appartement_model.dart';
import 'create_appartement.dart';

class AppartementPage extends StatelessWidget {
  AppartementPage(this.appartement, this.function, {Key? key})
      : super(key: key);
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

  MyAppartementPage(this.appartement, this.function, {Key? key})
      : super(key: key);

  @override
  _MyAppartementPage createState() => _MyAppartementPage(appartement, function);
}

class _MyAppartementPage extends State<MyAppartementPage> {
  late AppartementModel appartement;
  late Function function;
  late LocataireModel locataire;
  late ContratModel contrat;

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
                          content: MyCreateAppartementPage(
                              appartement as AppartementModel, () {
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
                        title: Text('Appartement ${appartement.numero})'),
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
      body: Container(
        child:  FutureBuilder(
            future: LocataireModel.getCurrentLoctaire(appartement.id),
            builder: (context, AsyncSnapshot<List<Map<String, Object?>>> response) {
              // print(response);
              print(appartement);
              print(appartement.id);
              print(appartement.id);
              if (response.hasError) {
                return Text('Il y\'a eu une erreur 1');
              } else if (response.hasData) {
                if(response.data != null){
                  print(response.data);
                  // String? a = response.data?.data!;
                  // String b = a!;
                  dynamic r = response.data;
                  if(r.length==0){
                    return Center(
                      child: Container(
                        height: 140,
                        child: Column(

                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                              'Appartement ${appartement.numero}'),
                                          content: const Text(
                                              'L\'appartement va etre suprimé, aucun retour en arriere ne sera possible'),
                                          icon: const Icon(Icons.delete, size: 60),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                  MaterialStateProperty.all(Colors.green)),
                                              child: const Text('Annuler'),
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
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                  MaterialStateProperty.all(Colors.red)),
                                              child: const Text('Valider'),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,

                                  size: 60,
                                )),
                            const SizedBox(height: 20,),
                            const Text("ce batment ne contient pas d'appartement", style: TextStyle(fontSize: 15),)
                          ],
                        ),
                      ),
                    );
                  }
                  locataire = LocataireModel.fromJson(r[0]);
                  contrat = ContratModel.fromJson(r[0]);
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text('nom du locatire: ${locataire.nom}'),
                    Text('prenom du locatire: ${locataire.prenom}'),
                    Text('date de debut du contrat: ${contrat.dateDeDebut.substring(0,10)}'),
                    Text('Montant accordé: ${contrat.montant} FCFA' ),
                    Text('duree prevue pour le contrat: ${contrat.nombreDeMois} mois'),
                    Text('index electricité initial: ${contrat.index_electricite}'),
                    Text('ind eau initial: ${contrat.index_eau}'),
                    // for (int i = 0; i < taille; i++)
                    // // ListTile(title: Text('oooooooooooooooooo'),)
                    //   AppartementListItem(AppartementModel.fromJson(r[i]), batiment, function),
                  ]);
                }else{
                  return const Text('Il y\'a eu une erreur');
                }

              }
              return Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.white,
                child: ListView(
                  children: [
                    for (int i = 0; i < 10; i++)
                      ListTile(
                        title: Container(
                          width: 0,
                          color: Colors.grey,
                          height: 15,
                          child: const Text(''),
                        ),
                        leading: const CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        subtitle: Container(
                          width: 0,
                          color: Colors.grey,
                          height: 10,
                        ),
                      ),
                  ],
                ),
              );
            }),
      ),
      floatingActionButton: appartement.etat == 'libre'
          ? ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
              child: const Text('Nouveau locataire'),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          content: MyCreateLocatairePage(
                              LocataireModel('', '', '', '', ''),
                              ContratModel(
                                  DateTime.now().toString(),
                                  12,
                                  90000,
                                  DateTime.now().toString(),
                                  appartement.id,
                                  '',
                                  ''), () {
                        setState(() {
                          appartement.occuper();
                          print(appartement);
                          appartement.update().then((value) {
                          });
                        });
                        function();
                      }, appartement));
                    });
              })
          : ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent)),
              child: const Text('Arreter le contrat'),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                            return AlertDialog(
                              title: const Text('Fin de contrat'),
                              content: Container(
                                height: 200,
                                child: Column(
                                  children: [
                                    Text('Cette opperatin vise à mettre fin au contrat'
                                        ' de M/Mme ${locataire.nom } ${locataire.prenom}. '
                                        'Ce contrat a commencé le ${contrat.dateDeDebut} '),
                                    const Text('Dans quelle condition se termine t-il ?')
                                  ],
                                ),
                              ),
                              icon: const Icon(Icons.delete),
                              actions: [
                                /*ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Annuler'),
                                  style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(Colors.green)),
                                ),*/
                                ElevatedButton(
                                  onPressed: () {
                                    contrat.terminerContrat();
                                    appartement.liberer();
                                    appartement.update().then((value) {
                                      contrat.update().then((value) {
                                        if (value >= 1) {
                                          Navigator.pop(context);
                                          function();
                                          // Navigator.pop(context);
                                        }
                                      });
                                    });
                                    function();
                                    Navigator.pop(context);
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(Colors.green)),
                                  child: const Text('Fin de contrat'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    contrat.rompreContrat();
                                    appartement.liberer();
                                    appartement.update().then((value) {
                                      contrat.update().then((value) {
                                        if (value >= 1) {
                                          Navigator.pop(context);
                                          function();
                                          // Navigator.pop(context);
                                        }
                                      });
                                    });
                                    function();
                                    Navigator.pop(context);
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(Colors.red)),
                                  child: const Text('Rupture de contrat'),
                                ),
                              ],
                            );
                    });
              }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _MyAppartementPage(this.appartement, this.function);
}
