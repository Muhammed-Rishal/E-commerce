import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/model/productdetail_model.dart';
import 'package:ecommerce/services/api_services.dart';
import 'package:ecommerce/utils.dart';
import 'package:ecommerce/widgets/colordot.dart';
import 'package:ecommerce/widgets/sizebox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/taskProvider.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late final ApiServices apiServices;
  late Future<ProductDetailModel> productDetail;
  Color selectedColor = const Color(0xFF356C95);
  String selectedSize = "M";
  final List<String> sizes = ["S", "M", "L", "XL"];
  ProductDetailModel? product;

  @override
  void initState() {
    apiServices = ApiServices();
    fetchInitialData();
    super.initState();
  }

  void fetchInitialData() {
    productDetail = apiServices.getProductDetail(widget.productId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text(
          "Details",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: [
          Consumer<TaskProvider>(
            builder: (context, provider, child) {
              final isInWishlist = product != null &&
                  provider.wishlist.any((item) => item.id == product!.id);
              return IconButton(
                icon: Icon(
                  isInWishlist ? Icons.favorite : Icons.favorite_border,
                  color: Colors.pinkAccent,
                ),
                onPressed: () {
                  if (product != null) {
                    if (isInWishlist) {
                      provider.removeFromWishlist(product!.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${product!.title} removed from wishlist')),
                      );
                    } else {
                      provider.addToWishlist(product!);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${product!.title} added to wishlist')),
                      );
                    }
                  }
                },
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<ProductDetailModel>(
        future: productDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("No product details found"));
          }

          product = snapshot.data!;
          return Stack(
            children: [
              // Bottom white container
              Positioned(
                top: size.height * 0.3,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 100,
                    left: kDefaultPaddin,
                    right: kDefaultPaddin,
                    bottom: 20,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Color", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            ColorDot(
                              color: const Color(0xFF356C95),
                              isSelected: selectedColor == const Color(0xFF356C95),
                              onTap: () => setState(() => selectedColor = const Color(0xFF356C95)),
                            ),
                            ColorDot(
                              color: const Color(0xFFF8C078),
                              isSelected: selectedColor == const Color(0xFFF8C078),
                              onTap: () => setState(() => selectedColor = const Color(0xFFF8C078)),
                            ),
                            ColorDot(
                              color: const Color(0xFFA29B9B),
                              isSelected: selectedColor == const Color(0xFFA29B9B),
                              onTap: () => setState(() => selectedColor = const Color(0xFFA29B9B)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          product!.description,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text("Size", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: sizes.map((sizeText) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: SizeBox(
                                  size: sizeText,
                                  selectedSize: selectedSize,
                                  onSizeSelected: (newSize) {
                                    setState(() {
                                      selectedSize = newSize;
                                    });
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              final provider = Provider.of<TaskProvider>(context, listen: false);
                              provider.addToCart(product!);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('${product!.title} added to Kart')),
                              );
                            },
                            child: const Text(
                              'Add to Cart',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Top content: title + image + price
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Text(
                      product!.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 25),
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(color: Colors.white, fontSize: 16),
                              children: [
                                const TextSpan(text: "Price\n"),
                                TextSpan(
                                  text: "\$${product!.price}",
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: kDefaultPaddin),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(28),
                            child: CachedNetworkImage(
                              imageUrl: product!.image,
                              height: size.height * 0.30,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}