import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/features/iap/in_app_purchase_provider.dart';
import 'package:myapp/features/home/repositories/deal_repository.dart';
import 'package:myapp/features/home/models/deal_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dealRepository = FirestoreDealRepository();

    return Scaffold(
      appBar: AppBar(
        title: const Text('DealDiver'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Add a new deal
              dealRepository.addDeal(
                Deal(
                  id: '',
                  title: 'New Deal',
                  description: 'A great new deal!',
                  price: 10.0,
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Deal>>(
              stream: dealRepository.getDeals(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                final deals = snapshot.data ?? [];
                if (deals.isEmpty) {
                  return const Center(child: Text('No deals yet!'));
                }
                return ListView.builder(
                  itemCount: deals.length,
                  itemBuilder: (context, index) {
                    final deal = deals[index];
                    return ListTile(
                      title: Text(deal.title),
                      subtitle: Text(deal.description),
                      trailing: Text('\$${deal.price.toStringAsFixed(2)}'),
                    );
                  },
                );
              },
            ),
          ),
          Consumer<InAppPurchaseProvider>(
            builder: (context, iapProvider, child) {
              if (iapProvider.isAdFree) {
                return Container();
              } else {
                return ElevatedButton(
                  onPressed: () {
                    iapProvider.buyAdFreeUnlock();
                  },
                  child: const Text('Remove Ads'),
                );
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: Consumer<InAppPurchaseProvider>(
        builder: (context, iapProvider, child) {
          if (iapProvider.isAdFree) {
            return Container();
          } else {
            return Container(
              height: 50,
              color: Colors.grey[200],
              child: const Center(
                child: Text('Ad Banner'),
              ),
            );
          }
        },
      ),
    );
  }
}
