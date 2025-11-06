# TicTacToeApp
Une application Tic Tac Toe (Morpion) développée en SwiftUI, avec un design moderne et des fonctionnalités avancées :
Score en temps réel

## Historique des parties enregistrées

- Animation de victoire
- Choix du symbole (X ou O)
- Réinitialisation des scores
- Gestion des parties terminées
- Architecture MVVM claire et modulaire
  
## Architecture

L’application repose sur une architecture MVVM (Model - View - ViewModel) :

TicTacToeApp
├── Models
│   ├── GameModel.swift
│   ├── Player.swift
│   ├── GameHistoryEntry.swift
│
├── ViewModels
│   ├── GameViewModel.swift
│   ├── MockGameViewModel.swift
│   ├── ScoreManager.swift
│   ├── HistoryManager.swift
│
├── Views
│   ├── GameView.swift
│   ├── GameBoardView.swift
│   ├── HistoryView.swift
│   ├── GameListView.swift
│   ├── VictoryAnimationView.swift
│
└── DesignSystem
    ├── PrimaryButton.swift
    ├── PrimaryButtonViewModel.swift
    
## Fonctionnalités principales

- Gameplay
- Morpion jouable à deux (X contre O)
- Choix du symbole avant de commencer
- Tour affiché à l’écran
- Détection de victoire et de match nul
- Scores
- Compteur de victoires pour chaque joueur
- Réinitialisation des scores à tout moment
- Historique des parties
- Enregistrement automatique des parties terminées (victoire ou égalité)
- Stockage persistant via UserDefaults
- Affichage des parties passées dans un onglet dédié
- Réinitialisation complète de l’historique possible
  
## Interface

- Interface moderne et animée avec SwiftUI
- Dégradé de fond et boutons personnalisés (PrimaryButton)
- Animation de victoire avec transition fluide
  
## Composants clés

- GameModel
- Contient la logique du jeu : grille, joueur actuel, victoire, égalité.
- GameViewModel
- Gère la logique métier et les interactions avec la vue.
- Appelle HistoryManager pour enregistrer les parties terminées.
- ScoreManager
- Singleton pour gérer les scores des joueurs (victoires X et O).
- HistoryManager
- Singleton pour enregistrer, sauvegarder et charger les parties terminées.
- HistoryView
- Affiche la liste des parties précédentes (date, gagnant, joueurs).

## Technologies utilisées

Swift 5.10+
SwiftUI
MVVM Architecture
Combine (via @Published / @ObservedObject)
UserDefaults (pour persistance locale)
DesignSystem personnalisé

## Lancer le projet

- Cloner le dépôt
   
git clone https://github.com/mahanunu/xcodeproject.git
cd TicTacToeApp
- Ouvrir le projet
Ouvre TicTacToeApp.xcodeproj ou TicTacToeApp.xcworkspace dans Xcode.
- Lancer sur simulateur
Appuie sur dans Xcode pour exécuter le projet sur iPhone Simulator.

Sélection du joueur	Plateau de jeu	Historique
Choisis ton symbole	Jeu en cours	Liste des parties passées
Améliorations possibles


## Auteurs
Projet réalisé par :
- Mahalia PIRES
- William AGRÉ
