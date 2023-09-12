// Generated code for this listContainer Widget...
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:immo/appartement/Appartement_model.dart';
import 'package:immo/contrat/contrat_model.dart';
import 'package:immo/locataire/locataire_model.dart';
import 'package:immo/location/create_facture.dart';
import 'package:immo/location/location_model.dart';
import 'package:immo/location/location_page.dart';
import 'package:immo/main.dart';
import 'package:shimmer/shimmer.dart';

getCurentLictereItem(BuildContext context, LocataireModel locataire,
    AppartementModel appartement, ContratModel contrat) {
  appartement.contrat = contrat;
  appartement.locataire = locataire;
  return InkWell(
    onTap: (){
      appartement.etat_location=='en attente'?Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationPage(appartement, homeFunction))):
      showDialog(context: context, builder:(context){
        return AlertDialog(
            content: MyCreateLocationPage(
                LocationModel(appartement.id, locataire.id, '', contrat.id, '','', appartement: appartement), () {
                appartement.occuper();
                print(appartement);
                appartement.update().then((value) {
                });
            }));
      });
    },
    child: Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
      child: Container(
        // width: double.infinity,
        // height: 200,
        constraints: BoxConstraints(
          maxWidth: 570,
        ),
        decoration: BoxDecoration(
          // color: Colors.grey,
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
              colors: [Colors.orange, Colors.red],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter),
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Mne/M : ',
                                style: TextStyle(),
                              ),
                              TextSpan(
                                text: '${locataire.nom} ${locataire.prenom}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                          child: Text(
                            'Juillet',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                          child: Container(
                            height: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                width: 2,
                              ),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(7, 0, 7, 0),
                                child: Text(
                                  'Septembre',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                        child: Text(
                          '${contrat.montant} FCFA',
                          textAlign: TextAlign.end,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                        child: Container(
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              width: 2,
                            ),
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                              child: Text(
                                '${appartement.etat_location}',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Center(
                child: Text(
                  '${appartement.numero}',
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

getCurentLocataireListItems(BuildContext context, Function function) {
  return FutureBuilder(
      future: AppartementModel.getAllCurrentLoctaire(),
      builder: (context, AsyncSnapshot<List<Map<String, Object?>>> response) {
        // print(response);
        if (response.hasError) {
          return Text('Il y\'a eu une erreur 1');
        } else if (response.hasData) {
          if (response.data != null) {
            var candidatList = [];
            print(response.data);
            // String? a = response.data?.data!;
            // String b = a!;
            dynamic r = response.data;
            int taille = r.length;
            return ListView(children: [
              for (int i = 0; i < taille; i++)
                // ListTile(title: Text('oooooooooooooooooo'),)
                getCurentLictereItem(
                    context,
                    LocataireModel.fromJson(r[i]),
                    AppartementModel.fromJson(r[i]),
                    ContratModel.fromJson(r[i])),
            ]);
          } else {
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
                    child: Text(''),
                  ),
                  leading: CircleAvatar(
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
      });
}

getCurentLocataireListItems2(BuildContext context, Function function) {
  return StreamBuilder(
      stream: AppartementModel.getAllCurrentLoctaire2(etatDatabase),
      builder: (context, AsyncSnapshot<List<Map<String, Object?>>> response) {
        // print(response);
        if (response.hasError) {
          return Text('Il y\'a eu une erreur 1');
        } else if (response.hasData) {
          if (response.data != null) {
            var candidatList = [];
            print(response.data);
            // String? a = response.data?.data!;
            // String b = a!;
            dynamic r = response.data;
            int taille = r.length;
            return ListView(children: [
              for (int i = 0; i < taille; i++)
                // ListTile(title: Text('oooooooooooooooooo'),)
                getCurentLictereItem(
                    context,
                    LocataireModel.fromJson(r[i]),
                    AppartementModel.fromJson(r[i]),
                    ContratModel.fromJson(r[i])),
            ]);
          } else {
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
                    child: Text(''),
                  ),
                  leading: CircleAvatar(
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
      });
}
