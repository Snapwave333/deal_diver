import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

// --- DATA MODELS ---
class Deal {
  final String productName;
  final String retailer;
  final String price;
  final String? productUrl;
  final String? couponCode;

  Deal({
    required this.productName,
    required this.retailer,
    required this.price,
    this.productUrl,
    this.couponCode,
  });

  factory Deal.fromJson(Map<String, dynamic> json) {
    return Deal(
      productName: json['productName'] ?? 'No Name',
      retailer: json['retailer'] ?? 'No Retailer',
      price: json['price'] ?? 'N/A',
      productUrl: json['productUrl'],
      couponCode: json['couponCode'],
    );
  }
}

class Promo {
  final String retailer;
  final String code;
  final String description;
  final String? category;
  final String? type;

  Promo({
    required this.retailer,
    required this.code,
    required this.description,
    this.category,
    this.type,
  });

  factory Promo.fromJson(Map<String, dynamic> json) {
    return Promo(
      retailer: json['retailer'] ?? 'No Retailer',
      code: json['code'] ?? 'NOCODE',
      description: json['description'] ?? 'No description.',
      category: json['category'],
      type: json['type'],
    );
  }
}


void main() {
  runApp(const AuroraApp());
}

class AuroraApp extends StatelessWidget {
  const AuroraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aurora AI',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: Colors.transparent,
        // fontFamily: 'Manrope', // Font file not provided
      ),
      home: const DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF013A40), Color(0xFFA62675), Color(0xFFF28705)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: HomePage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // --- STATE MANAGEMENT ---
  String _activeTab = 'analyst';
  List<dynamic> _masterList = [];
  List<dynamic> _displayList = [];
  String? _error;
  bool _isLoading = false;
  String _loadingText = '';
  List<String> _sources = [];
  List<String> _watchlist = [];
  bool _isLayoutRight = false;
  double _sidebarWidth = 280.0;
  
  final TextEditingController _apiKeyController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _chatController = TextEditingController();

  // --- LIFECYCLE & SETUP ---
  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _apiKeyController.text = prefs.getString('geminiApiKey') ?? '';
      _watchlist = prefs.getStringList('auroraWatchlist') ?? [];
      _isLayoutRight = prefs.getBool('auroraLayout') ?? false;
      _sidebarWidth = prefs.getDouble('auroraSidebarWidth') ?? 280.0;
    });
  }

  Future<void> _saveApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('geminiApiKey', _apiKeyController.text);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('API Key Saved!'), duration: Duration(seconds: 2)),
    );
  }

  // --- UI LOGIC & SWITCHING ---
  void _switchTab(String tab) {
    setState(() {
      _activeTab = tab;
      _isLoading = false;
      _error = null;
      _masterList = [];
      _displayList = [];
      _sources = [];
      if (tab == 'promos') {
        _handlePromoSearch();
      }
    });
  }

  // --- API LOGIC ---
  Future<void> _handleProductSearch({String? productNameOverride}) async {
    final query = productNameOverride ?? _searchController.text.trim();
    final apiKey = _apiKeyController.text.trim();
    final location = _locationController.text.trim();

    if (apiKey.isEmpty) {
      setState(() => _error = 'API Key is missing.');
      return;
    }
    if (query.isEmpty) return;

    final isUsed = _activeTab == 'used';
    if (isUsed && location.isEmpty) {
      setState(() => _error = 'Location is required for used deals.');
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
      _loadingText = 'Searching for ${isUsed ? 'used' : 'new'} deals...';
    });

    final systemInstruction = isUsed
        ? "You are Aurora AI... Find USED items on resale sites... The JSON must contain a 'deals' array... Each object needs 'productName', 'retailer', 'price', 'productUrl', and optional 'couponCode'."
        : "You are Aurora AI... Find NEW items from retail stores... The JSON must contain a 'deals' array... Each object needs 'productName', 'retailer', 'price', 'productUrl', and optional 'couponCode'.";
    
    final fullQuery = "Find deals for: $query ${isUsed ? 'in location: $location' : ''}";

    try {
      final result = await _fetchWithRetry(fullQuery, apiKey, systemInstruction);
      final data = json.decode(result) as Map<String, dynamic>;
      final deals = (data['deals'] as List).map((d) => Deal.fromJson(d)).toList();

      setState(() {
        _masterList = deals;
        _displayList = deals;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _handlePromoSearch() async {
    final apiKey = _apiKeyController.text.trim();
    if (apiKey.isEmpty) {
      setState(() => _error = 'API Key is missing.');
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
      _loadingText = 'Scanning for hot promo codes...';
    });
    
    const systemInstruction = "You are Aurora AI... Find popular, active promo codes... The JSON must contain a 'promos' array... Each object needs 'retailer', 'code', 'description', 'category', and 'type'.";
    
    try {
      final result = await _fetchWithRetry('Find the most popular promo codes from the last week.', apiKey, systemInstruction);
      final data = json.decode(result) as Map<String, dynamic>;
      final promos = (data['promos'] as List).map((p) => Promo.fromJson(p)).toList();
      
      setState(() {
        _masterList = promos;
        _displayList = promos;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<String> _fetchWithRetry(String query, String apiKey, String systemInstruction, {int retries = 3}) async {
    for (int i = 0; i < retries; i++) {
      try {
        final response = await _fetchFromApi(query, apiKey, systemInstruction);
        if (response.statusCode == 200) {
          final body = json.decode(response.body);
          final content = body['candidates'][0]['content']['parts'][0]['text'] as String;
          final jsonMatch = RegExp(r"```json\n([\s\S]*?)\n```|({[\s\S]*})").firstMatch(content);
          if (jsonMatch == null) throw Exception("No valid JSON found in response.");
          return jsonMatch.group(1) ?? jsonMatch.group(2)!;
        } else if (response.statusCode == 503 || response.statusCode == 429) {
           throw Exception('Retry');
        } else {
           throw Exception('API Error: ${response.statusCode}\n${response.body}');
        }
      } catch (e) {
        if (e.toString() == 'Exception: Retry' && i < retries - 1) {
          await Future.delayed(Duration(seconds: 2 << i));
        } else {
          rethrow;
        }
      }
    }
     throw Exception('Model overloaded. Please try again later.');
  }

  Future<http.Response> _fetchFromApi(String query, String apiKey, String systemInstruction) {
    final url = Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey');
    final headers = {'Content-Type': 'application/json'};
    final payload = json.encode({
      'contents': [{'parts': [{'text': query}]}],
      'tools': [{'google_search': {}}],
      'systemInstruction': {'parts': [{'text': systemInstruction}]}
    });
    return http.post(url, headers: headers, body: payload);
  }

  // --- WIDGET BUILDERS ---
  Widget _buildBody() {
    if (_isLoading) {
      return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [CircularProgressIndicator(), SizedBox(height: 16), Text(_loadingText)]));
    }
    if (_error != null) {
      return Center(child: Text('Error: $_error', style: TextStyle(color: Colors.red)));
    }
    
    switch (_activeTab) {
      case 'analyst':
        return Center(child: Text("AI Analyst Chat Interface")); // Placeholder
      case 'new':
      case 'used':
        return _buildDealsList();
      case 'promos':
        return _buildPromosList();
      default:
        return Center(child: Text('Welcome! Select a tab.'));
    }
  }
  
  Widget _buildDealsList() {
    return ListView.builder(
      itemCount: _displayList.length,
      itemBuilder: (context, index) {
        final deal = _displayList[index] as Deal;
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          color: Colors.white.withOpacity(0.07),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(deal.productName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 4),
                Text(deal.retailer, style: TextStyle(color: Colors.amber[200])),
                SizedBox(height: 8),
                Text(deal.price, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                if (deal.couponCode != null && deal.couponCode!.toLowerCase() != 'n/a')
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Row(
                      children: [
                        Expanded(child: Text('Coupon: ${deal.couponCode}')),
                        ElevatedButton(onPressed: () {
                          Clipboard.setData(ClipboardData(text: deal.couponCode!));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Copied!')));
                        }, child: Text('Copy'))
                      ],
                    ),
                  ),
                if(deal.productUrl != null)
                  Padding(
                     padding: const EdgeInsets.only(top: 8.0),
                     child: Align(
                      alignment: Alignment.centerRight,
                       child: ElevatedButton.icon(
                        onPressed: () => launchUrl(Uri.parse(deal.productUrl!)),
                        icon: Icon(Icons.open_in_new),
                        label: Text('View Deal')
                                     ),
                     ),
                  )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPromosList() {
    return ListView.builder(
      itemCount: _displayList.length,
      itemBuilder: (context, index) {
        final promo = _displayList[index] as Promo;
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          color: Colors.white.withOpacity(0.07),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(promo.retailer, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.amber[200])),
                SizedBox(height: 8),
                Text(promo.description, style: TextStyle(fontSize: 16)),
                SizedBox(height: 12),
                Row(
                  children: [
                    Text('CODE: ', style: TextStyle(color: Colors.grey[400])),
                    Expanded(child: Text(promo.code, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
                    ElevatedButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: promo.code));
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Copied!')));
                      },
                      child: const Text('Copy'),
                    )
                  ],
                ),
                if (promo.category != null || promo.type != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Row(
                      children: [
                        if (promo.category != null)
                          Chip(label: Text(promo.category!), backgroundColor: Colors.white.withOpacity(0.1)),
                        SizedBox(width: 8),
                        if (promo.type != null)
                          Chip(label: Text(promo.type!), backgroundColor: Colors.white.withOpacity(0.1)),
                      ],
                    ),
                  )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final commandBar = Container(
      width: _sidebarWidth,
      color: Colors.black.withOpacity(0.3),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('✨ Aurora AI', style: Theme.of(context).textTheme.headlineMedium),
          ),
          Divider(color: Colors.amber.withOpacity(0.2)),
          _buildTab('analyst', Icons.chat, 'AI Analyst'),
          _buildTab('new', Icons.new_releases, 'New Deals'),
          _buildTab('used', Icons.shopping_bag, 'Used Deals'),
          _buildTab('promos', Icons.sell, 'Promo Codes'),
          Spacer(),
          // Settings etc. can go here
        ],
      ),
    );

    return Scaffold(
      body: Row(
        textDirection: _isLayoutRight ? TextDirection.rtl : TextDirection.ltr,
        children: [
          commandBar,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                   // API Key Section
                   TextField(
                    controller: _apiKeyController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Gemini API Key',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(icon: Icon(Icons.save), onPressed: _saveApiKey)
                    ),
                   ),
                   SizedBox(height: 16),
                   if(_activeTab == 'new' || _activeTab == 'used')
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'Search for a product...',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: () => _handleProductSearch())
                      ),
                      onSubmitted: (val) => _handleProductSearch(),
                    ),
                   if(_activeTab == 'used')
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextField(
                        controller: _locationController,
                         decoration: InputDecoration(labelText: 'Location...', border: OutlineInputBorder()),
                      ),
                    ),
                   SizedBox(height: 16),
                   Expanded(child: _buildBody()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  
  Widget _buildTab(String key, IconData icon, String label) {
    final bool isActive = _activeTab == key;
    return Material(
      color: isActive ? Colors.amber.withOpacity(0.1) : Colors.transparent,
      child: InkWell(
        onTap: () => _switchTab(key),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(icon, color: isActive ? Colors.amber : Colors.white),
              SizedBox(width: 16),
              Text(label, style: TextStyle(color: isActive ? Colors.amber : Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
