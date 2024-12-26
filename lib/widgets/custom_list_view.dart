// Importation de Firestore pour gérer les données.
import 'package:cloud_firestore/cloud_firestore.dart';
// Importation de l'écran pour afficher les détails d'un journal.
import 'package:daily_journal/screens/display_journal_screen.dart';
// Importation de la palette de couleurs personnalisées.
import 'package:daily_journal/utils/pallete.dart';
// Importation de Firebase Auth pour l'authentification.
import 'package:firebase_auth/firebase_auth.dart';
// Importation de Flutter pour construire l'interface utilisateur.
import 'package:flutter/material.dart';

// Déclaration d'un widget Stateful pour la liste personnalisée.
class CustomListView extends StatefulWidget {
  // Constructeur par défaut.
  const CustomListView({super.key});

  // Création de l'état pour CustomListView.
  @override
  State<CustomListView> createState() => _CustomListViewState();
}

// Classe pour gérer l'état de CustomListView.
class _CustomListViewState extends State<CustomListView> {
  // Récupère l'utilisateur actuellement connecté via Firebase Auth.
  final currentUser = FirebaseAuth.instance.currentUser;

  // Méthode principale pour construire l'interface utilisateur.
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      // Récupère les entrées de la sous-collection "journals" pour l'utilisateur connecté.
      stream: FirebaseFirestore.instance
          .collection("Users/${currentUser?.email}/journals")
          .snapshots(),
      builder: (context, snapshot) {
        // Si les données ne sont pas encore chargées, affiche un indicateur de chargement.
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(), // Indicateur de chargement.
          );
        }
        // Si les données sont disponibles, affiche une liste des journaux.
        return Column(
          children: [
            ListView.builder(
              scrollDirection: Axis.vertical, // Définit le défilement vertical.
              shrinkWrap: true, // Adapte la taille de la liste au contenu.
              itemCount: snapshot.data!.docs.length, // Nombre d'éléments.
              itemBuilder: (BuildContext context, int index) {
                // Récupère chaque document de la collection.
                QueryDocumentSnapshot<Object?> journal =
                    snapshot.data!.docs[index];
                // Retourne un widget CustomTile pour chaque entrée.
                return CustomTile(
                  entryData: journal, // Passe les données du journal au widget.
                );
              },
            ),
          ],
        );
      },
    );
  }
}

// Widget stateless pour représenter chaque élément de la liste.
class CustomTile extends StatelessWidget {
  // Données du journal à afficher.
  final QueryDocumentSnapshot<Object?> entryData;

  // Constructeur pour initialiser les données du journal.
  const CustomTile({
    super.key,
    required this.entryData,
  });

  // Méthode principale pour construire l'interface utilisateur de l'élément.
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5), // Espacement au-dessus de la tuile.
        ListTile(
          // Couleur de fond de la tuile.
          tileColor: Pallete.gradient3,
          // Bordures arrondies pour la tuile.
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          // Titre de la tuile (titre du journal).
          title: Text(entryData['title']),
          // Sous-titre de la tuile (date du journal).
          subtitle: Text(entryData['date']),
          // Icône à droite de la tuile.
          trailing: const Icon(Icons.arrow_right),
          // Action lorsqu'on clique sur la tuile.
          onTap: () {
            Navigator.push(
              context,
              // Navigation vers l'écran de détails du journal.
              MaterialPageRoute(
                builder: ((context) => DisplayJournal(
                      data: entryData, // Passe les données du journal.
                    )),
              ),
            );
          },
        ),
        const SizedBox(height: 20), // Espacement sous la tuile.
      ],
    );
  }
}
