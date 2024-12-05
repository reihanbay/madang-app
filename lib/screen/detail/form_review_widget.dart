import 'package:flutter/material.dart';

class ReviewForm extends StatefulWidget {
  const ReviewForm({super.key});

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    reviewController.dispose();
  }

  void submitForm() {
    if (formKey.currentState!.validate()) {
      // Menutup bottom sheet
      Map<String, String> result = {
        'name': nameController.text,
        'review': reviewController.text
      };
      Navigator.pop(context, result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name cannot be empty';
                  }
                  return null; // Input valid
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: reviewController,
                decoration: InputDecoration(
                  labelText: 'Review',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Review cannot be empty';
                  }
                  if (value.length < 3) {
                    return 'Review must be at least 1 word!';
                  }
                  return null; // Input valid
                }, // Untuk input teks yang lebih panjang
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: submitForm,
                child: const Text('Submit'),
              ),
            ],
          )),
    );
  }
}
