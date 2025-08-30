# Project Blueprint

## Overview

This document outlines the architecture, design, and features of the Deal Diver application. It serves as a single source of truth for the project's structure and implementation details.

## 1. Style and Design

The app uses a modern, clean design with a custom color palette. The theme is implemented with both light and dark modes, and the typography is handled by Google Fonts to ensure a consistent and readable user interface.

*   **Color Palette:** The color scheme is based on the Coolors palette `e6eed6-dde2c6-bbc5aa-a72608-090c02`.
*   **Theming:** The app uses a centralized `AppTheme` class with light and dark `ThemeData` objects. A `ThemeProvider` is used to manage the app's theme mode.
*   **Typography:** The `google_fonts` package is used for custom fonts, with `Oswald`, `Roboto`, and `Open Sans` for different text styles.

## 2. Features

### Implemented Features

*   **Theme Switching:** Users can switch between light, dark, and system theme modes.
*   **Basic Navigation:** The app has a bottom navigation bar for switching between the Home, Favorites, Search, and Settings screens.
*   **Deal Repository:** A repository pattern is implemented for managing deals, separating data logic from the UI.
*   **In-App Purchases for Ad Removal:** Users can purchase an ad-free unlock to remove advertisements from the application.
*   **Firebase Backend with Firestore:** The app is now connected to a Firebase backend, using Cloud Firestore to store and manage deal data in real-time.

### Current Task: Implement Firebase Backend

I have implemented a backend for the application using Firebase and Cloud Firestore. This allows the app to store, retrieve, and manage data dynamically.

**Plan:**

1.  **Add Dependencies:** Add `firebase_core` and `cloud_firestore` to `pubspec.yaml`.
2.  **Create Deal Model:** Created `lib/features/home/models/deal_model.dart` to define the data structure for deals.
3.  **Create Firestore Service:** Created `lib/app/services/firestore_service.dart` to handle all communication with Firestore.
4.  **Update Deal Repository:** Refactored the `DealRepository` to use the `FirestoreService` for fetching and adding deals.
5.  **Update UI:** Modified the `HomePage` to display a real-time list of deals from Firestore and added a button to create new deals.
