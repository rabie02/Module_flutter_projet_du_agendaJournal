// Importation des bibliothèques nécessaires.
import 'package:flutter/material.dart'; // Pour la construction de l'interface utilisateur.
import 'package:provider/provider.dart'; // Pour la gestion des états.
import 'package:firebase_auth/firebase_auth.dart'; // Pour l'authentification Firebase.
import 'package:firebase_core/firebase_core.dart'; // Pour initialiser Firebase.
import 'firebase_options.dart'; // Fichier généré pour configurer Firebase.
import 'services/firebase_auth_methods.dart'; // Méthodes d'authentification personnalisées.
import 'screens/home_screen.dart'; // Écran principal.
import 'screens/login_screen.dart'; // Écran de connexion.

// Fonction principale qui démarre l'application.
void main() async {
  // Initialise les widgets Flutter avant d'exécuter du code asynchrone.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialise Firebase avec les options de configuration pour la plateforme actuelle.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Lance l'application.
  runApp(const MyApp());
}

// Classe principale de l'application.
class MyApp extends StatelessWidget {
  // Constructeur par défaut de la classe.
  const MyApp({Key? key}) : super(key: key);

  // Méthode principale pour construire l'interface utilisateur.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Fournit plusieurs états (providers) à l'ensemble de l'application.
      providers: [
        // Fournisseur pour gérer les notifications liées à l'authentification.
        ChangeNotifierProvider(
          create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
        ),
        // Fournisseur pour suivre l'état d'authentification de l'utilisateur.
        StreamProvider<User?>(
          create: (context) => context.read<FirebaseAuthMethods>().authState,
          initialData:
              null, // Données initiales si aucun utilisateur n'est connecté.
        ),
      ],
      // Définit le MaterialApp comme widget racine.
      child: MaterialApp(
        title: 'Daily Journal', // Titre de l'application.
        theme: ThemeData.light(), // Utilise un thème clair pour l'application.
        home:
            const AuthWrapper(), // Définit le widget d'accueil basé sur l'état d'authentification.
      ),
    );
  }
}

// Widget qui décide quel écran afficher en fonction de l'état d'authentification.
class AuthWrapper extends StatelessWidget {
  // Constructeur par défaut.
  const AuthWrapper({Key? key}) : super(key: key);

  // Méthode principale pour construire l'interface utilisateur.
  @override
  Widget build(BuildContext context) {
    // Récupère l'utilisateur connecté via le StreamProvider.
    final firebaseUser = context.watch<User?>();

    // Si un utilisateur est connecté, affiche l'écran principal.
    if (firebaseUser != null) {
      return const HomeScreen();
    } else {
      // Sinon, affiche l'écran de connexion.
      return const LoginScreen();
    }
  }
}
