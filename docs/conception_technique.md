# Dossier de conception technique - AccordMaster

## 1. Architecture Flutter

```text
lib/
  main.dart
  models/       Entités métier musicales et statistiques
  screens/      Cinq écrans et shell de navigation
  services/     Théorie musicale, audio et stockage
  state/        État global avec ChangeNotifier
  widgets/      Clavier et cartes réutilisables
assets/audio/   Douze notes chromatiques au format WAV
test/           Tests unitaires et test de widget
integration_test/ Parcours utilisateur principal
```

La logique métier reste séparée de l'interface. Les écrans consomment `AppState`, qui coordonne les services et notifie l'interface.

## 2. Classes métier

- `ChordDegree` : position, symbole, note, accord et rôle harmonique.
- `KeySignature` : tonique, mode et liste de sept degrés.
- `QuizQuestion` : tonalité, degré, réponse et propositions.
- `ProgressStats` : réponses, réussites, série et sessions mémoire, avec conversion `toMap/fromMap`.

## 3. Gestion des données

- Le catalogue musical est construit en mémoire à partir de la gamme chromatique et des intervalles majeurs ou mineurs.
- Le quiz utilise uniquement les tonalités majeures, sélectionnées aléatoirement avec un degré aléatoire.
- La progression est enregistrée localement avec `shared_preferences`.
- Les douze sons sont stockés dans `assets/audio/`; aucun réseau n'est nécessaire.

## 4. Gestion d'état

`AppState` étend `ChangeNotifier` et centralise : navigation, tonalité du Studio, question courante, correction, statistiques, audio et persistance. Le changement de question est asynchrone et automatique après affichage du résultat.

## 5. Navigation

`AppShell` contient une `NavigationBar` avec cinq destinations. Les écrans partagent la même instance d'`AppState`, ce qui conserve la progression et la tonalité choisie.

## 6. Packages

- `shared_preferences` : persistance légère des statistiques.
- `audioplayers` : lecture simultanée des notes et accords locaux.
- `flutter_test` : tests unitaires et tests de widgets.

## 7. Tests

- Génération de C majeur.
- Génération de A mineur naturel.
- Présence de la bonne réponse parmi quatre propositions.
- Variété des tonalités et degrés aléatoires.
- Limitation du quiz aux tonalités majeures.
- Affichage du shell et de la navigation.
- Parcours d'intégration : ouverture du Quiz, réponse et passage automatique.

## 8. Performance et écoconception

- Données musicales calculées localement et légères.
- Aucun appel réseau pendant l'utilisation.
- Sons courts, mono et réutilisés depuis les assets.
- Widgets `const` lorsque l'état ne varie pas.
- Dépendances limitées aux besoins réels.
- Services audio et transitions asynchrones libérés à la fermeture.

## 9. Sécurité minimale

Aucune donnée personnelle ou sensible n'est collectée. La progression reste uniquement sur l'appareil et aucune permission Android sensible n'est demandée.

## 10. Déploiement

```bash
flutter test
flutter build apk --release
```

Le nom Android est `AccordMaster`, l'icône est personnalisée et l'APK final doit être placé dans le dossier de livraison après compilation.
