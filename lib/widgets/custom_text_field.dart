// Importation de Flutter pour construire l'interface utilisateur.
import 'package:flutter/material.dart';

// Importation de la palette de couleurs personnalisées.
import '../utils/pallete.dart';

// Déclaration d'un widget Stateless pour un champ de texte personnalisé.
class CustomTextField extends StatelessWidget {
  // Contrôleur pour gérer le contenu du champ de texte.
  final TextEditingController controller;

  // Texte indicatif affiché dans le champ de texte.
  final String hintText;

  // Nombre maximum de lignes dans le champ de texte.
  final int maxLines;

  // Constructeur pour initialiser les propriétés du widget.
  const CustomTextField({
    super.key, // Clé optionnelle pour identifier le widget.
    required this.controller, // Contrôleur obligatoire.
    required this.hintText, // Texte indicatif obligatoire.
    required this.maxLines, // Nombre de lignes maximum obligatoire.
  });

  // Méthode principale pour construire l'interface utilisateur.
  @override
  Widget build(BuildContext context) {
    return TextField(
      // Définit le nombre maximum de lignes.
      maxLines: maxLines,
      // Associe le contrôleur au champ de texte.
      controller: controller,
      // Définit l'apparence et le comportement du champ de texte.
      decoration: InputDecoration(
        // Définit le texte indicatif affiché dans le champ.
        hintText: hintText,
        // Bordure lorsque le champ est activé (non sélectionné).
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20), // Coins arrondis.
          borderSide: const BorderSide(
            color: Pallete.borderColor, // Couleur de la bordure.
            width: 2, // Épaisseur de la bordure.
          ),
        ),
        // Bordure lorsque le champ est sélectionné (focus).
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20), // Coins arrondis.
          borderSide: const BorderSide(
            color: Pallete.gradient2, // Couleur de la bordure.
            width: 2, // Épaisseur de la bordure.
          ),
        ),
      ),
    );
  }
}
