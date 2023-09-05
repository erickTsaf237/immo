import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:immo/tools/mon_drawable.dart';
import 'package:share/share.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MyAboutUsPage();
  }
}

class MyAboutUsPage extends StatefulWidget {
  @override
  _MyAboutUsPage createState() {
    return _MyAboutUsPage();
  }
}

class _MyAboutUsPage extends State<MyAboutUsPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('About us')),
      drawer: MonDrawer(),
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(
              width: 2,
            )),
            padding: const EdgeInsets.all(5),
            child: Image.asset(
              'assets/images/erick_pp.jpeg',
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
              child: Title(
                  color: Colors.black,
                  child: const SelectableText(
                    'Erick Tsafack',
                    style: TextStyle(fontSize: 30),
                  ))),
          Container(
            padding: EdgeInsets.all(10),
            child: const SelectableText(
                "Je suis un ingenieur Camerounais en genie logiciel diplomé de l'IUT Fotso Victor de Bandjoun. "
                "Mon objectif au quotidient est de concevoir et realiser des solutions logiecieles comme celle ci à"
                " moindre cout afin de vous faciliter la vie dans vos travaux de tout les jours. Je serais ravis de "
                "vous donner d'emples information sur ce que je fais ou pour vous expliquer comment je pourais vous etre"
                " utile. Vous pouvez me contacter par les canaux ci apres",
                style: TextStyle(fontSize: 16)),
          ),
          ListTile(
            leading: Image.asset('assets/images/whatsapp.png'),
            title: const Text('+ 237 654 19 05 14'),
            subtitle: const Text('Appel ou whatzApp'),
            trailing: const Text('MTN'),
            onTap: () async {
              String url = 'https://wa.me/+237654190514';
              if (await canLaunchUrl(Uri.parse(url))) {
                launchUrl(Uri.parse(url));
              } else {
                throw 'Impossible d\'ouvrir le lien $url';
              }
            },
          ),
          ListTile(
            title: Text('+237 695 56 36 32'),
            leading: Icon(Icons.call, color: Colors.green, size: 45),
            subtitle: Text('Appel'),
            trailing: Text('Orange'),
            onTap: () {
              canLaunchUrl(Uri(scheme: 'tel', path: '+237695563632')).then((bool result) {
                launchUrl(Uri(scheme: 'tel', path: '+237695563632'));
              });
            },
          ),
          ListTile(
            leading: Image.asset('assets/images/linkedin.png'),
            title: const Text('linkedin.com/in/erick-tsafack-40037423a'),
            subtitle: const Text('LinkeIn'),
            onTap: () async {
              String url = 'https://www.linkedin.com/in/erick-tsafack-40037423a/';
              if (await canLaunchUrl(Uri.parse(url))) {
                launchUrl(Uri.parse(url));
              } else {
                throw 'Impossible d\'ouvrir le lien $url';
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.open_in_browser, size: 45),
            title: const Text('presentation-8dffa.web.app'),
            subtitle: const Text('Mon Portfolio'),
            onTap: () async {
              String url = 'https://presentation-8dffa.web.app/';
              if (await canLaunchUrl(Uri.parse(url))) {
                launchUrl(Uri.parse(url));
              } else {
                throw 'Impossible d\'ouvrir le lien $url';
              }
            },
          ),
          ListTile(
              title: Text('ericktsafack2017@gmail.com'),
              leading: Icon(Icons.email, color: Colors.blue, size: 45),
              subtitle: Text('email'),
              onTap: () async {
                final box = context.findRenderObject() as RenderBox?;

                await Share.share(
                  'ericktsafack2017@gmail.com',
                  subject: 'subject',
                  sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
                );
              },

          ),

        ],
      ),
    );
  }
}
