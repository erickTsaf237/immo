import 'dart:convert';

import 'package:sqflite/sqflite.dart';

import '../immo_manager.dart';
import '../main.dart';


class UtilisateurModel extends Immo {
  late String email;
  late String nom;
  late String prenom;
  late String mot_de_passe;
  late String image;
  late String sexe = 'Masculin';
  late String date_naissance;
  late String numero_telephone;


  UtilisateurModel(this.email, this.nom, this.mot_de_passe, this.prenom,
      this.image, this.date_naissance, this.numero_telephone, super.id,
      {this.sexe = 'Masculin'}){
   chemin = 'utilisateur';
  }

  static const String creationLocalUtilisateur =
      'CREATE TABLE Utilisateur(id TEXT PRIMARY KEY,'
      ' email TEXT UNIQUE, mot_de_passe TEXT,'
      ' nom TEXT, prenom TEXT,'
      ' image TEXT, sexe TEXT,'
      ' date_naissance TEXT,'
      ' numero_telephone TEXT,'
      ' connected INTEGER)';

  @override
  toJson() {
    // TODO: implement toJson
    return {
      if (id != null )
        if (id!.isNotEmpty)
          'id': id,
      'email': email,
      'nom': nom,
      'prenom': prenom,
      'numero_telephone': numero_telephone,
      'mot_de_passe': mot_de_passe,
      'image': image,
      'sexe': sexe,
      'date_naissance': date_naissance
    };
  }

  static fromJson(data) {
    return UtilisateurModel(
        data['email'],
        data['nom'],
        data['mot_de_passe'],
        data['prenom'],
        data['image'],
        data['date_naissance'] ?? '',
        data['numero_telephone'],
        data['id'],
        sexe: data['sexe']);
  }

  static fromGoogle(data) {
    return UtilisateurModel(
        data['email'],
        data['family_name'],
        data['mot_de_passe'] ?? '',
        data['given_name'],
        data['picture'],
        data['date_naissance'] ?? '',
        data['numero_telephone'] ?? '',
        data['id'],
        sexe: data['sexe'] ?? '');
  }

  static saveUtilisateur(String email, String password, token) async {
    final db = await database;
    return await db.insert(
      'Utilisateur',
      {'email': email, 'mot_de_passe': password, 'connected': 1, 'token':token},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  saveUtilisateur2(){
    save();
  }

  static updateUtilisateur() async {
    final db = await database;
    return await db.update('Utilisateur', {'connected': 0},
        conflictAlgorithm: ConflictAlgorithm.replace,
        where: 'id > ?',
        whereArgs: [0]);
  }

  static Future<int> deconnecterUtilisateur(email) async {
    final db = await database;
    return await db.update('Utilisateur', {'connected': 0},
        conflictAlgorithm: ConflictAlgorithm.replace,
        where: 'email=?',
        whereArgs: [email]);
  }

  static deleteUtilisateur() async {
    final db = await database;
    return await db
        .delete('Utilisateur', where: 'connected != ?', whereArgs: [0]);
  }

  static Future<dynamic> seConnecter(String email, String mot_de_passe) async {
    return null;
  }

  static Future<dynamic> confirmerConnexion(
      String email, String mot_de_passe, String token) async {
    return null;
  }

  static Future<Map<String, Object?>?> getCurrentUtilisateur() async {
    final db = await database;
    final maps = await db.query('Utilisateur',limit: 1);
        // where: 'connected=?', whereArgs: [1], limit: 1);
    if (maps.length == 0) {
      return null;
    }
    return maps[0];
    // seConnecter(maps[0]['email'] as String, maps[0]['mot_de_passe'] as String);
    // print(maps[0]);
  }

  static Future<UtilisateurModel?> ConnectCurrentUtilisateur() async {
    Map<String, Object?>? a = await getCurrentUtilisateur();
    if (a != null) {
      return UtilisateurModel.fromJson(a);
      print(a);
      var re = await confirmerConnexion(a['email'] as String, a['mot_de_passe'] as String, a['token'] as String);
      if (re != null) {
        if (re.codeStatus == 200) {
          Immo.accessToken = re.data['token']!;
          // Arbre.accessToken = re.message!;
          print('dddddddddddddddddddddddddddddddddddddddddd1d');
          print(Immo.accessToken);
          print('dddddddddddddddddddddddddddddddddddddddddd1d');
          return UtilisateurModel.fromJson(re.data['data']);
        }
      }
    }
    return null;
  }

  @override
  getTableName() {
    // TODO: implement getTableName
    return 'Utilisateur';
  }
}
