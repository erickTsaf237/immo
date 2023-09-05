import 'package:flutter/cupertino.dart';

bool isValidEmail(String email) {
  // Expression régulière pour valider le format de l'adresse e-mail
  // Ceci est une expression régulière simple et ne garantit pas une validation complète de l'adresse e-mail
  // Elle vérifie simplement que l'e-mail a un format général valide.
  // Pour une validation plus approfondie, vous pouvez utiliser des packages comme 'email_validator'
  final emailRegex =
      r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';

  final regex = RegExp(emailRegex);
  return regex.hasMatch(email);
}

colorFromAsciiCode(String lettre){
  int asciiCode = '${lettre.toUpperCase()}1'.codeUnitAt(0);
  final red = (asciiCode * 3) % 256;
  final green = (asciiCode * 5) % 256;
  final blue = (asciiCode * 7) % 256;

  return Color.fromARGB(255, red, green, blue);
}

colorFromAsciiCode2(String lettre){
  int asciiCode = '${lettre.toUpperCase()}1'.codeUnitAt(0);
  final red = (asciiCode * 3) % 256;
  final green = (asciiCode * 5) % 256;
  final blue = (asciiCode * 7) % 256;

  return Color.fromARGB(105, red, green, blue);
}