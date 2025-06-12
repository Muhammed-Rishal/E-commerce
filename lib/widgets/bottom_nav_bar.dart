import 'package:ecommerce/screens/home_screen.dart';
import 'package:ecommerce/screens/kart.dart';
import 'package:ecommerce/screens/profile.dart';
import 'package:ecommerce/screens/wishlist.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.black,
          height: 70,
          child: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.favorite)),
              Tab(icon: Icon(Icons.add_shopping_cart)),
              Tab(icon: Icon(Icons.person)),
            ],
            unselectedLabelColor: Color(0xFF999999),
            labelColor: Colors.white,
            indicatorColor: Colors.transparent,
          ),
        ),

        body: const TabBarView(children: [
          HomeScreen(),
          WishlistScreen(),
          KartScreen(),
          ProfileScreen(),
        ]),
      ),
    );
  }
}
