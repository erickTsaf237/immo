import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:immo/appartement/appartement_item.dart';
import 'package:shimmer/shimmer.dart';

import '../tools/tools.dart';
import 'batiment_model.dart';
import 'batiment_page.dart';

class BatimentListItem extends StatefulWidget {
  late BatimentModel famille;

  BatimentListItem(this.famille);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class _BatimentListItem extends State<BatimentListItem> {
  late BatimentModel famille;

  _BatimentListItem(this.famille);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      title: Text(famille.nom),
      leading: CircleAvatar(
          child: Text(
            '${famille.nom.characters.first}',
            style: TextStyle(height: 20),
          ),
          backgroundColor: Colors.red),
      subtitle: Text('Located at ${famille.ville}(${famille.quartier})'),
      onTap: () {},
    );
  }
}

displayBatimentItem(
    BuildContext context, BatimentModel famille, Function function) {
  // TODO: implement build
  return ListTile(
    title: Text(
      '${famille.nom.toUpperCase()}',
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    leading: CircleAvatar(
        backgroundColor: colorFromAsciiCode(famille.nom),
        child: Text(
          'B.${famille.nom.characters.first.toUpperCase()}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )),
    trailing: Text('${famille.numero.toUpperCase()}',
        style: TextStyle(fontSize: 35)),
    subtitle: Text('situé à ${famille.ville}(${famille.quartier})'),
    // trailing: Icon(famille.visibilite=='publique'?Icons.visibility:Icons.visibility_off, color: famille.visibilite=='publique'?Colors.blue:Colors.red,),
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BatimentPage(famille, function)));
    },
  );
}

getBatimentListItem(BuildContext context, Function function) {
  return FutureBuilder(
      future: BatimentModel.getAll(),
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
                displayBatimentItem(
                    context, BatimentModel.fromJson(r[i]), function),
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
