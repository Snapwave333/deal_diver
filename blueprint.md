
# Project Blueprint: Aurora AI

## Overview

Aurora AI is a Flutter-based application designed to help users find the best deals and promo codes for products. It leverages the Gemini AI model to perform targeted searches for new and used items, as well as to discover active promotional codes from various retailers. The application features a dynamic and visually appealing user interface with a distinctive gradient background and a clear, tab-based navigation system.

## Style, Design, and Features

### Initial Version (v1)

*   **UI/UX:**
    *   **Theme:** Dark theme with a vibrant gradient background transitioning from teal to magenta to orange (`#013A40`, `#A62675`, `#F28705`).
    *   **Typography:** The application is designed to use the 'Manrope' font (currently disabled as the font file is not available). The default font is used as a fallback.
    *   **Layout:** A two-column layout featuring a fixed sidebar for navigation and a main content area. The layout can be switched from left-to-right to right-to-left.
    *   **Navigation:** A tab-style navigation in the sidebar allows users to switch between different functionalities: "AI Analyst" (placeholder), "New Deals," "Used Deals," and "Promo Codes."

*   **Core Features:**
    *   **API Key Management:** Users can securely save their Gemini API key using `shared_preferences`. The key is obscured in the input field.
    *   **Deal Searching:**
        *   **New Deals:** Users can search for new products from retail stores.
        *   **Used Deals:** Users can search for used items, requiring a location for the search.
    *   **Promo Code Discovery:** A dedicated tab to fetch and display currently popular promo codes.
    *   **Dynamic Content Display:** Search results are displayed in the main content area as a list of stylized cards. Each card presents key information like product name, retailer, price, and a link to the deal.
    *   **Clipboard Integration:** Users can easily copy coupon codes to their clipboard.
    *   **URL Launcher:** "View Deal" buttons open the product URL in the user's default browser.

*   **Architecture:**
    *   **State Management:** The application uses `StatefulWidget` and `setState` for managing local component state, such as the active tab, search results, and loading indicators.
    *   **API Integration:** It communicates with the Google Generative AI API (`generativelanguage.googleapis.com`) using the `http` package to fetch data from the `gemini-1.5-flash` model.
    *   **Error Handling:** Includes a retry mechanism for API calls to handle potential network issues or model overloading, and displays user-friendly error messages.

## Current Plan

This section will be updated with the plan for the next set of requested changes.

