// Importation de la bibliothèque Firestore pour gérer les données dans Firestore.
import 'package:cloud_firestore/cloud_firestore.dart';
// Importation des méthodes CRUD personnalisées pour Firestore.
import 'package:daily_journal/services/firestore_crud_methods.dart';
// Importation de Flutter pour créer l'interface utilisateur.
import 'package:flutter/material.dart';
// Importation des utilitaires pour la palette de couleurs personnalisées.
import '../utils/pallete.dart';

// Déclaration d'un widget Stateless pour afficher les détails d'un journal.
class DisplayJournal extends StatelessWidget {
  // Document Firestore passé en paramètre pour afficher ses détails.
  final QueryDocumentSnapshot<Object?> data;

  // Constructeur pour initialiser le widget avec le document Firestore.
  const DisplayJournal({super.key, required this.data});

  // Méthode principale pour construire l'interface utilisateur.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barre d'application (AppBar) en haut de l'écran.
      appBar: AppBar(
        backgroundColor: Pallete.gradient1, // Couleur de fond de la barre.
        title: Text(
          data['title'], // Affiche le titre du journal.
          style: const TextStyle(color: Colors.white), // Style du texte.
        ),
        centerTitle: true, // Centre le titre dans la barre.
        actions: [
          // Bouton d'icône pour supprimer l'entrée.
          IconButton(
            icon: const Icon(Icons.delete), // Icône de suppression.
            onPressed: () {
              // Affiche une boîte de dialogue de confirmation.
              showDialog(
                context: context, // Contexte de l'application.
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Delete"), // Titre de la boîte.
                    content: const Text(
                        "Do you really want to delete this entry?"), // Message de confirmation.
                    actions: [
                      // Bouton pour annuler la suppression.
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Ferme la boîte de dialogue.
                        },
                        child: const Text("Cancel"), // Texte du bouton.
                      ),
                      // Bouton pour confirmer la suppression.
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Ferme la boîte de dialogue.
                          CrudMethods(FirebaseFirestore.instance)
                              .delete(docId: data.id); // Supprime l'entrée.
                          Navigator.pop(
                              context); // Retourne à l'écran précédent.
                        },
                        child: const Text("Continue"), // Texte du bouton.
                      ),
                    ],
                  );
                },
              );
            },
          ),
          const SizedBox(width: 20), // Espacement après l'icône.
        ],
      ),
      // Corps principal de l'écran.
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20), // Espacement vertical.
              // Texte pour afficher la date de début.
              Text(
                "Start Date: ${_formatDate(data['startDate'])}", // Formate et affiche la date.
                style: const TextStyle(
                  color: Color(0xFF4A90E2), // Couleur du texte.
                  fontSize: 16, // Taille de la police.
                  fontWeight: FontWeight.bold, // Texte en gras.
                ),
              ),
              const SizedBox(height: 10), // Espacement vertical.
              // Texte pour afficher la date de fin.
              Text(
                "End Date: ${_formatDate(data['endDate'])}", // Formate et affiche la date.
                style: const TextStyle(
                  color: Color(0xFF4A90E2), // Couleur du texte.
                  fontSize: 16, // Taille de la police.
                  fontWeight: FontWeight.bold, // Texte en gras.
                ),
              ),
              const SizedBox(height: 20), // Espacement vertical.
              // Conteneur pour afficher le contenu du journal.
              Container(
                width: MediaQuery.of(context).size.width -
                    50, // Largeur relative à l'écran.
                padding: const EdgeInsets.all(20), // Espacement interne.
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F9FC), // Couleur de fond.
                  borderRadius: BorderRadius.circular(20), // Coins arrondis.
                  border: Border.all(
                      color: const Color(0xFF4A90E2),
                      width: 2), // Bordure avec couleur et épaisseur.
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical, // Défilement vertical.
                  child: Text(
                    data['text'], // Affiche le texte du journal.
                    style: const TextStyle(
                      color: Color(0xFF4A90E2), // Couleur du texte.
                      fontSize: 18, // Taille de la police.
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Espacement vertical.
            ],
          ),
        ),
      ),
    );
  }

  // Méthode pour formater les dates.
  String _formatDate(dynamic date) {
    if (date == null)
      return "Not set"; // Retourne "Not set" si la date est nulle.
    DateTime parsedDate =
        DateTime.parse(date); // Convertit la date en objet DateTime.
    return "${parsedDate.day}-${parsedDate.month}-${parsedDate.year}"; // Retourne la date formatée.
  }
}
