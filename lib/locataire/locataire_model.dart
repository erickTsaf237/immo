import 'dart:convert';

import 'package:sqflite/sqflite.dart';

import '../immo_manager.dart';
import '../main.dart';


class UtilisateurModel extends Immo {
  late String nom;
  late String prenom;
  late String image;
  late String sexe = 'Masculin';
  late String numero_telephone;


  UtilisateurModel( this.nom, this.prenom,
      this.image, this.numero_telephone, super.id,
      {this.sexe = 'Masculin'}){
    chemin = 'Locataire';
  }

  static const String creationLocalUtilisateur =
      'CREATE TABLE Locataire(id TEXT PRIMARY KEY,'
      ' nom TEXT, prenom TEXT,'
      ' image TEXT, sexe TEXT,'
      ' numero_telephone TEXT)';

  @override
  toJson() {
    // TODO: implement toJson
    return {
      if (id.isNotEmpty)
        'id': id,
      'nom': nom,
      'prenom': prenom,
      'numero_telephone': numero_telephone,
      'image': image,
      'sexe': sexe,
    };
  }

  static fromJson(data) {
    return UtilisateurModel(
        data['nom'],
        data['prenom'],
        data['image'],
        data['numero_telephone'],
        data['id'],
        sexe: data['sexe']);
  }

  static fromGoogle(data) {
    return UtilisateurModel(
        data['family_name'],
        data['given_name'],
        data['picture'],
        data['numero_telephone'] ?? '',
        data['id'],
        sexe: data['sexe'] ?? '');
  }


  @override
  getTableName() {
    // TODO: implement getTableName
    return 'Locataire';
  }
}
