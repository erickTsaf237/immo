import 'dart:io';

import 'package:flutter/material.dart';
import 'package:immo/appartement/Appartement_model.dart';
import 'package:immo/appartement/appartement_item.dart';
import 'package:immo/appartement/create_appartement.dart';
import 'package:immo/location/create_facture.dart';
import 'package:immo/location/location_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:share/share.dart';
import 'package:shimmer/shimmer.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:url_launcher/url_launcher.dart';


class LocationPage extends StatelessWidget {
  LocationPage(this.appartement, this.function, {Key? key}) : super(key: key);
  late AppartementModel appartement;
  late Function function;

  @override
  Widget build(BuildContext context) {
    return MyLocationPage(appartement, function);
  }
}


class MyLocationPage extends StatefulWidget {
  late AppartementModel appartement;
  late Function function;

  MyLocationPage(this.appartement, this.function, {Key? key}) : super(key: key);

  @override
  _MyLocationPage createState() => _MyLocationPage(appartement, function);
}

class _MyLocationPage extends State<MyLocationPage> {
  late AppartementModel appartement;
  late LocationModel location;
  late Function function;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appartement ${appartement.numero}'),
        actions: [
          IconButton(
              onPressed: () {
                /*showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          content: MyCreateLocationPage(location, () {
                        function();
                        setState(() {});
                      }));
                    });*/
              },
              icon: Icon(Icons.pending_actions)),
        ],
      ),
      body: FutureBuilder(
          future: LocationModel.getOneById(appartement.id_location),
          builder: (context, AsyncSnapshot<List<Map<String, Object?>>> response) {
            // print(response);
            if (response.hasError) {
              return Text('Il y\'a eu une erreur 1');
            } else if (response.hasData) {
              if(response.data != null){
                print(response.data);
                // String? a = response.data?.data!;
                // String b = a!;
                dynamic r = response.data;
                location = LocationModel.fromJson(r[0]);
                location.appartement =  appartement;
                // location.setIndexAncien();
                return displayFacture(context, location);
              }else{
                return const Text('Il y\'a eu une erreur');
              }

            }
            return Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.white,
              child: ListView(
                children: [
                  for (int i = 0; i < 10; i++)
                    ListTile(
                      title: Container(
                        width: 0,
                        color: Colors.grey,
                        height: 15,
                        child: const Text(''),
                      ),
                      leading: const CircleAvatar(
                        backgroundColor: Colors.grey,
                      ),
                      subtitle: Container(
                        width: 0,
                        color: Colors.grey,
                        height: 10,
                      ),
                    ),
                ],
              ),
            );
          }),
      floatingActionButton: ElevatedButton(
          child: const Text('Imprimer'),
          onPressed: () {
            printPdf();
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }


  pw.Widget buildPdfContent() {
    // Votre widget Flutter ici
    return pw.Container(child: displayFacture2(context, location));
  }

  Future<void> printPdf() async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return buildPdfContent();
      },
    ));
    final output = await getApplicationDocumentsDirectory();
    final directoryPath = '${output.path}/${location.appartement!.numero}/${location.appartement!.locataire!.nom} ${location.appartement!.locataire!.prenom}';
    final filePath = '${directoryPath}/${location.createdAt.substring(0, 7)}.pdf';
    bool exist = await Directory(directoryPath).exists();
    if(!exist){
      await Directory(directoryPath).create(recursive: true);
    }
    final file = File(filePath);
    await pdf.save();
    await file.writeAsBytes(await pdf.save(), );
    print('endddddd-----------------------------------------\n$filePath');
    String url = 'https://wa.me/+237654190514?text=file://$filePath';
    /*if (await canLaunchUrl(Uri.parse(url))) {
      launchUrl(Uri.parse(url));
    } else {
      throw 'Impossible d\'ouvrir le lien $url';
    }*/
    final box = context.findRenderObject() as RenderBox?;

    await Share.shareFiles(
      [filePath],
      text: 'Ce fichier contient votre facture pour le compte de ${location.createdAt.substring(0, 7)}',
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
    /*Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );*/
  }

  _MyLocationPage(this.appartement, this.function);
}
