import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/features/home/models/deal.dart';
import 'package:myapp/features/home/providers/deal_provider.dart';
import 'package:myapp/features/home/widgets/deal_card.dart';
import 'package:myapp/app/theme/app_text_styles.dart';
import './add_deal_screen.dart';
import 'package:myapp/features/ads/ad_service.dart';
import 'package:myapp/services/remote_config_service.dart';
import 'package:myapp/features/home/widgets/promotional_banner.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final adService = AdService();
    final remoteConfigService = RemoteConfigService.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text('Deal Diver', style: AppTextStyles.textTheme.headlineLarge),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          if (remoteConfigService.isPromotionalBannerEnabled)
            const Padding(
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
              child: PromotionalBanner(),
            ),
          Expanded(
            child: StreamBuilder<List<Deal>>(
              stream: Provider.of<DealProvider>(context).dealsStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final deals = snapshot.data ?? [];

                if (deals.isEmpty) {
                  return const Center(child: Text('No deals available.'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: deals.length + 1, // Add one for the ad
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return adService.getNativeAd();
                    }
                    final deal = deals[index - 1];
                    return DealCard(
                      key: ValueKey(deal.id),
                      deal: deal,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddDealScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: Container(
        child: adService.getBannerAd(),
      ),
    );
  }
}
