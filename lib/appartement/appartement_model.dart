


import 'dart:async';

import 'package:immo/contrat/contrat_model.dart';
import 'package:immo/immo_manager.dart';
import 'package:immo/locataire/locataire_model.dart';
import 'package:sqflite/sqflite.dart';

import '../main.dart';

class AppartementModel extends Immo{

  late String id_batiment;
  late String id_location;
  late String numero;
  late String description;
  late String etat='libre';
  late String etat_location='libre';
  late int montant;
  late int index_eau;
  late int index_electricite;


  late ContratModel? contrat;
  late LocataireModel? locataire;


  ContratModel? getContrat(){
    return contrat;
  }

  setContrat(ContratModel value) {
    contrat = value;
  }
  LocataireModel? getLocataire(){
    return locataire;
  }

  setLocataire(LocataireModel value) {
    locataire = value;
  }

  setIndex(int index_eau, int index_electricite){
    this.index_eau = index_eau;
    this.index_electricite = index_electricite;
  }


  setMontant(int montant){
    this.montant = montant>=0?montant:0;
  }



  AppartementModel(this.id_batiment, this.numero, this.description, this.etat, super.id,
      { this.index_electricite = 0, this.index_eau=0, this.montant = 0, this.etat_location='payé', this.id_location='' });

  static const String creationLocalAppartement =
      'CREATE TABLE Appartement(id Integer PRIMARY KEY,'
      ' id_batiment INTEGER NOT NULL,'
      ' id_location TEXT,'
      ' montant INTEGER,'
      ' index_eau INTEGER, index_electricite INTEGER,'
      ' numero TEXT NOT NULL,'
      ' description TEXT,'
      ' etat TEXT default \'libre\','
      ' etat_location TEXT default \'payé\','
      'UNIQUE(id_batiment, numero), '
      'FOREIGN KEY (id_batiment) REFERENCES Batiment(id)'
      'ON UPDATE CASCADE ON DELETE RESTRICT)';


  @override
  String getTableName() {
    // TODO: implement getTableName
    return 'Appartement';
  }

  @override
  toJson() {
    // TODO: implement toJson
    return {
      if(id.isNotEmpty)
        'id':id,
      if(id_location.isNotEmpty)
        'id_location':id_location,
      'numero':numero,
      'id_batiment':id_batiment,
      'description':description,
      'index_eau':index_eau,
      'montant':montant,
      'index_electricite':index_electricite,
      'etat':etat,
      'etat_location':etat_location,
    };
  }

  static AppartementModel fromJson(r) {
    return AppartementModel(r['id_batiment'].toString(), r['numero'],
        r['description'], r['etat']??'libre', (r['id_appartement']??r['id']).toString(),
        index_eau: r['index_eau']??1, index_electricite: r['index_electricite']??1
        ,montant: r['montant']??90000,etat_location: r['etat_location']??'payé',id_location: r['id_location']??'');
  }

  static Future<List<Map<String, Object?>>>? getAll(){
    return Immo.getAll('Appartement');
  }
  static Future<List<Map<String, Object?>>>? getOneById(String id){
    return Immo.getOneById('Appartement', id);
  }
  static Future<List<Map<String, Object?>>>? getAllById_Batiment(String id_batiment){
    return Immo.getAllByFK('Appartement', {'key':'id_batiment', 'value':id_batiment});
  }

  void occuper(){
    etat = 'occupé';
  }


  @override
  String toString() {
    return 'AppartementModel{id_batiment: $id_batiment, numero: $numero, description: $description, etat: $etat, id: $id}';
  }

  void liberer(){
    etat = 'libre';
  }

  static Future<List<Map<String, Object?>>> getAllCurrentLoctaire() async {
    final db = await database;
    // final maps = await db.query('Utilisateur',limit: 1,);
    final maps = await db.rawQuery("select * from Contrat c inner join Locataire l, Appartement a on l.id=c.id_locataire and "
        "c.id_appartement = a.id "
        " where etat_contrat = 'en cours' and a.etat='occupé'"
        // "ORDER BY createdAt DESC LIMIT 1;"
        ,[]);
    print("select * from Contrat c inner join Locataire l, Appartement a on l.id=c.id_locataire and "
        "c.id_appartement = a.id "
        " where etat_contrat = 'en cours' and a.etat='occupé'");
    print(maps);
    return maps;
  }

  static Stream<List<Map<String, Object?>>> getAllCurrentLoctaire2(Database etatDatabase) {
    final streamController = StreamController<List<Map<String, Object?>>>();
    final db = etatDatabase;
    // final maps = await db.query('Utilisateur',limit: 1,);
    final maps = db.rawQuery("select * from Contrat c inner join Locataire l, Appartement a on l.id=c.id_locataire and "
        "c.id_appartement = a.id "
        " where etat_contrat = 'en cours' and a.etat='occupé'"
        // "ORDER BY createdAt DESC LIMIT 1;"
        ,[]).asStream().listen((rows) {
      streamController.add(rows);
      // rows.map((e) {
      //   streamController.add(e);
      // });
      print('mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm');
      print('mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm');
      print(rows);
      print('mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm');
      print('mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm');
    });
    print(maps);
    return streamController.stream;
  }



}