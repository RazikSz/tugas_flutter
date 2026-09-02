import 'package:flutter/material.dart';

import '../models/post_models.dart';

class RecipeDetailScreen extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe.name ?? 'Detail Resep')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (recipe.image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  recipe.image!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 16),
            Text(
              recipe.name ?? '-',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              'Cuisine: ${recipe.cuisine ?? '-'} | Tingkat Kesulitan: ${recipe.difficulty ?? '-'}',
              style: const TextStyle(color: Colors.grey),
            ),
            const Divider(height: 24),
            const Text(
              'Bahan-bahan:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...?recipe.ingredients?.map((item) => Text('• $item')),
            const Divider(height: 24),
            const Text(
              'Instruksi:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...?recipe.instructions?.asMap().entries.map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text('${e.key + 1}. ${e.value}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

typedef PostDetailScreen = RecipeDetailScreen;
