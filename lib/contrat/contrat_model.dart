
import '../immo_manager.dart';


class ContratModel extends Immo {
  late String createdAt;
  late int nombreDeMois;
  late int montant;
  late String dateDeDebut;
  late String id_appartement;
  late String id_locataire;
  late String etat_contrat;
  late int index_eau;
  late int index_electricite;

  setIndex(int index_eau, int index_electricite){
    this.index_eau = index_eau;
    this.index_electricite = index_electricite;
  }

  ContratModel(this.createdAt, this.nombreDeMois, this.montant, this.dateDeDebut,
      this.id_appartement, this.id_locataire, super.id,
      {this.etat_contrat ='en cours', this.index_electricite = 0, this.index_eau=0}){
    chemin = 'Contrat';
  }

  terminerContrat(){
    etat_contrat = 'terminé';
  }
  rompreContrat(){
    etat_contrat = 'rompu';
  }

  static const String creationLocalContrat =
      'CREATE TABLE Contrat(id INTEGER PRIMARY KEY,'
      ' createdAt TEXT, nombreDeMois INTEGER default 12,'
      ' index_eau INTEGER, index_electricite INTEGER,'
      ' montant INTEGER  NOT NULL, dateDeDebut TEXT  NOT NULL,'
      ' etat_contrat TEXT default \'en cours\','
      ' id_appartement TEXT NOT NULL,'
      ' id_locataire TEXT  NOT NULL,'
      'FOREIGN KEY (id_appartement) REFERENCES Appartement(id)'
      'ON UPDATE CASCADE ON DELETE RESTRICT,'
      'FOREIGN KEY (id_locataire) REFERENCES Locataire(id)'
      'ON UPDATE CASCADE ON DELETE RESTRICT,'
      'UNIQUE(id,etat_contrat))';

  @override
  toJson() {
    // TODO: implement toJson
    return {
      if (id.isNotEmpty)
        'id': id,
      'createdAt': createdAt,
      'nombreDeMois': nombreDeMois,
      'montant': montant,
      'dateDeDebut': dateDeDebut,
      'id_appartement': id_appartement,
      'etat_contrat': etat_contrat,
      'index_eau':index_eau,
      'index_electricite':index_electricite,
      'id_locataire': id_locataire
    };
  }

  static fromJson(data) {
    return ContratModel(
        data['createdAt'],
        data['nombreDeMois'],
        data['montant'],
        data['dateDeDebut'],
        data['id_appartement'],
        data['id_locataire'],
        data['id'].toString(), etat_contrat: data['etat_contrat'],
        index_eau: data['index_eau']??1, index_electricite: data['index_electricite']??1);
  }

  @override
  getTableName() {
    // TODO: implement getTableName
    return 'Contrat';
  }
}
