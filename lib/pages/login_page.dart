import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'register_page.dart';
import 'profile_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtr = TextEditingController();
  final _passCtr = TextEditingController();
  final AuthService _auth = AuthService();
  bool _loading = false;

  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email wajib diisi';
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(v.trim())) return 'Format email tidak valid';
    return null;
  }

  String? _validatePass(String? v) {
    if (v == null || v.trim().isEmpty) return 'Password wajib diisi';
    if (v.trim().length < 6) return 'Password minimal 6 karakter';
    return null;
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    final err = await _auth.login(_emailCtr.text.trim(), _passCtr.text.trim());
    if (!mounted) return;
    setState(() => _loading = false);
    if (err != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err)));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ProfilePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              controller: _emailCtr,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: _validateEmail,
            ),
            TextFormField(
              controller: _passCtr,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: _validatePass,
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _loading ? null : _submit, child: Text(_loading ? 'Loading...' : 'Login')),
            TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterPage())), child: const Text('Daftar baru'))
          ]),
        ),
      ),
    );
  }
}
