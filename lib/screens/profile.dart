import "package:ecommerce/screens/auth/login_screen.dart";
import "package:ecommerce/services/auth_services.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService authService = AuthService();
  
  void handleLogout(BuildContext context) async{
    await authService.logout();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500)),
        centerTitle: true,
        backgroundColor: const Color(0xFFFAF3E0),
      ),
      backgroundColor: const Color(0xFFFAF3E0),
      body: StreamBuilder<User?>(
        stream: authService.userChanges,
        builder: (context, snapshot) {
          final currentUser = snapshot.data;

          return Column(
            children: [
              const SizedBox(height: 60),
              Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: currentUser?.photoURL != null
                      ? NetworkImage(currentUser!.photoURL!)
                      : null,
                  child: currentUser?.photoURL == null
                      ? Icon(Icons.person, size: 80, color: Colors.white)
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                currentUser?.displayName ?? 'No name',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                currentUser?.email ?? 'No email',
                style: TextStyle(fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () => handleLogout(context), child: Text("Sign Out",style: TextStyle(fontSize: 18,color: Colors.white),)),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}