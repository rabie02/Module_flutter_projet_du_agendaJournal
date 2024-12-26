// Importation de Flutter pour créer l'interface utilisateur.
import 'package:flutter/material.dart';
// Importation de Provider pour la gestion des états.
import 'package:provider/provider.dart';
// Importation des méthodes personnalisées pour Firebase Authentication.
import '../services/firebase_auth_methods.dart';
// Importation de l'utilitaire pour afficher des notifications (Snackbar).
import '../utils/showSnackBar.dart';
// Importation de l'écran principal (HomeScreen).
import 'home_screen.dart';
// Importation de l'écran d'inscription (SignupScreen).
import 'signup_screen.dart';

// Déclaration du widget Stateful pour l'écran de connexion.
class LoginScreen extends StatefulWidget {
  // Constructeur par défaut.
  const LoginScreen({Key? key}) : super(key: key);

  // Création de l'état pour LoginScreen.
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

// Classe pour gérer l'état de LoginScreen.
class _LoginScreenState extends State<LoginScreen> {
  // Contrôleur pour le champ de l'email.
  final TextEditingController emailController = TextEditingController();
  // Contrôleur pour le champ du mot de passe.
  final TextEditingController passwordController = TextEditingController();
  // Variable pour gérer la visibilité du mot de passe.
  bool isPasswordVisible = false;

  // Fonction pour basculer la visibilité du mot de passe.
  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible; // Inverse la visibilité.
    });
  }

  // Fonction pour connecter un utilisateur via Firebase Authentication.
  void logInUser() async {
    // Appelle la méthode d'authentification avec l'email et le mot de passe.
    String res = await context.read<FirebaseAuthMethods>().signInWithEmail(
          email: emailController.text, // Récupère l'email.
          password: passwordController.text, // Récupère le mot de passe.
          context: context, // Contexte pour afficher des notifications.
        );

    // Si la connexion réussit, redirige vers l'écran principal.
    if (res == "success") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      // Affiche un message d'erreur sinon.
      showSnackBar(context, res);
    }
  }

  // Méthode principale pour construire l'interface utilisateur.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Structure principale en pile (Stack).
      body: Stack(
        children: [
          // Fond en dégradé pour l'écran.
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF4A90E2),
                  Color(0xFF50E3C2)
                ], // Couleurs du dégradé.
                begin: Alignment.topLeft, // Début du dégradé.
                end: Alignment.bottomRight, // Fin du dégradé.
              ),
            ),
          ),
          // Contenu principal centré.
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0), // Marges latérales.
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Centre le contenu.
                  children: [
                    // Logo de l'application.
                    Image.asset('assets/images/logo.png', height: 100),
                    const SizedBox(height: 20), // Espacement vertical.
                    // Message de bienvenue.
                    const Text(
                      "Welcome Back!", // Texte du message.
                      style: TextStyle(
                        fontSize: 36, // Taille de la police.
                        fontWeight: FontWeight.bold, // Texte en gras.
                        color: Colors.white, // Couleur du texte.
                      ),
                    ),
                    const SizedBox(height: 40), // Espacement vertical.
                    // Champ pour l'email.
                    Container(
                      width: 260, // Largeur du champ.
                      child: TextField(
                        controller: emailController, // Contrôleur de texte.
                        decoration: InputDecoration(
                          filled: true, // Fond rempli.
                          fillColor: Colors.white, // Couleur de fond.
                          labelText: 'Email', // Étiquette.
                          prefixIcon: const Icon(Icons.email_outlined,
                              size: 20), // Icône.
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(12), // Coins arrondis.
                          ),
                        ),
                        style:
                            const TextStyle(fontSize: 16), // Taille du texte.
                      ),
                    ),
                    const SizedBox(height: 20), // Espacement vertical.
                    // Champ pour le mot de passe.
                    Container(
                      width: 260, // Largeur du champ.
                      child: TextField(
                        controller: passwordController, // Contrôleur de texte.
                        decoration: InputDecoration(
                          filled: true, // Fond rempli.
                          fillColor: Colors.white, // Couleur de fond.
                          labelText: 'Password', // Étiquette.
                          prefixIcon: const Icon(Icons.lock_outline,
                              size: 20), // Icône.
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordVisible
                                  ? Icons.visibility // Icône visible.
                                  : Icons.visibility_off, // Icône non visible.
                              size: 20,
                            ),
                            onPressed:
                                togglePasswordVisibility, // Appelle la fonction pour basculer.
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(12), // Coins arrondis.
                          ),
                        ),
                        obscureText:
                            !isPasswordVisible, // Masque ou affiche le texte.
                        style:
                            const TextStyle(fontSize: 16), // Taille du texte.
                      ),
                    ),
                    const SizedBox(height: 30), // Espacement vertical.
                    // Bouton pour se connecter.
                    ElevatedButton(
                      onPressed:
                          logInUser, // Appelle la fonction pour se connecter.
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF4A90E2), // Couleur de fond.
                        foregroundColor: Colors.white, // Couleur du texte.
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 60), // Marges internes.
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12), // Coins arrondis.
                        ),
                      ),
                      child: const Text(
                        'Login', // Texte du bouton.
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold), // Style du texte.
                      ),
                    ),
                    const SizedBox(height: 20), // Espacement vertical.
                    // Bouton pour aller vers l'écran d'inscription.
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupScreen()),
                        );
                      },
                      child: const Text(
                        "Don’t have an account? Sign up", // Texte du bouton.
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16), // Style du texte.
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
