// Importation de Firestore pour gérer les bases de données.
import 'package:cloud_firestore/cloud_firestore.dart';
// Importation de Firebase Auth pour l'authentification des utilisateurs.
import 'package:firebase_auth/firebase_auth.dart';
// Importation de Flutter pour le contexte de l'application.
import 'package:flutter/cupertino.dart';
// Importation de l'utilitaire pour afficher des notifications (Snackbar).
import 'package:daily_journal/utils/showSnackBar.dart';

// Classe CrudMethods pour gérer les opérations CRUD sur Firestore.
class CrudMethods {
  // Instance de Firestore pour interagir avec la base de données.
  final FirebaseFirestore _instance;

  // Récupère l'utilisateur actuellement connecté via Firebase Authentication.
  final currentUser = FirebaseAuth.instance.currentUser;

  // Récupère la date et l'heure actuelles.
  DateTime today = DateTime.now();

  // Constructeur pour initialiser la classe avec une instance de Firestore.
  CrudMethods(this._instance);

  // Méthode pour ajouter des données dans Firestore.
  Future<void> addData({
    required String title, // Titre de l'entrée.
    required String data, // Texte de l'entrée.
    required BuildContext context, // Contexte pour afficher des notifications.
    DateTime? startDate, // Date de début (facultative).
    DateTime? endDate, // Date de fin (facultative).
  }) async {
    try {
      // Vérifie si l'utilisateur est connecté.
      if (currentUser == null) {
        showSnackBar(
            context, "User is not logged in"); // Affiche un message d'erreur.
        return; // Arrête l'exécution.
      }

      // Ajoute une nouvelle entrée dans la collection "journals" de l'utilisateur.
      await _instance
          .collection("Users") // Collection principale "Users".
          .doc(
              currentUser!.email) // Document basé sur l'email de l'utilisateur.
          .collection("journals") // Sous-collection "journals".
          .add({
        'title': title, // Titre de l'entrée.
        'text': data, // Contenu de l'entrée.
        'date':
            "${today.day}-${today.month}-${today.year}", // Date actuelle formatée.
        'time': "${today.hour}:${today.minute}", // Heure actuelle formatée.
        'startDate':
            startDate?.toIso8601String(), // Date de début en format ISO.
        'endDate': endDate?.toIso8601String(), // Date de fin en format ISO.
      });

      // Affiche un message de succès.
      showSnackBar(context, "Entry saved successfully!");
    } on FirebaseAuthException catch (e) {
      // En cas d'erreur d'authentification, affiche un message d'erreur.
      showSnackBar(
          context, e.message ?? "An error occurred during authentication");
    } catch (e) {
      // En cas d'erreur générale, affiche un message d'erreur.
      showSnackBar(context, e.toString());
    }
  }

  // Méthode pour récupérer les données depuis Firestore.
  Future<QuerySnapshot> getData() async {
    // Vérifie si l'utilisateur est connecté.
    if (currentUser == null) {
      throw Exception(
          "User is not logged in"); // Lève une exception si non connecté.
    }

    // Récupère toutes les entrées de la sous-collection "journals" de l'utilisateur.
    return await _instance
        .collection(
            "Users/${currentUser!.email}/journals") // Chemin vers la sous-collection.
        .get(); // Récupère les documents.
  }

  // Méthode pour supprimer une entrée spécifique.
  Future<void> delete({required String docId}) async {
    // Vérifie si l'utilisateur est connecté.
    if (currentUser == null) {
      throw Exception(
          "User is not logged in"); // Lève une exception si non connecté.
    }

    // Supprime un document spécifique basé sur son ID.
    await _instance
        .collection(
            "Users/${currentUser!.email}/journals") // Chemin vers la sous-collection.
        .doc(docId) // Document basé sur l'ID.
        .delete(); // Supprime le document.
  }
}
