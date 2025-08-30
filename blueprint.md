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

### Current Task: Implement Deal Repository

I will implement a repository pattern for managing deals in the application. This will separate the data logic from the UI and prepare the app for backend integration with Firebase.

**Plan:**

1.  **Add Dependencies:** Add `cloud_firestore` and `firebase_core` to `pubspec.yaml`.
2.  **Create Repository:** Create `lib/features/home/repositories/deal_repository.dart`.
3.  **Create Firestore Service:** Create `lib/app/services/firestore_service.dart` to handle Firestore communication.
4.  **Refactor UI:** Update the UI to use the new repository to manage deals.
