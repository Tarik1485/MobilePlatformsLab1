import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/auth_model.dart';
import '../models/profile_model.dart';
import 'edit_profile_screen.dart';

class HomeScreen extends StatelessWidget {
const HomeScreen({super.key});

@override
Widget build(BuildContext context) {
debugPrint('HomeScreen build()');

return Scaffold(
  appBar: AppBar(
    title: const Text('Мій профіль'),
    actions: [
      Consumer<AuthModel>(
        builder: (context, auth, child) {
          return IconButton(
            tooltip: 'Вийти',
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthModel>().logout();
            },
          );
        },
      ),
    ],
  ),
  body: Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 48,
            child: Icon(
              Icons.person,
              size: 55,
            ),
          ),
          const SizedBox(height: 20),

          Selector<ProfileModel, String>(
            selector: (context, profile) => profile.name,
            builder: (context, name, child) {
              debugPrint('Selector name builder()');

              return Text(
                'Вітаємо, $name!',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              );
            },
          ),

          const SizedBox(height: 12),

          Selector<ProfileModel, String>(
            selector: (context, profile) => profile.email,
            builder: (context, email, child) {
              return Text('Email: $email');
            },
          ),

          const SizedBox(height: 12),

          Selector<ProfileModel, String>(
            selector: (context, profile) => profile.about,
            builder: (context, about, child) {
              return Text(
                about,
                textAlign: TextAlign.center,
              );
            },
          ),

          const SizedBox(height: 24),

          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfileScreen(),
                ),
              );
            },
            icon: const Icon(Icons.edit),
            label: const Text('Редагувати профіль'),
          ),
        ],
      ),
    ),
  ),
);

}
}
