import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../supabase_client.dart';

class SidebarMenu extends StatelessWidget {
  final Function(int) onTabChange;

  const SidebarMenu({Key? key, required this.onTabChange}) : super(key: key);

  Future<void> _logout(BuildContext context) async {
    try {
      final supabase = await SupabaseClientManager.instance;
      await supabase.client.auth.signOut();
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Eshan',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'eshan@example.com',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(LineIcons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              onTabChange(2);
            },
          ),
          ListTile(
            leading: const Icon(LineIcons.leaf),
            title: const Text('Harvest'),
            onTap: () {
              Navigator.pop(context);
              onTabChange(0);
            },
          ),
          ListTile(
            leading: const Icon(LineIcons.user),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              onTabChange(1);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(LineIcons.alternateSignOut, color: Colors.red),
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }
}
