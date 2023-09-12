import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:immo/main.dart';

import 'location_model.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CreateLocationPage extends StatelessWidget {
  late LocationModel location = LocationModel('', '', '', '', '', '');
  late dynamic function;

  CreateLocationPage(this.location, this.function, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: MyCreateLocationPage(location, function),
    );
  }
}

class MyCreateLocationPage extends StatefulWidget {
  late LocationModel location = LocationModel('', '', '', 'libre', '', '');
  late dynamic function;

  MyCreateLocationPage(this.location, this.function, {super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyCreateLocationPage(location, function);
  }
}

class _MyCreateLocationPage extends State<MyCreateLocationPage> {
  var nomController = TextEditingController();
  var createdAtController = TextEditingController();
  var electriciController = TextEditingController();
  var eauController = TextEditingController();
  var descriptionController = TextEditingController();
  late LocationModel location = LocationModel('', '', '', 'libre', '', '');

  late dynamic function;

  _MyCreateLocationPage(this.location, this.function) {
    createdAtController.text =
        '${location.createdAt} ${location.createdAt == DateTime.now().toString().substring(0, 10) ? '(Aujourd\'hui)' : ''}';
    if (location.id.isNotEmpty) {
      eauController.text = location.index_eau.toString();
      electriciController.text = location.index_electricite.toString();
    }
  }

  final _formkey = GlobalKey<FormState>();
  String message = '';
  String visibilityStatus = '';
  String userStatus = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        // color: Colors.cyan,
        constraints: BoxConstraints(
          maxHeight: double.infinity,
        ),
        // padding: const EdgeInsets.symmetric(horizontal: 1),
        height: 360,
        width: 400,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: Title(
                    color: Colors.black,
                    child: Text(
                      textAlign: TextAlign.center,
                      location.id.isEmpty
                          ? 'Nouvelle facture (${location.appartement?.numero})'
                          : 'Modifier la facture',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    )),
              ),
              Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: electriciController,
                        // initialValue: depence.id!= null? "${depence.libele}":"",
                        decoration: InputDecoration(
                            labelText: 'Index electricité',
                            hintText:
                                'ancien index: ${location.appartement!.index_electricite}'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Veuillez entrer le numero de ce Location';
                          } else if (userStatus.isNotEmpty) {
                            return message;
                          }
                          return null;
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(12,
                              maxLengthEnforcement: MaxLengthEnforcement
                                  .truncateAfterCompositionEnds),
                          FilteringTextInputFormatter.digitsOnly
                          // ne permet que la saisie de chiffres
                        ],

                        onSaved: (value) =>
                            location.index_electricite = int.parse(value!),
                      ),
                      const SizedBox(
                        height: 16.0,
                        width: 25,
                      ),
                      TextFormField(
                        controller: eauController,
                        // minLines: 4,
                        // initialValue: depence.id!= null? "${depence.libele}":"",
                        decoration: InputDecoration(
                            labelText: 'index eau',
                            hintText:
                                'ancien index: ${location.appartement!.index_eau}'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Veuillez entrer l\'index d\'eau';
                          } else if (userStatus.isNotEmpty) {
                            return message;
                          }
                          return null;
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(12,
                              maxLengthEnforcement: MaxLengthEnforcement
                                  .truncateAfterCompositionEnds),
                          FilteringTextInputFormatter.digitsOnly
                          // ne permet que la saisie de chiffres
                        ],

                        onSaved: (value) =>
                            location.index_eau = int.parse(value!),
                      ),
                      const SizedBox(
                        height: 16.0,
                        width: 25,
                      ),
                      TextFormField(
                        controller: createdAtController,
                        // initialValue: depence.id!= null? "${depence.libele}":"",
                        decoration: const InputDecoration(labelText: 'Jour'),
                        readOnly: true,
                        onTap: () async {
                          createdAtController.text = await _selectDate(
                              context, DateTime.parse(location.createdAt));
                        },
                        enabled: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Veuillez entrer votre date de naissance';
                          }
                          /*else if (datenaissanceStatus.isNotEmpty) {
                            return datenaissanceStatus;
                          }*/
                          return null;
                        },
                        onSaved: (value) => location.createdAt = value!,
                      ),
                      Text(message,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 13)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Center(
                              child: ElevatedButton(
                                  onPressed: () {
                                    _submit(context);
                                  },
                                  child: const Text('Valider')),
                            ),
                          ),
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ));
  }

  Future<int> _submit(BuildContext context) async {
    // jsonEncode(userBackend);
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      if (location.id.isNotEmpty) {
        location.update().then((re) {
          print(re);
          function();
          Navigator.pop(context);
        }).catchError((error) {
          message = 'Un Location ayant ce code existe deja';
          userStatus = 'Un Location ayant ce code existe deja';
          _formkey.currentState!.validate();
          userStatus = '';
        });
      } else {
        location.setIndexAncien();
        var etat_location = '${location.appartement!.etat_location}';
        location.setIndexAncien();
        location.appartement!.index_eau = location.index_eau;
        location.appartement!.index_electricite = location.index_electricite;
        location.appartement!.etat_location = 'en attente';
        location.save().then((re) {
          print(re);
          location.appartement?.id_location = re.toString();
          location.appartement!.update();
          function();
          homeFunction();
          Navigator.pop(context);
        }).catchError((error) {
          location.appartement!
              .setIndex(location.a_index_eau, location.a_index_electricite);
          location.appartement!.etat_location = etat_location;
          message = 'Un Location ayant ce code existe deja';
          userStatus = 'Un Location ayant ce code existe deja';
          _formkey.currentState!.validate();
          userStatus = '';
        });
      }
    }
    return 0;
  }

  Future<String> _selectDate(BuildContext context, DateTime intialDate) async {
    DateTime? selectedDate = DateTime.now();
    try {
      selectedDate = await showDatePicker(
          context: context,
          initialDate: intialDate,
          firstDate: DateTime(1900),
          lastDate: DateTime(2100));
      if (selectedDate != null) {
        return selectedDate.toString();
      }
    } catch (e) {}
    return '';
  }
}

