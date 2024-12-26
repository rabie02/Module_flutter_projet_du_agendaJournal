// Importation de Flutter pour créer l'interface utilisateur.
import 'package:flutter/material.dart';
// Importation de Provider pour la gestion des états.
import 'package:provider/provider.dart';
// Importation des méthodes personnalisées pour Firebase Authentication.
import '../services/firebase_auth_methods.dart';
// Importation d'un utilitaire pour afficher des notifications (Snackbar).
import '../utils/showSnackBar.dart';
// Importation de l'écran principal (HomeScreen).
import 'home_screen.dart';
// Importation de l'écran de connexion (LoginScreen).
import 'login_screen.dart';

// Déclaration du widget Stateful pour l'écran d'inscription.
class SignupScreen extends StatefulWidget {
  // Constructeur par défaut.
  const SignupScreen({Key? key}) : super(key: key);

  // Création de l'état pour SignupScreen.
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

// Classe pour gérer l'état de SignupScreen.
class _SignupScreenState extends State<SignupScreen> {
  // Contrôleur pour le champ du nom complet.
  final TextEditingController fullNameController = TextEditingController();
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

  // Fonction pour inscrire un utilisateur via Firebase Authentication.
  void signUpUser() async {
    // Appelle la méthode d'inscription avec les données saisies.
    String res = await context.read<FirebaseAuthMethods>().signUpWithEmail(
          email: emailController.text, // Récupère l'email.
          password: passwordController.text, // Récupère le mot de passe.
          fullName: fullNameController.text, // Récupère le nom complet.
          context: context, // Contexte pour afficher des notifications.
        );

    // Si l'inscription réussit, redirige vers l'écran principal.
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
                    // Icône pour revenir à l'écran de connexion.
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back,
                              color: Colors.white), // Icône retour.
                          onPressed: () {
                            // Navigue vers l'écran de connexion.
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10), // Espacement vertical.
                    // Logo de l'application.
                    Image.asset('assets/images/logo.png', height: 100),
                    const SizedBox(height: 20), // Espacement vertical.
                    // Texte principal.
                    const Text(
                      "Create Your Account", // Texte du titre.
                      style: TextStyle(
                        fontSize: 36, // Taille de la police.
                        fontWeight: FontWeight.bold, // Texte en gras.
                        color: Colors.white, // Couleur du texte.
                      ),
                    ),
                    const SizedBox(height: 40), // Espacement vertical.
                    // Champ pour le nom complet.
                    Container(
                      width: 260, // Largeur du champ.
                      child: TextField(
                        controller: fullNameController, // Contrôleur de texte.
                        decoration: InputDecoration(
                          filled: true, // Fond rempli.
                          fillColor: Colors.white, // Couleur de fond.
                          labelText: 'Full Name', // Étiquette.
                          prefixIcon: const Icon(Icons.person_outline,
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
                    // Bouton pour s'inscrire.
                    ElevatedButton(
                      onPressed:
                          signUpUser, // Appelle la fonction pour s'inscrire.
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
                        'Sign Up', // Texte du bouton.
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold), // Style du texte.
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
