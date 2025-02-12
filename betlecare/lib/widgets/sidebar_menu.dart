import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class SidebarMenu extends StatelessWidget {
  final Function(BuildContext) onLogout;

  const SidebarMenu({Key? key, required this.onLogout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: const AssetImage('assets/images/profile.png'),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Eshan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const Text(
                  'eshan@example.com',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(LineIcons.user),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              // Add navigation to profile page
            },
          ),
          ListTile(
            leading: const Icon(LineIcons.cog),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              // Add navigation to settings page
            },
          ),
          ListTile(
            leading: const Icon(LineIcons.alternateSignOut),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              onLogout(context);
            },
          ),
        ],
      ),
    );
  }
}

