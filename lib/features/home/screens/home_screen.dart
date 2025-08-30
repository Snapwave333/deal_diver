
import 'package:flutter/material.dart';
import 'package:deal_diver/features/home/models/deal.dart';
import 'package:deal_diver/features/home/widgets/deal_card.dart';
import '../../../app/theme/app_text_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Deal> deals;

  @override
  void initState() {
    super.initState();
    deals = List.generate(
      10,
      (index) => Deal(
        title: 'Futuristic Gadget Deal ${index + 1}',
        description: 'Save 50% on this amazing piece of tech. Limited time offer, dive into the deal now!',
        price: 99.99 + (index * 10),
        image: 'https://picsum.photos/400/200?random=${index}',
      ),
    );
  }

  void _updateDeal(int index, Deal updatedDeal) {
    setState(() {
      deals[index] = updatedDeal;
    });
  }

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
        itemCount: deals.length,
        itemBuilder: (context, index) {
          return DealCard(
            deal: deals[index],
            onDealUpdated: (updatedDeal) {
              _updateDeal(index, updatedDeal);
            },
          );
        },
      ),
    );
  }
}
