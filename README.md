# Stock Market Flutter App

A cross-platform mobile and web app built with Flutter for tracking stock market data, managing portfolios, and accessing detailed stock info.

---

## Features

- Real-time Stock Data: Fetches and displays real-time stock market data including current price, price change, and daily trends.
- Detailed Stock View: Shows detailed information about individual stocks, including price history displayed in interactive line charts.
- Portfolio Management: Allows users to add stocks to their portfolio and monitor overall portfolio performance with trend graphs.
- Search & Filtering: Users can search for stocks by ticker or name and filter the stock list for quick access.
- Theming: Supports light and dark modes with smooth theme toggling for user preference.
- Responsive UI: Clean and modern user interface designed with Flutter’s material design principles.
- State Management: Efficient state handling using Flutter’s built-in state management techniques.
- Constants and Styling: Centralized management of colors, typography, padding, and other UI styles for consistent design.
- Error Handling & Loading States: Proper error handling and loading indicators for a smooth user experience.
- Unit & Widget Testing: Automated tests using flutter_test to ensure UI components and business logic work as expected.
- Browse and search stock listings with detailed financial metrics.
- View real-time stock price charts and historical data.
- Manage a personal investment portfolio with performance tracking.
- User authentication with login/signup screens.
- Responsive UI optimized for mobile and web.
- Bottom navigation for seamless screen switching.

---

## Technology Stack

- Flutter (Dart) — Cross-platform UI framework.
- Dart — Programming language
- HTTP package — For making REST API calls to stock data providers
- MarketStack API — Primary data source for stock prices and details
- Syncfusion Flutter Charts — For rendering interactive stock price graphs
- setState — For managing app state
- flutter_test — For unit and widget testing
- Provider / State Management — To handle app state (if applicable).
- REST API Consumption — Fetches stock data from MarketStack and Alpha Vantage APIs.
- Custom Widgets — Reusable components like StockCard, PortfolioChart.
- Unit and Widget Testing — Automated tests using Flutter's flutter_test package.
- Theming — Consistent custom colors and fonts via constants/colors.dart and constants/styles.dart.

---

## Project Structure

Project/
  |- lib/
    |- main.dart
    |- models/
    |    |- stock.dart         
    |- screens/
    |    |- home_screen.dart
    |    |- stocks_screen.dart
    |    |- stock_detail_screen.dart
    |    |- portfolio_screen.dart
    |    |- pro_screen.dart
    |    |- about_screen.dart
    |    |- auth_screen.dart
    |- widgets/
    |    |- stock_card.dart
    |    |- portfolio_chart.dart
    |    |- team_member_card.dart
    |    |- market_card.dart
    |- constants/
    |    |- colors.dart
    |    |- styles.dart
    |    |- api_constants.dart
    |- services/
        |- api_service.dart
        |- geolocation_service.dart

  |- test/
    |- unit and widget test files using fluttere_test

---

## Module Overviews

### Constants Overview

Contains all the styling-related constants used throughout the app to ensure a consistent look and feel:
- api_constants.dart - Contains the api key from the MarketStack API to access stock information in real time.
- colors.dart – Defines the color palette used in the app (e.g., AppColors.primary, AppColors.background, etc.).
- styles.dart – Stores shared UI styles like text styles, paddings, margins, button shapes, and card decorations to maintain design consistency across screens.

### Models Overview

Defines the core data structures used to represent and process stock-related information:
- stock_model.dart – A Stock class representing the data model for each stock. Includes fields like symbol, name, price, change, volume, etc., and a fromJson() factory constructor for API parsing.

### Services Overview

Handles all business logic and external API communication:
- api_service.dart – Responsible for fetching stock data from external APIs (e.g., Alpha Vantage). Includes methods for retrieving real-time prices, stock metadata, and historical price data.

### Widgets Overview

Reusable and composable UI components used across multiple screens:
- stock_card.dart – A card widget that displays a summary of stock info (name, symbol, price, and daily change). Used in stock list views.
- team_member_card.dart - A custom card widget containing the information about the developers of the app including the name and the contact information.
- portfolio_summary_card-dart - A card widget showing the portfolio summary information of the user, containing details such as the account balance.
- portfolio_chart.dart – A custom chart widget that visualizes portfolio performance using line or bar charts.

