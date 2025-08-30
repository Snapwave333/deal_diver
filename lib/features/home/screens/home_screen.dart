import 'package:flutter/material.dart';
import 'package:myapp/features/home/widgets/deal_card.dart';
import '../../../app/theme/app_text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deal Diver', style: AppTextStyles.textTheme.headlineLarge),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 10, // Mock data
        itemBuilder: (context, index) {
          return const DealCard();
        },
      ),
    );
  }
}
