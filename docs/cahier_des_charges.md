# Cahier des charges - AccordMaster

## 1. Nom et contexte

AccordMaster est une application mobile Flutter destinee aux apprenants en musique. Elle aide a apprendre, memoriser et reviser les degres d'accords dans les tonalites majeures et mineures naturelles.

Dans l'apprentissage musical, beaucoup d'eleves connaissent les notes separement, mais ont du mal a associer rapidement une tonalite a ses accords : I, ii, iii, IV, V, vi, vii en majeur, ou i, ii, III, iv, v, VI, VII en mineur naturel. L'application transforme cette memorisation en jeu court, progressif et repetable.

## 2. Probleme traite

Les tableaux de tonalites sont souvent presentes de maniere statique. L'apprenant lit les accords, mais ne s'entraine pas assez a les retrouver. AccordMaster propose une experience active : choisir une tonalite, observer les degres, repondre a des questions et suivre sa progression.

## 3. Utilisateurs cibles

- Etudiants en musique.
- Guitaristes, pianistes, beatmakers et chanteurs autodidactes.
- Enseignants qui veulent proposer un support de revision simple.
- Toute personne qui apprend l'harmonie tonale de base.

## 4. Fonctionnalites principales

- Consulter les accords d'une tonalite majeure ou mineure naturelle.
- Apprendre les degres avec une explication courte pour chaque accord.
- Jouer les notes sur un clavier interactif et ecouter chaque accord.
- Repondre a un quiz : retrouver l'accord correspondant a un degre.
- Faire un mode memoire : completer toute la suite d'accords d'une tonalite.
- Enregistrer le score, les bonnes reponses, les erreurs et la meilleure serie.
- Afficher une page de progression avec badges simples.

## 5. Fonctionnalites optionnelles

- Ajouter les tonalites avec alterations complexes.
- Ajouter des niveaux de difficulte.
- Ajouter un classement local.
- Ajouter les gammes mineures harmonique et melodique.

## 6. Donnees manipulees

- Tonalites : nom, mode, notes, accords, degres.
- Questions de quiz : tonalite, degre demande, bonne reponse, propositions.
- Progression : nombre de questions, bonnes reponses, score, meilleure serie, tonalites revisees.
- Erreurs : degres ou tonalites les moins maitrises.

## 7. Stockage des donnees

Les donnees musicales de base sont integrees dans le code Dart. La progression de l'utilisateur est sauvegardee localement avec `shared_preferences`. Ce choix est adapte car l'application fonctionne hors ligne et ne necessite pas de compte utilisateur.

## 8. Exigences non fonctionnelles

- Interface lisible sur mobile.
- Navigation simple avec cinq sections : Accueil, Apprendre, Quiz, Memoire, Progres.
- Fonctionnement hors ligne.
- Lecture des sons sans connexion grace aux fichiers audio locaux.
- Sauvegarde locale rapide.
- Messages de reponse clairs dans les quiz.
- Code organise par modeles, services, etats, ecrans et widgets.
- Sobriete : pas d'appels reseau inutiles, peu de dependances, donnees legeres.

## 9. Criteres de reussite

- L'utilisateur peut consulter au moins 12 tonalites majeures et 12 tonalites mineures.
- L'utilisateur peut jouer a un quiz complet.
- L'utilisateur peut faire un exercice de memorisation.
- La progression reste disponible apres relance de l'application.
- L'application possede un README, des tests et une architecture claire.

## 10. Limites du projet

La premiere version se limite aux tonalites majeures et mineures naturelles. Les comptes en ligne, modes avances et classements sont presentes comme ameliorations futures.
