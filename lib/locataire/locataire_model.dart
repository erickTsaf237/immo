
import '../immo_manager.dart';
import '../main.dart';


class LocataireModel extends Immo {
  late String nom;
  late String prenom;
  late String image;
  late String sexe = 'Masculin';
  late String numero_telephone;


  LocataireModel( this.nom, this.prenom,
      this.image, this.numero_telephone, super.id,
      {this.sexe = 'Masculin'}){
    chemin = 'Locataire';
  }

  static const String creationLocalLocataire =
      'CREATE TABLE Locataire(id INTEGER PRIMARY KEY,'
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
    return LocataireModel(
        data['nom'],
        data['prenom'],
        data['image'],
        data['numero_telephone'],
        data['id_locataire'].toString()??data['id'].toString(),
        sexe: data['sexe']);
  }

  static fromGoogle(data) {
    return LocataireModel(
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

  static Future<List<Map<String, Object?>>> getCurrentLoctaire(String id_appartement) async {
    print(id_appartement);
    final db = await database;
    // final maps = await db.query('Utilisateur',limit: 1,);
    final maps = await db.rawQuery("select * from Locataire l inner join Contrat c on l.id=c.id_locataire"
        " where id_appartement=? and etat_contrat = 'en cours'"
        // "ORDER BY createdAt DESC LIMIT 1;"
        ,[id_appartement]);
    print(maps);
    print(id_appartement);
    return maps;
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
}
