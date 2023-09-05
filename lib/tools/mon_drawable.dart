import 'package:immo/accueille/connexion.dart';
import 'package:immo/main.dart';
import 'package:immo/utilisateur/utilisateur_model.dart';
import 'package:flutter/material.dart';


class MonDrawer extends StatelessWidget {
  const MonDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
                '${utilisateur_courant!.prenom} ${utilisateur_courant!.nom}'),
            accountEmail: SelectableText(utilisateur_courant!.email),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.orange,
              child: Image.network(utilisateur_courant!.image,errorBuilder: (context, object, error){
                return Text(
                  '${utilisateur_courant!.prenom.substring(0, 1)
                      .toUpperCase()}${utilisateur_courant!.nom.substring(0, 1)
                      .toUpperCase()}',
                  style: const TextStyle(fontSize: 40.0),
                );
              }),
            ),
          ),
          ListTile(
            leading: Icon(Icons.house_outlined),
            title: Text("Batiment"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/batiment');
            },

          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Locataire"),
            onTap: () {
              Navigator.pop(context);
              // Navigator.pushReplacementNamed(context, '/section');
            },
          ),
          ListTile(
            leading: Icon(Icons.build),
            title: Text("Parametres"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.contacts),
            title: const Text("About Us"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/about');
            },
          ),
          /*ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Se deconnecter"),
            onTap: () {
              // Navigator.pop(context);
              var a = UtilisateurModel.deconnecterUtilisateur(utilisateur_courant!.email);
              print(a);
              utilisateur_courant = null;
              Navigator.pushReplacementNamed(context, '/login');
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyApp()));
              // Navigator.of(context).pushReplacementNamed('/choice');
            },
          ),*/
        ],
      ),
    );
  }
}
