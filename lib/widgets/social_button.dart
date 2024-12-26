// Importation de la palette de couleurs personnalisées.
import 'package:daily_journal/utils/pallete.dart';
// Importation de Flutter pour construire l'interface utilisateur.
import 'package:flutter/material.dart';
// Importation de Flutter SVG pour afficher des fichiers SVG.
import 'package:flutter_svg/flutter_svg.dart';

// Déclaration d'un widget Stateless pour un bouton social.
class SocialButton extends StatelessWidget {
  // Chemin de l'icône SVG utilisée dans le bouton.
  final String iconpath;

  // Libellé affiché à côté de l'icône.
  final String lable;

  // Constructeur pour initialiser les propriétés du bouton social.
  const SocialButton({
    super.key, // Clé optionnelle pour identifier le widget.
    required this.iconpath, // Chemin de l'icône SVG obligatoire.
    required this.lable, // Libellé du bouton obligatoire.
  });

  // Méthode principale pour construire l'interface utilisateur.
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      // Action exécutée lorsqu'on clique sur le bouton.
      onPressed: () {}, // Action par défaut (vide).

      // Icône affichée dans le bouton (SVG).
      icon: SvgPicture.asset(
        iconpath, // Chemin de l'icône SVG.
        width: 25, // Largeur de l'icône.
        color: Pallete.gradient2, // Couleur appliquée à l'icône.
      ),

      // Libellé affiché à côté de l'icône.
      label: Text(
        lable, // Texte du libellé.
        style: const TextStyle(
          color: Pallete.gradient3, // Couleur du texte.
          fontSize: 17, // Taille de la police.
        ),
      ),

      // Style du bouton.
      style: TextButton.styleFrom(
        // Espacement interne du bouton.
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 100),
        // Forme du bouton avec des bordures arrondies.
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Coins arrondis.
          // Bordure externe avec une couleur personnalisée.
          side: const BorderSide(
            color: Pallete.borderColor, // Couleur de la bordure.
            width: 2, // Épaisseur de la bordure.
          ),
        ),
      ),
    );
  }
}
