
# Blueprint: Deal Diver [v2.0]

## 1. Overview & Vision

Deal Diver is a premium deal discovery application, rebuilt from first principles to be visually stunning, highly performant, and scalable. It provides a seamless experience for finding product deals and promotional offers.

**Design Philosophy:** The UI/UX follows a "Cyber-Noir" aesthetic. It combines a dark, textured background with vibrant neon accent colors (Electric Blue, Magenta) to create a futuristic and immersive feel. The layout is clean, responsive, and prioritizes intuitive user interaction with polished animations and effects.

## 2. Architecture & Structure

The project uses a feature-first, layered architecture to ensure separation of concerns and maintainability.

*   **State Management:** `provider` is used for managing app-wide state, such as theme settings.
*   **Dependencies:**
    *   `provider`: For state management.
    *   `google_fonts`: For rich, modern typography.
*   **File Structure:**
    ```
    lib/
    ├── main.dart             # App entry point, DI, and routing
    |
    ├── app/
    │   ├── providers/
    │   │   └── theme_provider.dart # Manages light/dark/system theme state
    │   └── theme/
    │       ├── app_theme.dart      # Defines ThemeData for light & dark modes
    │       ├── app_colors.dart     # Centralized color palette
    │       └── app_text_styles.dart# Centralized typography styles
    |
    ├── features/
    │   ├── navigation/
    │   │   └── main_navigation.dart # Host screen with BottomNavigationBar
    │   │
    │   ├── home/
    │   │   ├── screens/home_screen.dart
    │   │   └── widgets/deal_card.dart
    │   │
    │   ├── search/
    │   │   └── screens/search_screen.dart
    │   │
    │   ├── favorites/
    │   │   └── screens/favorites_screen.dart
    │   │
    │   └── settings/
    │       └── screens/settings_screen.dart
    |
    └── core/
        └── models/
            └── deal.dart           # Data model for deals
    ```

## 3. Current Implementation Plan

**Phase 1: Foundation & Core UI (In Progress)**

1.  **[COMPLETE]** Restructure project into the new feature-based architecture.
2.  **[COMPLETE]** Implement the core color palette and typography styles.
3.  **[COMPLETE]** Set up `ThemeProvider` for dynamic theme switching.
4.  **[COMPLETE]** Define the master `ThemeData` for both dark and light modes.
5.  **[COMPLETE]** Implement the main app entry point (`main.dart`).
6.  **[COMPLETE]** Build the main navigation shell (`main_navigation.dart`) with a `BottomNavigationBar`.
7.  **[IN PROGRESS]** Develop the `HomeScreen` with a mock data display.
8.  **[IN PROGRESS]** Design and build the reusable `DealCard` widget with the Cyber-Noir aesthetic.
9.  **[TODO]** Create placeholder screens for Search, Favorites, and Settings.
10. **[TODO]** Implement the theme toggle functionality in the Settings screen.
