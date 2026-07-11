# Scénario de démonstration - AccordMaster

## Introduction

AccordMaster est un jeu Flutter d'apprentissage musical. Il permet de voir, entendre et mémoriser les degrés d'accords sans connexion Internet.

## Démonstration courte

1. Ouvrir l'application et jouer quelques notes sur le clavier de l'accueil.
2. Ouvrir le Studio, choisir une tonalité et écouter plusieurs accords.
3. Ouvrir le Quiz, répondre et montrer le passage automatique vers une autre tonalité majeure.
4. Ouvrir Mémoire, compléter les sept degrés puis afficher le score.
5. Ouvrir Progrès et expliquer la sauvegarde locale des statistiques.

## Choix techniques à expliquer

- Flutter et Dart pour une application mobile multiplateforme.
- `ChangeNotifier` pour centraliser l'état sans dépendance supplémentaire.
- `shared_preferences` pour la progression locale.
- `audioplayers` et douze fichiers WAV pour l'écoute hors ligne.
- Architecture séparée en modèles, services, état, écrans et widgets.
- Tests unitaires, test de widget et parcours d'intégration.

## Difficultés rencontrées

- Compatibilité entre la version de Flutter et `audioplayers`, résolue avec la version 6.7.1.
- Synchronisation du passage automatique entre les questions, résolue avec une transition asynchrone contrôlée.
- Cohérence UI/UX, améliorée avec une identité musicale commune aux cinq écrans.

## Améliorations futures

- Quiz de reconnaissance uniquement à l'oreille.
- Gammes mineures harmonique et mélodique.
- Accords enrichis : 7, maj7 et m7.
- Réglage du tempo et mode chronométré.
