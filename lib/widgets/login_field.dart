// Importation des écrans nécessaires.
import 'package:daily_journal/screens/home_screen.dart'; // Écran principal après connexion.
import 'package:daily_journal/screens/signup_screen.dart'; // Écran pour s'inscrire.
// Importation des méthodes Firebase pour l'authentification.
import 'package:daily_journal/services/firebase_auth_methods.dart';
// Importation de la palette de couleurs personnalisées.
import 'package:daily_journal/utils/pallete.dart';
// Importation des widgets personnalisés.
import 'package:daily_journal/widgets/custom_button.dart'; // Bouton personnalisé.
import 'package:daily_journal/widgets/login_field.dart'; // Champ de saisie personnalisé.
// Importation de Firebase Auth pour gérer l'authentification.
import 'package:firebase_auth/firebase_auth.dart';
// Importation de Flutter pour construire l'interface utilisateur.
import 'package:flutter/material.dart';

/// Écran permettant aux utilisateurs de se connecter à leur compte.
class LoginScreen extends StatelessWidget {
  /// Constructeur pour créer une instance de [LoginScreen].
  LoginScreen({super.key});

  /// Contrôleur pour le champ de saisie de l'email.
  final TextEditingController emailController = TextEditingController();

  /// Contrôleur pour le champ de saisie du mot de passe.
  final TextEditingController passwordController = TextEditingController();

  /// Méthode pour libérer les ressources des contrôleurs lorsque le widget est supprimé.
  void dipose() {
    emailController.dispose();
    passwordController.dispose();
  }

  /// Méthode pour connecter un utilisateur avec l'email et le mot de passe fournis.
  ///
  /// Affiche un écran d'accueil ([HomeScreen]) si la connexion réussit.
  void loginUser(BuildContext context) async {
    // Appelle la méthode pour se connecter avec Firebase Auth.
    String res =
        await FirebaseAuthMethods(FirebaseAuth.instance).signInWithEmail(
            email: emailController.text, // Email saisi.
            password: passwordController.text, // Mot de passe saisi.
            context: context);

    // Si la connexion réussit et que le contexte est valide.
    if (res == "success" && context.mounted) {
      // Navigation vers l'écran principal et suppression de l'historique de navigation.
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false);
    }
  }

  /// Méthode principale pour construire l'interface utilisateur.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Corps principal de l'écran.
      body: SingleChildScrollView(
        // Ajoute un padding horizontal pour centrer le contenu.
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          // Définit la hauteur du conteneur égale à la hauteur de l'écran.
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              children: [
                const Spacer(), // Ajoute un espace flexible avant le contenu.
                // Titre principal.
                const Text(
                  "Sign in", // Texte affiché.
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // Texte en gras.
                    fontSize: 40, // Taille du texte.
                    color: Pallete.dark, // Couleur du texte.
                  ),
                ),
                const SizedBox(height: 64), // Espacement vertical.
                // Champ de saisie pour l'email.
                LoginField(
                  hintText: 'Enter your Email', // Texte indicatif.
                  labelText: 'Email', // Étiquette.
                  controller: emailController, // Contrôleur associé.
                ),
                const SizedBox(height: 16), // Espacement vertical.
                // Champ de saisie pour le mot de passe.
                LoginField(
                  hintText: 'Enter your Password', // Texte indicatif.
                  labelText: 'Password', // Étiquette.
                  controller: passwordController, // Contrôleur associé.
                  isObscured: true, // Masque le texte pour le mot de passe.
                ),
                const SizedBox(height: 32), // Espacement vertical.
                // Bouton pour se connecter.
                CustomButton(
                  height: 50, // Hauteur du bouton.
                  text: 'Sign in', // Texte du bouton.
                  onPressed: () {
                    // Appelle la méthode pour se connecter.
                    loginUser(context);
                  },
                ),
                const SizedBox(height: 16), // Espacement vertical.
                // Lien pour aller vers l'écran d'inscription.
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      // Navigation vers l'écran d'inscription.
                      MaterialPageRoute(
                        builder: ((context) => SignupScreen()),
                      ),
                    );
                  },
                  child: const Text(
                    "New Here? Sign Up!", // Texte affiché.
                    style:
                        TextStyle(color: Pallete.darkHint), // Style du texte.
                  ),
                ),
                const Spacer(), // Ajoute un espace flexible après le contenu.
              ],
            ),
          ),
        ),
      ),
    );
  }
}
