# Rapport de tests, debugging et performance

## Stratégie de test

| Niveau | Vérification | Preuve |
|---|---|---|
| Unitaire | Gammes majeures et mineures | `test/music_theory_service_test.dart` |
| Unitaire | Questions, variété et mode majeur | `test/music_theory_service_test.dart` |
| Widget | Affichage et navigation principale | `test/widget_test.dart` |
| Intégration | Réponse au quiz et transition automatique | `integration_test/app_flow_test.dart` |

Résultat du parcours d'intégration sur Windows : `All tests passed`.

Analyse statique finale : `flutter analyze` - `No issues found`.

## Bugs corrigés

1. Dépendance audio incompatible avec Flutter 3.41.4 : version fixée à `audioplayers 6.7.1`.
2. Tests de widget obsolètes après la refonte : attentes mises à jour.
3. Transition du quiz bloquée : minuteur remplacé par une transition asynchrone contrôlée.
4. Quiz limité à C : tirage aléatoire parmi les douze tonalités majeures.

## Performance observée

- Aucun appel réseau pendant l'utilisation.
- Catalogue musical conservé en mémoire, avec seulement 24 tonalités et 168 degrés.
- Assets audio courts et mono, environ 75 Ko par note.
- Navigation sans chargement distant.
- Mise à jour ciblée par `ChangeNotifier` et widgets `const` lorsque possible.

## Écoconception

- Fonctionnement hors ligne.
- Absence d'images lourdes et de vidéos.
- Deux dépendances fonctionnelles seulement.
- Pas de collecte de données ni de synchronisation inutile.

## Validation finale

Reporter ici le résultat de la commande finale :

```text
flutter test
Résultat : 6 tests réussis - All tests passed.
Date : 11 juillet 2026.
```

Ajouter une capture de Flutter DevTools dans `docs/captures/` si elle est disponible pendant la démonstration.

## Déploiement validé

```text
flutter build apk --release
Résultat : build/app/outputs/flutter-apk/app-release.apk
Taille : 48,0 Mo
Copie de remise : output/apk/AccordMaster-v1.0.0.apk
```
