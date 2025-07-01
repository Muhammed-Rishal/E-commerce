import 'package:ecommerce/widgets/categoryCard_widget.dart';
import 'package:ecommerce/widgets/productItems.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;


    final horizontalPadding = screenWidth * 0.05;
    final topPadding = screenHeight * 0.07;
    final avatarSize = screenWidth * 0.18;
    final fontSizeLarge = screenWidth * 0.06;
    final fontSizeSmall = screenWidth * 0.04;
    final categoryWidgetHeight = screenHeight * 0.18;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF3E0),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  top: topPadding,
                  left: horizontalPadding,
                  right: horizontalPadding,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Let's make \nyour fashion",
                        style: TextStyle(
                          fontSize: fontSizeLarge + 2,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          height: 1.4,
                          letterSpacing: 1.4,
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.05),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(avatarSize),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          color: Colors.orange,
                          height: avatarSize,
                          width: avatarSize,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: screenHeight * 0.03,
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.3),
                  hintText: "Search anything here",
                  hintStyle: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                    fontSize: fontSizeSmall,
                  ),
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade700,
                    size: fontSizeLarge,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: screenHeight * 0.010,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.black54,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),

            // Categories Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Text(
                "Categories",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: fontSizeLarge + 2,
                  color: Colors.black87,
                ),
              ),
            ),

            SizedBox(
              height: categoryWidgetHeight,
              child: const CardWidget(),
            ),

            const SizedBox(height: 10),

            // New Items Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Text(
                "New items",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: fontSizeLarge + 2,
                  color: Colors.black87,
                ),
              ),
            ),

            const SizedBox(height: 20),


            const ProductWidget(),
          ],
        ),
      ),
    );
  }
}