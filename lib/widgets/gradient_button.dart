// Importation de la palette de couleurs personnalisées.
import 'package:daily_journal/utils/pallete.dart';
// Importation de Flutter pour construire l'interface utilisateur.
import 'package:flutter/material.dart';

// Déclaration d'un widget Stateless pour un bouton avec un dégradé.
class GradientButton extends StatelessWidget {
  // Fonction callback appelée lorsqu'on appuie sur le bouton.
  final VoidCallback onPressed;

  // Texte affiché dans le bouton.
  final String text;

  // Largeur et hauteur du bouton, avec des valeurs par défaut.
  final double width, height;

  // Constructeur pour initialiser les propriétés du widget.
  const GradientButton({
    super.key, // Clé optionnelle pour identifier le widget.
    required this.onPressed, // Fonction obligatoire à exécuter au clic.
    required this.text, // Texte obligatoire affiché dans le bouton.
    this.width = 300, // Largeur par défaut.
    this.height = 70, // Hauteur par défaut.
  });

  // Méthode principale pour construire l'interface utilisateur.
  @override
  Widget build(BuildContext context) {
    return Container(
      // Décoration du conteneur.
      decoration: BoxDecoration(
        // Applique un dégradé au fond du conteneur.
        gradient: const LinearGradient(
          colors: [
            Pallete.gradient1, // Première couleur du dégradé.
            Pallete.gradient2, // Deuxième couleur du dégradé.
          ],
        ),
        // Coins arrondis pour le bouton.
        borderRadius: BorderRadius.circular(10),
      ),
      // Bouton surélevé avec un style transparent.
      child: ElevatedButton(
        // Action exécutée lorsqu'on appuie sur le bouton.
        onPressed: onPressed,
        // Style du bouton.
        style: ElevatedButton.styleFrom(
          // Taille maximale du bouton.
          maximumSize: Size(width, height),
          // Couleur d'arrière-plan transparente (prise en charge du dégradé).
          backgroundColor: Colors.transparent,
          // Supprime l'ombre par défaut du bouton.
          shadowColor: Colors.transparent,
        ),
        // Texte affiché dans le bouton.
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w600, // Texte semi-gras.
            fontSize: 17, // Taille de la police.
          ),
        ),
      ),
    );
  }
}