displayFacture(BuildContext context, LocationModel location) {
  double tva;
  double total_electricite;
  double total_eau;
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
            child: Title(
                color: Colors.black,
                title:
                    'Bill of the appartment N° ${location.appartement!.numero}',
                child: Text(
                  'Bill of the appartment N° ${location.appartement!.numero}'
                      .toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.center,
                ))),
        const SizedBox(
          height: 20,
          width: 13,
        ),
        Text(
            'Names of Tenant ${location.appartement?.locataire?.nom} ${location.appartement?.locataire?.prenom}'),
        Text('Period of billing: ${location.createdAt.substring(0, 7)}'),
        const SizedBox(
          height: 20,
          width: 13,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'I. Electricity: Readings',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
              width: 13,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Now: ${location.index_electricite}'),
                Text('Previous: ${location.a_index_electricite}'),
              ],
            )
          ],
        ),
        Text(
            'Consumption: ${location.index_electricite - location.a_index_electricite}         Unit Price: 100'),
         Text('TVA: ${(tva=(location.index_electricite - location.a_index_electricite) * 19.25)}            Electric meter rent: 200 FCFA'),
        Text(
            'Total electricity: ${total_electricite=(location.index_electricite - location.a_index_electricite) * 100 + 200+tva} FCFA'),
        SizedBox(
          height: 20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'II. Water: Readings',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
              width: 13,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Now: ${location.index_eau}'),
                Text('Previous: ${location.a_index_eau}'),
              ],
            ),
          ],
        ),
        Text(
            'Consumption: ${location.index_electricite - location.a_index_electricite}         Unit Price: 368 FCFA'),
        Text('TVA: 0               Electric meter rent: 200 FCFA'),
        Text(
            'Total Water: ${total_eau=(location.index_eau - location.a_index_eau) * 368 + 200} FCfA'),
        SizedBox(
          height: 20,
        ),
        Text(
            'Grand total water and Electricity: ${total_eau+total_electricite} FCFA'),
        SizedBox(
          height: 20,
        ),
        Text(
            'III. House rent of: ${location.appartement!.contrat!.montant} FCFA',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(
          height: 20,
        ),
        Text(
          'Net to be paid = I+II+III :${total_eau + total_electricite + location.appartement!.contrat!.montant} FCFA',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 25,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Latest date of payment: ${location.createdAt.substring(0, 7)}-10',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        const Text(
          'Take note: Penalty of late payment = 2000 FCFA (reconnection fee)',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ],
    ),
  );
}

displayFacture2(BuildContext context, LocationModel location) {
  double tva;
  double total_electricite;
  double total_eau;
  return pw.Container(
    padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Center(
            child:  pw.Text(
                  'Bill of the appartment N° ${location.appartement!.numero}'
                      .toUpperCase(),
                  style:  pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 20),
                  textAlign: pw.TextAlign.center,
                )),
         pw.SizedBox(
          height: 20,
          width: 13,
        ),
        pw.Text(
            'Names of Tenant ${location.appartement?.locataire?.nom} ${location.appartement?.locataire?.prenom}'),
        pw.Text('Period of billing: ${location.createdAt.substring(0, 7)}'),
        pw.SizedBox(
          height: 20,
          width: 13,
        ),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'I. Electricity: Readings',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(
              height: 20,
              width: 13,
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Now: ${location.index_electricite}'),
                pw.Text('Previous: ${location.a_index_electricite}'),
              ],
            )
          ],
        ),
        pw.Text(
            'Consumption: ${location.index_electricite - location.a_index_electricite}         Unit Price: 100'),
        pw.Text('TVA: ${(tva=(location.index_electricite - location.a_index_electricite) * 19.25)}            Electric meter rent: 200 FCFA'),
        pw.Text(
            'Total electricity: ${total_electricite=(location.index_electricite - location.a_index_electricite) * 100 + 200+tva} FCFA'),
        pw.SizedBox(
          height: 20,
        ),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'II. Water: Readings',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(
              height: 20,
              width: 13,
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Now: ${location.index_eau}'),
                pw.Text('Previous: ${location.a_index_eau}'),
              ],
            ),
          ],
        ),
        pw.Text(
            'Consumption: ${location.index_electricite - location.a_index_electricite}         Unit Price: 368 FCFA'),
        pw.Text('TVA: 0               Electric meter rent: 200 FCFA'),
        pw.Text(
            'Total Water: ${total_eau=(location.index_eau - location.a_index_eau) * 368 + 200} FCfA'),
        pw.SizedBox(
          height: 20,
        ),
        pw.Text(
            'Grand total water and Electricity: ${total_eau+total_electricite} FCFA'),
        pw.SizedBox(
          height: 20,
        ),
        pw.Text(
            'III. House rent of: ${location.appartement!.contrat!.montant} FCFA',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(
          height: 20,
        ),
        pw.Text(
          'Net to be paid = I+II+III :${total_eau + total_electricite + location.appartement!.contrat!.montant} FCFA',
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20),
        ),
        pw.SizedBox(
          height: 25,
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text(
              'Latest date of payment: ${location.createdAt.substring(0, 7)}-10',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 15),
            ),
          ],
        ),
        pw.SizedBox(
          height: 25,
        ),
        pw.Text(
          'Take note: Penalty of late payment = 2000 FCFA (reconnection fee)',
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 15),
        ),
      ],
    ),
  );
}
