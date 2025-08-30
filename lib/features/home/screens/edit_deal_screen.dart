
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deal_diver/features/home/widgets/deal_card.dart';

class EditDealScreen extends StatefulWidget {
  final Deal deal;

  const EditDealScreen({super.key, required this.deal});

  @override
  _EditDealScreenState createState() => _EditDealScreenState();
}

class _EditDealScreenState extends State<EditDealScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  late double _price;

  @override
  void initState() {
    super.initState();
    _title = widget.deal.title;
    _description = widget.deal.description;
    _price = widget.deal.price;
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final updatedDeal = Deal(
        title: _title,
        description: _description,
        price: _price,
        image: widget.deal.image,
      );
      // In a real app, you would have a state management solution
      // to update the deal across the app. For this example, we'll
      // just pop the screen and return the updated deal.
      Navigator.of(context).pop(updatedDeal);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Deal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              TextFormField(
                initialValue: _price.toString(),
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _price = double.parse(value!);
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
