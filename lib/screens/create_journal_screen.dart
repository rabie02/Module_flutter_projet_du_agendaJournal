// Importation de la bibliothèque Firestore pour gérer la base de données cloud.
import 'package:cloud_firestore/cloud_firestore.dart';
// Importation des méthodes CRUD personnalisées pour Firestore.
import 'package:daily_journal/services/firestore_crud_methods.dart';
// Importation du package Flutter pour créer des interfaces utilisateur.
import 'package:flutter/material.dart';
// Importation de la bibliothèque Intl pour le formatage des dates.
import 'package:intl/intl.dart';
// Importation d'une palette de couleurs personnalisée.
import '../utils/pallete.dart';

// Déclaration de la classe CreateJournal qui est un widget d'état (stateful widget).
class CreateJournal extends StatefulWidget {
  // Constructeur par défaut de CreateJournal.
  const CreateJournal({super.key});

  // Méthode pour créer l'état associé à ce widget.
  @override
  _CreateJournalState createState() => _CreateJournalState();
}

// Déclaration de la classe _CreateJournalState, l'état de CreateJournal.
class _CreateJournalState extends State<CreateJournal> {
  // Contrôleur de texte pour le champ du titre.
  final TextEditingController titleController = TextEditingController();
  // Contrôleur de texte pour le champ de la description.
  final TextEditingController dataController = TextEditingController();
  // Variable pour stocker la date de début sélectionnée.
  DateTime? _startDate;
  // Variable pour stocker la date de fin sélectionnée.
  DateTime? _endDate;

  // Format de la date pour l'affichage.
  final DateFormat _dateFormat = DateFormat('dd-MM-yyyy');

  // Fonction asynchrone pour afficher un sélecteur de date (calendrier).
  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    // Récupère la date actuelle.
    DateTime currentDate = DateTime.now();
    // Définit la date initiale du sélecteur (date de début ou de fin).
    DateTime initialDate =
        isStartDate ? _startDate ?? currentDate : _endDate ?? currentDate;

    // Affiche le sélecteur de date.
    DateTime? selectedDate = await showDatePicker(
      context: context, // Contexte de l'application.
      initialDate: initialDate, // Date initialement sélectionnée.
      firstDate: DateTime(2020), // Première date possible.
      lastDate: DateTime(2101), // Dernière date possible.
    );

    // Si une date est sélectionnée, elle est mise à jour dans l'état.
    if (selectedDate != null) {
      setState(() {
        // Mise à jour de la date de début ou de fin.
        if (isStartDate) {
          _startDate = selectedDate;
        } else {
          _endDate = selectedDate;
        }
      });
    }
  }

  // Fonction pour envoyer les données à Firestore.
  void uploadData(String title, String data, BuildContext context) async {
    // Appelle la méthode pour ajouter des données dans Firestore.
    await CrudMethods(FirebaseFirestore.instance)
        .addData(
          title: title, // Titre du journal.
          data: data, // Contenu du journal.
          context: context, // Contexte de l'application.
          startDate: _startDate, // Date de début.
          endDate: _endDate, // Date de fin.
        )
        .then(
            (result) => Navigator.pop(context)); // Ferme l'écran après l'ajout.
  }

  // Méthode pour construire l'interface utilisateur.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barre d'application avec un titre et une icône d'envoi.
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A90E2), // Couleur de fond.
        title: const Text("New Entry"), // Titre de l'écran.
        actions: [
          // Icône de téléchargement avec un gestionnaire d'événements.
          GestureDetector(
            onTap: () {
              // Appelle la méthode pour envoyer les données.
              uploadData(titleController.text, dataController.text, context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16), // Espacement horizontal.
              child: const Icon(Icons.file_upload), // Icône d'envoi.
            ),
          ),
        ],
      ),
      // Corps principal de l'écran.
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16), // Espacement interne.
          color: const Color(0xFFF4F9FC), // Couleur de fond.
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20), // Espacement vertical.

              // Champ de texte pour le titre.
              TextField(
                controller:
                    titleController, // Contrôleur pour récupérer la valeur.
                decoration: InputDecoration(
                  labelText: "Title", // Étiquette du champ.
                  labelStyle: const TextStyle(
                      color: Color(0xFF4A90E2)), // Style de l'étiquette.
                  filled: true, // Fond rempli.
                  fillColor: Colors.white, // Couleur de fond.
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color(0xFF4A90E2)), // Bordure non focus.
                    borderRadius: BorderRadius.circular(15), // Rayon des coins.
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color(0xFF4A90E2)), // Bordure focus.
                    borderRadius: BorderRadius.circular(15), // Rayon des coins.
                  ),
                ),
              ),
              const SizedBox(height: 20), // Espacement vertical.

              // Champ de texte pour la description.
              TextField(
                controller:
                    dataController, // Contrôleur pour récupérer la valeur.
                maxLines: 10, // Nombre de lignes visibles.
                decoration: InputDecoration(
                  labelText: "Description", // Étiquette du champ.
                  labelStyle: const TextStyle(
                      color: Color(0xFF4A90E2)), // Style de l'étiquette.
                  filled: true, // Fond rempli.
                  fillColor: Colors.white, // Couleur de fond.
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color(0xFF4A90E2)), // Bordure non focus.
                    borderRadius: BorderRadius.circular(15), // Rayon des coins.
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color(0xFF4A90E2)), // Bordure focus.
                    borderRadius: BorderRadius.circular(15), // Rayon des coins.
                  ),
                ),
              ),
              const SizedBox(height: 20), // Espacement vertical.

              // Sélecteur de date de début.
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () =>
                          _selectDate(context, true), // Ouvre le calendrier.
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Start Date', // Étiquette du champ.
                          labelStyle: const TextStyle(
                              color:
                                  Color(0xFF4A90E2)), // Style de l'étiquette.
                          filled: true, // Fond rempli.
                          fillColor: Colors.white, // Couleur de fond.
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFF4A90E2)), // Bordure.
                            borderRadius:
                                BorderRadius.circular(15), // Rayon des coins.
                          ),
                        ),
                        child: Text(
                          _startDate !=
                                  null // Vérifie si une date est sélectionnée.
                              ? _dateFormat
                                  .format(_startDate!) // Formate la date.
                              : 'Select Date', // Texte par défaut.
                          style: const TextStyle(
                              color: Colors.black), // Style du texte.
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20), // Espacement vertical.

              // Sélecteur de date de fin.
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () =>
                          _selectDate(context, false), // Ouvre le calendrier.
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'End Date', // Étiquette du champ.
                          labelStyle: const TextStyle(
                              color:
                                  Color(0xFF4A90E2)), // Style de l'étiquette.
                          filled: true, // Fond rempli.
                          fillColor: Colors.white, // Couleur de fond.
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFF4A90E2)), // Bordure.
                            borderRadius:
                                BorderRadius.circular(15), // Rayon des coins.
                          ),
                        ),
                        child: Text(
                          _endDate !=
                                  null // Vérifie si une date est sélectionnée.
                              ? _dateFormat
                                  .format(_endDate!) // Formate la date.
                              : 'Select Date', // Texte par défaut.
                          style: const TextStyle(
                              color: Colors.black), // Style du texte.
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40), // Espacement vertical.

              // Bouton pour sauvegarder l'entrée.
              ElevatedButton(
                onPressed: () => uploadData(titleController.text,
                    dataController.text, context), // Envoie les données.
                child: const Text('Save Entry'), // Texte du bouton.
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6F00), // Couleur de fond.
                  padding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 40), // Espacement interne.
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Rayon des coins.
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
