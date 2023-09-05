


import 'package:immo/immo_manager.dart';

class BatimentModel extends Immo{

  late String nom;
  late String numero;
  late String ville;
  late String quartier;
  late String description;


  static const String creationLocalBatiment =
      'CREATE TABLE Batiment(id Integer PRIMARY KEY,'
      ' nom TEXT, numero TEXT UNIQUE NOT NULL,'
      ' image TEXT, quartier TEXT,'
      ' ville TEXT,'
      ' description TEXT)';


  @override
  String getTableName() {
    // TODO: implement getTableName
    return 'Batiment';
  }

  @override
  toJson() {
    // TODO: implement toJson
    return {
      if(id.isNotEmpty)
      'id':id,
      'nom':nom,
      'numero':numero,
      'ville':ville,
      'quartier':quartier,
      'description':description,
    };
  }

  BatimentModel(
      this.nom, this.numero, this.ville, this.quartier, this.description, super.id);

  static BatimentModel fromJson(r) {
    return BatimentModel(r['nom'], r['numero'], r['ville'], r['quartier'], r['description'], '${r['id']}');
  }

  static Future<List<Map<String, Object?>>>? getAll(){
    return Immo.getAll('batiment');
  }
  static Future<List<Map<String, Object?>>>? getOneById(String id){
    return Immo.getOneById('batiment', id);
  }
}