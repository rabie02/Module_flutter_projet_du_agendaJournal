// Importation de l'écran pour créer un journal.
import 'package:daily_journal/screens/Create_journal_screen.dart';
// Importation de l'écran de connexion.
import 'package:daily_journal/screens/login_screen.dart';
// Importation des méthodes d'authentification Firebase personnalisées.
import 'package:daily_journal/services/firebase_auth_methods.dart';
// Importation des utilitaires pour la palette de couleurs.
import 'package:daily_journal/utils/pallete.dart';
// Importation d'un widget personnalisé pour un bouton avec un dégradé.
import 'package:daily_journal/widgets/gradient_button.dart';
// Importation de Firebase Authentication pour gérer les utilisateurs.
import 'package:firebase_auth/firebase_auth.dart';
// Importation de Flutter pour créer l'interface utilisateur.
import 'package:flutter/material.dart';
// Importation d'une liste personnalisée de widgets.
import '../widgets/custom_list_view.dart';

// Déclaration du widget Stateful pour l'écran principal.
class HomeScreen extends StatefulWidget {
  // Constructeur par défaut pour HomeScreen.
  const HomeScreen({super.key});

  // Création de l'état pour HomeScreen.
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// Déclaration de la classe d'état associée à HomeScreen.
class _HomeScreenState extends State<HomeScreen> {
  // Récupère l'utilisateur actuellement connecté via Firebase Authentication.
  final User? currUser = FirebaseAuth.instance.currentUser;

  // Méthode principale pour construire l'interface utilisateur.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barre d'application (AppBar) en haut de l'écran.
      appBar: AppBar(
        backgroundColor:
            const Color(0xFF4A90E2), // Couleur de fond de l'AppBar.
        title: const Text(
          "Entries", // Titre de l'AppBar.
          style: TextStyle(color: Colors.white), // Style du texte.
        ),
        centerTitle: true, // Centre le titre.
      ),
      backgroundColor: const Color(0xFFEAF4FC), // Couleur de fond de l'écran.

      // Ajout d'un tiroir de navigation (Drawer).
      drawer: Drawer(
        backgroundColor: Colors.white, // Couleur de fond du tiroir.
        child: ListView(
          children: [
            // En-tête du tiroir avec un dégradé.
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF4A90E2),
                    Color(0xFF50E3C2)
                  ], // Couleurs du dégradé.
                  begin: Alignment.topLeft, // Point de départ du dégradé.
                  end: Alignment.bottomRight, // Point de fin du dégradé.
                ),
              ),
              child: Column(
                children: [
                  // Icône représentant un utilisateur.
                  const Icon(
                    Icons.person, // Icône utilisateur.
                    color: Colors.white, // Couleur de l'icône.
                    size: 100, // Taille de l'icône.
                  ),
                  // Affichage de l'email de l'utilisateur connecté.
                  Text(
                    "${currUser?.email}", // Email de l'utilisateur.
                    style:
                        const TextStyle(color: Colors.white), // Style du texte.
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 100, // Espacement vertical.
            ),
            // Bouton pour se déconnecter.
            GradientButton(
              text: 'Sign Out', // Texte du bouton.
              onPressed: () async {
                // Déconnexion de l'utilisateur via Firebase.
                await FirebaseAuthMethods(FirebaseAuth.instance)
                    .signOut(context);
                // Redirection vers l'écran de connexion après déconnexion.
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ));
              },
            ),
          ],
        ),
      ),

      // Bouton flottant pour créer une nouvelle entrée.
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFFA726), // Couleur de fond du bouton.
        onPressed: () {
          // Navigation vers l'écran de création de journal.
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CreateJournal()));
        },
        child: const Icon(
          Icons.add, // Icône d'ajout.
          color: Colors.white, // Couleur de l'icône.
          size: 30, // Taille de l'icône.
        ),
      ),

      // Corps principal de l'écran.
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20), // Espacement interne.
          child: Card(
            elevation: 10, // Élévation pour l'ombre de la carte.
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Coins arrondis.
            ),
            color: Colors.white, // Couleur de fond de la carte.
            margin: const EdgeInsets.symmetric(
                horizontal: 20), // Marges horizontales.
            child: Padding(
              padding:
                  const EdgeInsets.all(20.0), // Espacement interne de la carte.
              child: Column(
                mainAxisSize:
                    MainAxisSize.min, // Réduit la taille à l'essentiel.
                children: [
                  // Titre de la section des entrées.
                  const Text(
                    "Your Entries", // Texte du titre.
                    style: TextStyle(
                      fontSize: 24, // Taille de la police.
                      fontWeight: FontWeight.bold, // Texte en gras.
                      color: Color(0xFF4A90E2), // Couleur du texte.
                    ),
                  ),
                  const SizedBox(height: 20), // Espacement vertical.
                  // Liste personnalisée des entrées.
                  const Expanded(child: CustomListView()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
