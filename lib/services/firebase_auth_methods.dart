// Importation de Firestore pour gérer les bases de données.
import 'package:cloud_firestore/cloud_firestore.dart';
// Importation de Firebase Auth pour l'authentification des utilisateurs.
import 'package:firebase_auth/firebase_auth.dart';
// Importation de Flutter pour la construction de l'interface utilisateur.
import 'package:flutter/material.dart';
// Importation d'un utilitaire pour afficher des notifications (Snackbar).
import '../utils/showSnackBar.dart';

// Déclaration de la classe FirebaseAuthMethods qui étend ChangeNotifier pour la gestion des états.
class FirebaseAuthMethods extends ChangeNotifier {
  // Instance de FirebaseAuth utilisée pour les opérations d'authentification.
  final FirebaseAuth _auth;

  // Constructeur pour initialiser FirebaseAuthMethods avec une instance de FirebaseAuth.
  FirebaseAuthMethods(this._auth);

  // Getter pour l'état d'authentification (stream d'utilisateur Firebase).
  Stream<User?> get authState => _auth.authStateChanges();

  // Méthode pour inscrire un utilisateur avec un email, un mot de passe et un nom complet.
  Future<String> signUpWithEmail({
    required String email, // Email de l'utilisateur.
    required String password, // Mot de passe de l'utilisateur.
    required String fullName, // Nom complet de l'utilisateur.
    required BuildContext context, // Contexte pour afficher des messages.
  }) async {
    try {
      // Création d'un utilisateur avec email et mot de passe.
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email, // Email pour l'inscription.
        password: password, // Mot de passe pour l'inscription.
      );

      // Ajout de l'utilisateur dans la collection Firestore "users".
      await FirebaseFirestore.instance
          .collection('users') // Collection "users" dans Firestore.
          .doc(userCredential
              .user!.uid) // Document basé sur l'UID de l'utilisateur.
          .set({
        'fullName': fullName, // Enregistre le nom complet de l'utilisateur.
        'email': email, // Enregistre l'email.
        'createdAt': DateTime.now(), // Enregistre la date de création.
      });

      return "success"; // Retourne "success" si tout fonctionne bien.
    } on FirebaseAuthException catch (e) {
      // En cas d'erreur, affiche un message dans une Snackbar.
      showSnackBar(context, e.message ?? "An error occurred");
      return e.message!; // Retourne le message d'erreur.
    }
  }

  // Méthode pour connecter un utilisateur avec email et mot de passe.
  Future<String> signInWithEmail({
    required String email, // Email de l'utilisateur.
    required String password, // Mot de passe de l'utilisateur.
    required BuildContext context, // Contexte pour afficher des messages.
  }) async {
    try {
      // Connexion de l'utilisateur avec email et mot de passe.
      await _auth.signInWithEmailAndPassword(
        email: email, // Email pour la connexion.
        password: password, // Mot de passe pour la connexion.
      );
      return "success"; // Retourne "success" si la connexion réussit.
    } on FirebaseAuthException catch (e) {
      // En cas d'erreur, affiche un message dans une Snackbar.
      showSnackBar(context, e.message ?? "An error occurred");
      return e.message!; // Retourne le message d'erreur.
    }
  }

  // Méthode pour déconnecter l'utilisateur actuel.
  Future<void> signOut(BuildContext context) async {
    await _auth.signOut(); // Déconnecte l'utilisateur de Firebase.
    showSnackBar(context,
        "Signed out successfully"); // Affiche un message de confirmation.
    notifyListeners(); // Notifie les widgets écoutant ce ChangeNotifier.
  }
}
