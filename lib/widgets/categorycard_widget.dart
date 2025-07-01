import 'package:flutter/material.dart';
import '../model/product_model.dart';
import '../services/api_services.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({super.key});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  final Map<Category, String> _categoryImageMap = {};
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final products = await ApiServices().getProductModel();

      final Map<Category, String> uniqueCategories = {};
      for (final product in products) {
        final category = product.category;
        final image = product.image;

        if (category != null && image != null && !uniqueCategories.containsKey(category)) {
          uniqueCategories[category] = image;
        }
      }

      if (mounted) {
        setState(() {
          _categoryImageMap.clear();
          _categoryImageMap.addAll(uniqueCategories);
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Error fetching categories: $e");
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive values
    final avatarRadius = screenWidth * 0.09; // 7% of screen width
    final itemSpacing = screenWidth * 0.03; // 3% of screen width
    final containerHeight = screenHeight * 0.15; // 15% of screen height
    final fontSize = screenWidth * 0.03; // Responsive font size

    if (_isLoading) {
      return SizedBox(
        height: containerHeight,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_hasError || _categoryImageMap.isEmpty) {
      return SizedBox(
        height: containerHeight,
        child: Center(
          child: Text(
            "No categories available",
            style: TextStyle(fontSize: fontSize * 1.5),
          ),
        ),
      );
    }

    return SizedBox(
      height: containerHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
        itemCount: _categoryImageMap.length,
        separatorBuilder: (_, __) => SizedBox(width: itemSpacing),
        itemBuilder: (context, index) {
          final category = _categoryImageMap.keys.elementAt(index);
          final imageUrl = _categoryImageMap[category]!;
          final categoryName = categoryValues.reverse[category] ?? '';

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: avatarRadius,
                backgroundColor: Colors.orange.shade200,
                backgroundImage: NetworkImage(imageUrl),
              ),
              SizedBox(height: screenHeight * 0.01),
              SizedBox(
                width: avatarRadius * 2.5, // Width based on avatar size
                child: Text(
                  categoryName,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}