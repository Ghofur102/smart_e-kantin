import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _auth = AuthService();
  final _db = FirebaseFirestore.instance;
  Map<String, dynamic>? _data;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final uid = await _auth.currentUID();
    if (uid == null) {
      _goToLogin();
      return;
    }
    // uid available in local variable `uid` if needed
    final snap = await _db.collection('users').doc(uid).get();
    setState(() {
      _data = snap.exists ? snap.data() : {'email': FirebaseAuth.instance.currentUser?.email ?? ''};
      _loading = false;
    });
  }

  void _signOut() async {
    await _auth.signOut();
    _goToLogin();
  }

  void _goToLogin() {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginPage()), (r) => false);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return Scaffold(appBar: AppBar(title: const Text('Profile')), body: const Center(child: CircularProgressIndicator()));
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Nama: ${_data?['name'] ?? '-'}', style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 8),
          Text('Email: ${_data?['email'] ?? '-'}', style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: _signOut, child: const Text('Logout')),
        ]),
      ),
    );
  }
}
