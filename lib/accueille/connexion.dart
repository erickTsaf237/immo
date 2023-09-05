import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../immo_manager.dart';
import '../main.dart';
import '../tools/tools.dart';
import '../utilisateur/utilisateur_model.dart';
import 'RegisterPage.dart';
import 'google.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: LogIn(),
    );
  }
}

class LogIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LogIn();
  }
}

class _LogIn extends State<LogIn> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  String email = '';
  String password = '';
  final _formkey = GlobalKey<FormState>();
  String message = '';
  String emailStatus = '';
  String passwordStatus = '';
  String confirmStatus = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          height: 450,
          width: 400,
          child: Center(
            child: Column(
              children: [
                Center(
                  child: Title(
                      color: Colors.black,
                      child: const Text(
                        'Connectez vous',
                        style: TextStyle(fontSize: 25),
                      )),
                ),
                Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          // initialValue: depence.id!= null? "${depence.libele}":"",
                          decoration: const InputDecoration(labelText: 'Email'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer votre email';
                            } else if (!isValidEmail(value)) {
                              return 'L\'adresse e-mail n\'est pas valide.';
                            } else if (emailStatus.isNotEmpty) {
                              return emailStatus;
                            }
                            return null;
                          },

                          onSaved: (value) => email = value!,
                        ),
                        const SizedBox(
                          height: 16.0,
                          width: 100,
                        ),
                        TextFormField(
                          obscureText: true,

                          decoration:
                              const InputDecoration(labelText: 'mot de passe'),
                          // initialValue: depence.id!= null? "${depence.price}":"",
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer votre mot de passe';
                            } else if (passwordStatus.isNotEmpty) {
                              return passwordStatus;
                            }
                            return null;
                          },
                          onSaved: (value) => password = value!,
                        ),
                        const SizedBox(
                          height: 16.0,
                          width: 25,
                        ),
                        Text('$message',
                            style: const TextStyle(
                                color: Colors.red, fontSize: 13)),
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
                            Expanded(
                              child: Center(
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RegisterPage(UtilisateurModel(
                                                      'email',
                                                      'nom',
                                                      'mot_de_passe',
                                                      'prenom',
                                                      'image',
                                                      'date_naissance',
                                                      'numero_telephone',
                                                      ''))));
                                    },
                                    child: const Text('S\'enregistrer')),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.indigo,
                              width: 4,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Center(
                                  child: InkWell(
                                      onTap: () async {
                                        var UserCredetial =
                                            await signInWithGoogle();

                                        if (UserCredetial != null) {
                                          print(UserCredetial);
                                          utilisateur_courant =
                                              UtilisateurModel.fromGoogle(
                                                  UserCredetial
                                                      .additionalUserInfo
                                                      ?.profile);
                                          utilisateur_courant
                                              ?.saveUtilisateur2();
                                          Navigator.pushReplacementNamed(
                                              context, '/home');
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(border: Border.all(width: 1)),
                                        child: Image.asset('assets/images/google.png',
                                            height: 35,
                                            width: 35,
                                            errorBuilder: (context, object, error){
                                          return Image.network(
                                              'http://pngimg.com/uploads/google/google_PNG19635.png',
                                              height: 35,
                                              width: 35,
                                              errorBuilder: (context,objet, erro){
                                                return Text('Google', style: TextStyle(color: Colors.blue, fontSize: 16),);
                                              },
                                              fit: BoxFit.cover
                                          );
                                        }),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ))
              ],
            ),
          )),
    );
  }

  Future<int> _submit(BuildContext context) async {
    // jsonEncode(userBackend);
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();

      if (email.isNotEmpty && password.isNotEmpty) {
        UtilisateurModel.seConnecter(email, password).then((re) {
          if (re != null) {
            if (re.codeStatus == 200) {
              passwordStatus = '';
              emailStatus = '';
              utilisateur_courant = UtilisateurModel.fromJson(re.data);
              _formkey.currentState!.validate();
              confirmationBox(context);
            } else if (re.codeStatus == 404) {
              print('object');
              if (re.message == 'Mot de passe incorrecte') {
                passwordStatus = 'Mot de passe incorrecte';
              } else {
                emailStatus = 'Email Introuvable';
              }
              _formkey.currentState!.validate();
              passwordStatus = '';
              emailStatus = '';
            }
          } else {
            setState(() {
              message = 'Vous n\'etes pas connecté !!';
            });
          }
        });
      }
      // Navigator.pop(context);
      // BackendConfig.etat?.setState(() {});
    }
    return 0;
  }

  confirmationBox(BuildContext context) {
    String token = '';
    var confirmController = TextEditingController();
    final formkey = GlobalKey<FormState>();
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('cle de confirmation'),
          content: Column(
            children: [
              const Text(
                  'Une clé de confirmation vous a ete envoyer par Mail, veuillez entrer cette clé.'),
              Form(
                key: formkey,
                child: TextFormField(
                  controller: confirmController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez la cle de confirmation';
                    } else if (value.length < 6) {
                      return 'Veuller entrer tout le champ de la cle';
                    } else if (confirmStatus.isNotEmpty) {
                      return confirmStatus;
                    }
                    return null;
                  },
                  onSaved: (value) {
                    token = value!;
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6,
                        maxLengthEnforcement:
                            MaxLengthEnforcement.truncateAfterCompositionEnds),
                    FilteringTextInputFormatter.digitsOnly
                    // ne permet que la saisie de chiffres
                  ],
                ),
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Confirmer'),
              onPressed: () async {
                formkey.currentState!.save();
                await submitToken(formkey, token, context);
              },
            ),
          ],
        );
      },
    );
  }

  submitToken(formkey, token, BuildContext context) {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      UtilisateurModel.confirmerConnexion(email, password, token).then((re) {
        if (re != null) {
          print(re);
          if (re.codeStatus == 200) {
            formkey.currentState!.validate();
            Immo.accessToken = re.message!;
            print('dddddddddddddddddddddddddddddddddddddddddd1d');
            print(Immo.accessToken);
            print('dddddddddddddddddddddddddddddddddddddddddd1d');
            UtilisateurModel.deleteUtilisateur().then((value) {
              UtilisateurModel.saveUtilisateur(email, password, token);
            });
            // return true;
            Navigator.of(context).pop();
            // Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const MyHomePage(title: 'Mes familles')));
          } else if (re.codeStatus == 404) {
            confirmStatus = 'Mauvaise cle de confirmation';
            if (re.message == 'Mauvaise cle de confirmation') {}
            formkey.currentState!.validate();
            confirmStatus = '';
          }
        } else {
          setState(() {
            message = 'Vous n\'etes pas connecté !!';
          });
        }
      });
    } else {
      //Navigator.of(dialogContext).pop(); // Dismiss alert dialog
    }
    return false;
  }
}
