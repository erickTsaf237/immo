import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../main.dart';
import '../tools/tools.dart';
import '../utilisateur/utilisateur_model.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage(this.utilisateurModel, {Key? key}) : super(key: key);
  late UtilisateurModel utilisateurModel;

  @override
  _RegisterPageState createState() => _RegisterPageState(this.utilisateurModel);
}

class _RegisterPageState extends State<RegisterPage> {
  late UtilisateurModel utilisateurModel;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmController = TextEditingController();
  var nomController = TextEditingController();
  var numeroController = TextEditingController();
  var prenomController = TextEditingController();
  var datenaissaceController = TextEditingController();
  var imageController = TextEditingController();

  _RegisterPageState(this.utilisateurModel);

  String email = '';
  String password = '';
  final _formkey = GlobalKey<FormState>();
  String message = '';
  String emailStatus = '';
  String nomStatus = '';
  String prenomStatus = '';
  String numeroStatus = '';
  String imageStatus = '';
  String datenaissanceStatus = '';
  String passwordStatus = '';
  String passwordconfirmStatus = '';
  String confirmStatus = '';

  Future<int> _submit(BuildContext context) async {
    // jsonEncode(userBackend);
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();

      /*utilisateurModel.save()?.then((re) {
        if (re != null) {
          if (re.codeStatus == 200) {
            passwordStatus = '';
            emailStatus = '';
            utilisateur_courant = UtilisateurModel.fromJson(re.data);
            _formkey.currentState!.validate();
            Navigator.pop(context);
            // confirmationBox(context);
          } else if (re.codeStatus == 500) {
            print('object');
            emailStatus = 'Cet Email existe deja';
            _formkey.currentState!.validate();
            passwordStatus = '';
            emailStatus = '';
          }
        } else {
          setState(() {
            message = 'Vous n\'etes pas connecté !!';
          });
        }
      });*/
      // Navigator.pop(context);
      // BackendConfig.etat?.setState(() {});
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Enregistrez vous'),
        ),
        body: ListView(
          children: [
            Center(
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  // height: 450,
                  width: 400,
                  child: Center(
                    child: Column(
                      children: [
                        Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: emailController,
                                  // initialValue: depence.id!= null? "${depence.libele}":"",
                                  decoration:
                                      const InputDecoration(labelText: 'Email'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Veuillez entrer votre email';
                                    } else if (!isValidEmail(value)) {
                                      return 'L\'adresse e-mail est valide.';
                                    } else if (emailStatus.isNotEmpty) {
                                      return emailStatus;
                                    }
                                    return null;
                                  },

                                  onSaved: (value) =>
                                      utilisateurModel.email = value!,
                                ),
                                TextFormField(
                                  controller: nomController,
                                  // initialValue: depence.id!= null? "${depence.libele}":"",
                                  decoration:
                                      const InputDecoration(labelText: 'Nom'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Veuillez entrer votre Nom,';
                                    } else if (nomStatus.isNotEmpty) {
                                      return 'ooooo';
                                    }
                                    return null;
                                  },

                                  onSaved: (value) =>
                                      utilisateurModel.nom = value!,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                  width: 100,
                                ),
                                TextFormField(
                                  controller: prenomController,
                                  // initialValue: depence.id!= null? "${depence.libele}":"",
                                  decoration: const InputDecoration(
                                      labelText: 'Prenom'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Veuillez entrer votre prenom';
                                    } else if (prenomStatus.isNotEmpty) {
                                      return prenomStatus;
                                    }
                                    return null;
                                  },

                                  onSaved: (value) =>
                                      utilisateurModel.prenom = value!,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                  width: 100,
                                ),
                                TextFormField(
                                  controller: numeroController,
                                  // initialValue: depence.id!= null? "${depence.libele}":"",
                                  decoration: const InputDecoration(
                                      labelText: 'numero'),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(12,
                                        maxLengthEnforcement:
                                            MaxLengthEnforcement
                                                .truncateAfterCompositionEnds),
                                    FilteringTextInputFormatter.digitsOnly
                                    // ne permet que la saisie de chiffres
                                  ],
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Veuillez entrer votre numero';
                                    } else if (value.length < 9) {
                                      return 'Un nu;ero doit avoir 9 chiffres au minimum';
                                    } else if (numeroStatus.isNotEmpty) {
                                      return numeroStatus;
                                    }
                                    return null;
                                  },
                                  onSaved: (value) => utilisateurModel
                                      .numero_telephone = value!,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                  width: 100,
                                ),
                                TextFormField(
                                  controller: datenaissaceController,
                                  // initialValue: depence.id!= null? "${depence.libele}":"",
                                  decoration: const InputDecoration(
                                      labelText: 'Date de naissance'),
                                  readOnly: true,
                                  onTap: () async {
                                    datenaissaceController.text =
                                        await _selectDate(context);
                                  },
                                  enabled: true,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Veuillez entrer votre date de naissance';
                                    } else if (datenaissanceStatus.isNotEmpty) {
                                      return datenaissanceStatus;
                                    }
                                    return null;
                                  },
                                  onSaved: (value) =>
                                      utilisateurModel.date_naissance = value!,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                  width: 100,
                                ),
                                TextFormField(
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      labelText: 'mot de passe'),
                                  // initialValue: depence.id!= null? "${depence.price}":"",
                                  controller: passwordController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Veuillez entrer votre mot de passe';
                                    } else if (value.length < 6) {
                                      return 'Le mot de passe doit avoir au moins 6 carracteres';
                                    } else if (passwordStatus.isNotEmpty) {
                                      return passwordStatus;
                                    }
                                    return null;
                                  },
                                  onSaved: (value) =>
                                      utilisateurModel.mot_de_passe = value!,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                  width: 25,
                                ),
                                TextFormField(
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      labelText: 'confirmation'),
                                  // initialValue: depence.id!= null? "${depence.price}":"",
                                  controller: confirmController,
                                  validator: (value) {
                                    utilisateurModel.mot_de_passe =
                                        passwordController.text ?? '';
                                    if (value!.isEmpty) {
                                      return 'Veuillez confirmer votre mot de passe';
                                    } else if (value.length < 6) {
                                      return 'Le mot de passe doit avoir au moins 6 carracteres';
                                    } else if (value.compareTo(
                                            utilisateurModel.mot_de_passe) !=
                                        0) {
                                      return 'Le mot de passe et sa confirmation sont differents';
                                    } else if (passwordconfirmStatus
                                        .isNotEmpty) {
                                      return passwordconfirmStatus;
                                    }
                                    return null;
                                  },
                                  onSaved: (value) => password = value!,
                                ),
                                const SizedBox(
                                  height: 10.0,
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
                                    /*Expanded(
                                      child: Center(
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Scaffold()));
                                            },
                                            child:
                                                const Text('S\'enregistrer')),
                                      ),
                                    )*/
                                  ],
                                )
                              ],
                            ))
                      ],
                    ),
                  )),
            ),
          ],
        ));
  }

  Future<String> _selectDate(BuildContext context) async {
    DateTime? selectedDate = DateTime.now();
    try {
      selectedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate!,
          firstDate: DateTime(1900),
          lastDate: DateTime(2100));
      if (selectedDate != null) {
        return selectedDate.toString();
      }
    } catch (e) {}
    return '';
  }
}
