import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deal_diver/features/home/providers/deal_provider.dart';
import 'package:deal_diver/features/home/widgets/deal_card.dart';
import 'package:deal_diver/app/theme/app_text_styles.dart';

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
      body: Consumer<DealProvider>(
        builder: (context, dealProvider, child) {
          if (dealProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (dealProvider.deals.isEmpty) {
            return const Center(child: Text('No deals available.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: dealProvider.deals.length,
            itemBuilder: (context, index) {
              final deal = dealProvider.deals[index];
              return DealCard(
                deal: deal,
              );
            },
          );
        },
      ),
    );
  }
}
