import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/auth_model.dart';

class LoginScreen extends StatefulWidget {
const LoginScreen({super.key});

@override
State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
final _formKey = GlobalKey<FormState>();
final _emailController =
TextEditingController(text: 'student@example.com');
final _passwordController =
TextEditingController(text: 'flutter123');

bool _showPassword = false;

@override
void dispose() {
_emailController.dispose();
_passwordController.dispose();
super.dispose();
}

Future<void> _submit() async {
if (!_formKey.currentState!.validate()) return;

final auth = context.read<AuthModel>();
await auth.login(
  _emailController.text.trim(),
  _passwordController.text,
);

if (!mounted) return;

if (auth.errorMessage != null) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(auth.errorMessage!)),
  );
}

}

@override
Widget build(BuildContext context) {
debugPrint('LoginScreen.build()');

final isLoading = context.select<AuthModel, bool>(
  (auth) => auth.isLoading,
);

return Scaffold(
  appBar: AppBar(
    title: const Text('Авторизація'),
    centerTitle: true,
  ),
  body: Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.account_circle,
                size: 90,
                color: Colors.indigo,
              ),
              const SizedBox(height: 16),
              const Text(
                'Вхід у застосунок',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Тестовий акаунт: student@example.com',
                textAlign: TextAlign.center,
              ),
              const Text('Пароль: flutter123'),
              const SizedBox(height: 24),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  final email = value?.trim() ?? '';
                  final pattern = r'^[^@\s]+@[^@\s]+\.[^@\s]+$';

                  if (!RegExp(pattern).hasMatch(email)) {
                    return 'Введіть коректний email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: !_showPassword,
                decoration: InputDecoration(
                  labelText: 'Пароль',
                  prefixIcon: const Icon(Icons.lock),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                    icon: Icon(
                      _showPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
                validator: (value) {
                  if ((value ?? '').length < 8) {
                    return 'Пароль має містити щонайменше 8 символів';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _submit,
                  child: isLoading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Увійти'),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Авторизація імітується локально без сервера.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ),
  ),
);

}
}