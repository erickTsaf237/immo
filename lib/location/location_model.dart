


import 'package:immo/immo_manager.dart';

import '../appartement/Appartement_model.dart';

class LocationModel extends Immo{

  late String id_appartement;
  late String id_locataire;
  late String id_contrat;
  late String createdAt;
  late String id_location_precedente;
  late String description;
  late String date_reglement;
  late int index_eau;
  late int index_electricite;
  late int a_index_eau;
  late int a_index_electricite;

  late AppartementModel? appartement;



  LocationModel(this.id_appartement,this.id_locataire,this.id_location_precedente,
      this.id_contrat, this.description, super.id,
      { this.index_electricite = 0, this.index_eau=0, this.a_index_eau = 0, this.a_index_electricite=0, this.date_reglement='', this.createdAt = '', this.appartement}){
    if (createdAt.isEmpty) {
      createdAt = DateTime.now().toString().substring(0, 10);
    }
  }

  static const String creationLocalLocation =
      'CREATE TABLE Location(id Integer PRIMARY KEY,'
      ' id_appartement INTEGER NOT NULL,'
      ' id_locataire INTEGER NOT NULL,'
      ' id_contrat INTEGER NOT NULL,'
      ' id_location_precedente Text default \'\','
      ' montantTotal INTEGER,'
      ' index_eau INTEGER, index_electricite INTEGER,'
      ' a_index_eau INTEGER, a_index_electricite INTEGER,'
      ' description TEXT,'
      ' createdAt TEXT,'
      ' date_reglement TEXT,'
      // 'UNIQUE(id_batiment, numero), '
      'FOREIGN KEY (id_appartement) REFERENCES Appartement(id)'
      'ON UPDATE CASCADE ON DELETE RESTRICT,'
      'FOREIGN KEY (id_locataire) REFERENCES Locataire(id)'
      'ON UPDATE CASCADE ON DELETE RESTRICT,'
      'FOREIGN KEY (id_contrat) REFERENCES Contrat(id)'
      'ON UPDATE CASCADE ON DELETE RESTRICT'
      ')';


  @override
  String getTableName() {
    // TODO: implement getTableName
    return 'Location';
  }

  @override
  toJson() {
    // TODO: implement toJson
    return {
      if(id.isNotEmpty)
        'id':id,
      'id_appartement':id_appartement,
      'id_locataire':id_locataire,
      'id_contrat':id_contrat,
      'id_location_precedente':id_location_precedente??'',
      'description':description,
      'date_reglement':date_reglement,
      'index_eau':index_eau,
      'createdAt':createdAt,
      'index_electricite':index_electricite,
      'a_index_electricite':a_index_electricite,
      'a_index_eau':a_index_eau,
    };
  }

  static LocationModel fromJson(r) {
    return LocationModel(r['id_appartement'].toString(),r['id_locataire'].toString(),
      r['id_location_precedente'].toString(),r['id_contrat'].toString(), r['description'], r['id'].toString(),
        index_eau: r['index_eau']??1,a_index_eau: r['a_index_eau']??1,createdAt: r['createdAt'],
        index_electricite: r['index_electricite']??0,a_index_electricite: r['a_index_electricite']??0, date_reglement: r['date_reglement']??'');
  }

  static Future<List<Map<String, Object?>>>? getAll(){
    return Immo.getAll('Location');
  }
  static Future<List<Map<String, Object?>>>? getOneById(String id){
    return Immo.getOneById('Location', id);
  }
  static Future<List<Map<String, Object?>>>? getAllById_appartement(String id_appartement){
    return Immo.getAllByFK('Location', {'key':'id_appartement', 'value':id_appartement});
  }



  @override
  String toString() {
    return 'LocationModel{id_appartement: $id_appartement, description: $description}';
  }

  void setIndexAncien() {
    a_index_eau = appartement!.index_eau;
    a_index_electricite = appartement!.index_electricite;
  }

  static getLatessLocation(String appartement_id) {

  }


}