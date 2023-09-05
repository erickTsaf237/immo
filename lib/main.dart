import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:immo/appartement/Appartement_model.dart';
import 'package:immo/batiment/batiment_list_page.dart';
import 'package:immo/batiment/batiment_model.dart';
import 'package:immo/batiment/batiment_page.dart';
import 'package:immo/batiment/create_batiment.dart';
import 'package:immo/tools/about/about_us.dart';
import 'package:immo/tools/mon_drawable.dart';
import 'package:immo/utilisateur/utilisateur_model.dart';
import 'package:path/path.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite/sqflite.dart';

import 'accueille/connexion.dart';
import 'firebase_options.dart';

late UtilisateurModel? utilisateur_courant;
late Future<Database> database;

Future<int> createDatabase() async {
  WidgetsFlutterBinding.ensureInitialized();
  // databaseFactory = databaseFactoryFfi;
  database = openDatabase(
    join(await getDatabasesPath(), 'immo.db'),
    onCreate: (db, version) {
       db.execute(UtilisateurModel.creationLocalUtilisateur);
       db.execute(BatimentModel.creationLocalBatiment);
       db.execute(AppartementModel.creationLocalAppartement);
    },
    version: 2,
    onUpgrade: (db, version, autre) {
       db.execute(UtilisateurModel.creationLocalUtilisateur);
       db.execute(BatimentModel.creationLocalBatiment);

    },
  );
  UtilisateurModel? a = await UtilisateurModel.ConnectCurrentUtilisateur();
  AppartementModel.getAll()?.then((value) {
    print(value);
  });
  utilisateur_courant = a;
  print(a);
  print(await getDatabasesPath());
  return 1;
}

//project-692119567575
void main() {
  createDatabase().then((value) {
    runApp(const MyApp());
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ).then((value) {
      print('erick');
    });
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        // useMaterial3: true,
      ),
      initialRoute: (utilisateur_courant != null) ? '/home' : 'login',
      routes: {
        '/login': (context) => LoginPage(),
        '/about': (context) => AboutUsPage(),
        '/batiment': (context) => BatimentListPage(),
        // '/logup': (context) => const Logup(),
        '/home': (context) => const MyHomePage(title: 'Immo'),
        // '/section': (context) => MyHomePage.who=='admin'?SectionPage():SectionePage(),
      },
      home: (utilisateur_courant != null)
          ? const MyHomePage(title: 'Mes factures')
          : LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      drawer: const MonDrawer(),
      body: Container(
        padding: EdgeInsets.all(25),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(

                    content: MyCreateBatimentPage(
                        BatimentModel('', '', '', '', '', ''), () {
                      setState(() {});
                    }));
              });
        },
        tooltip: '',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