### Screens Overview

- Home Screen: Displays the list of stocks with prices and daily trends. Includes a search bar and portfolio summary.
- Stock Detail Screen: Shows comprehensive details of a selected stock, including interactive price charts and key statistics.
- Portfolio Screen: Displays the user’s saved stocks, portfolio value, and performance charts.
- About Screen: Contains app info, team details, tech stack, and acknowledgements.
- Authentication Screen: Allows users to log in or register (if applicable).

---

## API Integration - Market Stack

This project uses the MarketStack API to fetch real-time stock market data. Below is a detailed breakdown of how the API is used and how to configure it for the project.

### API Key Setup

To access the MarketStack API, you need to obtain a free API key by creating an account at marketstack.com.
Once obtained:
1. Add your API key to your Flutter app using a secure approach (e.g., .env, encrypted local storage, or constants file in development).
2. If using api_constants.dart, it’s recommended to store it like:
```bash
static const ApiKey = 'YOUR_API_KEY_HERE';
```

### Endpoints Used

Endpoint
```bash
$baseUrl/tickers?access_key=$apiKey&search=$query'
```
- Purpose:
Fetches live data on tickers including stock name, price, change, and other metadata.

- Sample Query:
```bash
GET https://api.marketstack.com/v1/tickers?access_key=YOUR_API_KEY&limit=10
```

- Example Response:
```bash
{
  "data": [
    {
      "symbol": "AAPL",
      "name": "Apple Inc.",
      "stock_exchange": {...},
      "close": 172.32,
      "high": 174.00,
      "low": 170.50,
      "volume": 51234000,
      "change": -1.24,
      "change_percent": -0.72
    },
    ...
  ]
}
```

### Historical Data

If needed for charting or trends, you can also fetch historical data:

- Endpoint:
```bash
https://api.marketstack.com/v1/eod
```

- Sample Query:
```bash
GET https://api.marketstack.com/v1/eod?access_key=YOUR_API_KEY&symbols=AAPL&limit=30
```

This returns the last 30 end-of-day price entries for a given symbol.

### Integration in Code

In services/api_service.dart, the HTTP request is typically made using the http package. Example structure:
```dart
final response = await http.get(
  Uri.parse('https://api.marketstack.com/v1/tickers?access_key=$marketStackApiKey'),
);
```
The JSON response is parsed into Stock objects using Stock.fromJson() from the models/stock_model.dart file.

---

## UI / UX Design

- Designed with user experience in mind, using clean typography and consistent spacing.
- Light and dark themes handled via centralized color and style constants.
- Smooth transitions and loading animations for data fetching.
- Responsive layouts adapt to different screen sizes and orientations

---

## Key Components

- main.dart: Defines MaterialApp, theme, fonts, and navigation routes.
- Stock Model: Parses JSON data into strongly-typed Dart objects.
- Screens: Each screen implements specific UI and logic for stocks, portfolio, authentication, and more.
- Widgets: Modular UI components for cards, charts, and reusable elements.
- API Services: Handles network calls and data fetching from stock APIs.
- Testing: Comprehensive unit and widget tests to ensure app stability.

---

## How to Run Locally

1. Clone the repository:
```bash
git clone https://github.com/yourusername/flutter-stock-market-app.git
cd flutter-stock-market-app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

4. Set up API keys:
Obtain an MarketStack API key.
Add it to the lib/constants/api_constants.dart or use environment variables as per your setup.

---

## Notes & Limitations

- Rate Limits: Free tier allows limited requests per month; consider caching or limiting refresh frequency.
- Delay: MarketStack free tier has a 15-minute delay on real-time data.
- HTTPS Only: Ensure all endpoints are accessed via HTTPS for security.
- Secure Your Key: Do not expose the API key in production builds or public repositories.

---

## Future Enhancements

- Add user authentication and personalized watchlists.
- Implement push notifications for important stock price changes.
- Expand portfolio analytics with more detailed charts and metrics.
- Support multiple stock APIs for redundancy and wider data coverage.
- Integrate news feeds related to stocks for market insights.
- Add localization for multiple languages.

---

Dennis Alejandro Guerra Calix -- AGCalixto
