
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../batiment/batiment_model.dart';
import '../tools/tools.dart';

import 'Appartement_model.dart';
import 'appartement_page.dart';

class AppartementListItem extends StatefulWidget {
  late AppartementModel appartement;
  late BatimentModel batiment;
  late Function function;
  AppartementListItem(this.appartement, this.batiment, this.function);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AppartementListItem(appartement, batiment, function);
  }
}

class _AppartementListItem extends State<AppartementListItem> {
  late AppartementModel appartement;
  late BatimentModel batiment;
  late Function function;
  _AppartementListItem(this.appartement, this.batiment, this.function);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      title: Text('Appartement ${appartement.numero}${batiment.numero.toUpperCase()}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      leading: CircleAvatar(
          backgroundColor: colorFromAsciiCode(appartement.numero),
          child: Text(
            'A.${appartement.numero.characters.first.toUpperCase()}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
      trailing: Text(appartement.etat.toLowerCase(), style: TextStyle(fontSize: 15, color: appartement.etat=='libre'?Colors.red:Colors.green)),
      subtitle: Text(appartement.description.length>25?'${appartement.description.substring(0, 19)}...':appartement.description, ),

      // trailing: Icon(famille.visibilite=='publique'?Icons.visibility:Icons.visibility_off, color: famille.visibilite=='publique'?Colors.blue:Colors.red,),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AppartementPage(appartement, function) ));
      },
    );
  }
}

/*displayAppartementItem(BuildContext context, AppartementModel appartement, Function function, BatimentModel batiment) {
  // TODO: implement build
  return ListTile(
    title: Text('Appartement ${appartement.numero}${batiment.numero.toUpperCase()}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
    leading: CircleAvatar(
        backgroundColor: colorFromAsciiCode(appartement.numero),
        child: Text(
          'A.${appartement.numero.characters.first.toUpperCase()}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )),
    trailing: Text(appartement.etat.toLowerCase(), style: TextStyle(fontSize: 15, color: appartement.etat=='libre'?Colors.red:Colors.green)),
    subtitle: Text(appartement.description.length>25?'${appartement.description.substring(0, 19)}...':appartement.description, ),

    // trailing: Icon(famille.visibilite=='publique'?Icons.visibility:Icons.visibility_off, color: famille.visibilite=='publique'?Colors.blue:Colors.red,),
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>AppartementPage(appartement, function) ));
    },
  );
}*/



getAppartementListItem(BuildContext context,Function function, BatimentModel  batiment) {
  return FutureBuilder(
      future: AppartementModel.getAllById_Batiment(batiment.id),
      builder: (context, AsyncSnapshot<List<Map<String, Object?>>> response) {
        // print(response);
        if (response.hasError) {
          return Text('Il y\'a eu une erreur 1');
        } else if (response.hasData) {
          if(response.data != null){
            var candidatList = [];
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
                                        'Batiment ${batiment.numero}(${batiment.nom})'),
                                    content: Container(
                                      child: const Text(
                                          'Le batiment va etre suprimé, aucun retour en arriere ne sera possible'),
                                    ),
                                    icon: Icon(Icons.delete, size: 60),
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
                                          batiment.delete().then((value) {
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

                            size: 60,
                          )),
                      SizedBox(height: 20,),
                      const Text("ce batment ne contient pas d'appartement", style: TextStyle(fontSize: 15),)
                    ],
                  ),
                ),
              );
            }
            int taille = r.length;
            return Column(children: [
              for (int i = 0; i < taille; i++)
                // ListTile(title: Text('oooooooooooooooooo'),)
                AppartementListItem(AppartementModel.fromJson(r[i]), batiment, function),
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
