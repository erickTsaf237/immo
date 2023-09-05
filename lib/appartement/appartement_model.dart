


import 'package:immo/immo_manager.dart';

class AppartementModel extends Immo{

  late String id_batiment;
  late String numero;
  late String description;
  late String etat;

  AppartementModel(this.id_batiment, this.numero, this.description, this.etat, super.id);



  static const String creationLocalAppartement =
      'CREATE TABLE Appartement(id Integer PRIMARY KEY,'
      ' id_batiment INTEGER NOT NULL,'
      ' numero TEXT NOT NULL,'
      ' description TEXT,'
      ' etat TEXT default \'libre\','
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
      'numero':numero,
      'id_batiment':id_batiment,
      'description':description,
    };
  }

  static AppartementModel fromJson(r) {
    return AppartementModel(r['id_batiment'].toString(), r['numero'], r['description'], r['etat']??'libre', r['id'].toString());
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
}