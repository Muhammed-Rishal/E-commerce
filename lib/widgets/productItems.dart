import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/services/api_services.dart';
import 'package:ecommerce/model/product_model.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
      future: ApiServices().getProductModel(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No Products found."));
        } else {
          final products = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(8), // Add padding
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 columns
              childAspectRatio: 0.7, // Adjust based on content (width/height)
              crossAxisSpacing: 8, // Spacing between columns
              mainAxisSpacing: 8, // Spacing between rows
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(12), // Match Card's radius
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Fixed: Use `BorderRadius` instead of `BorderRadiusGeometry`
                  ),
                  elevation: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: products[index].image ?? '',
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.image_not_supported),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          products[index].title ?? 'No Title',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '\₹${products[index].price?.toStringAsFixed(2) ?? '0.00'}',
                          style: const TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}