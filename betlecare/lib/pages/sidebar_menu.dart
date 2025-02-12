import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class SidebarMenu extends StatelessWidget {
  final Function(int) onTabChange;
  final Function(BuildContext) onLogout;

  const SidebarMenu({
    Key? key,
    required this.onTabChange,
    required this.onLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Eshan'),
            accountEmail: const Text('eshan@example.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: const AssetImage('assets/images/profile.png'),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            leading: const Icon(LineIcons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              onTabChange(2); // Assuming Home is at index 2
            },
          ),
          ListTile(
            leading: const Icon(LineIcons.leaf),
            title: const Text('Harvest'),
            onTap: () {
              Navigator.pop(context);
              onTabChange(0); // Assuming Harvest is at index 0
            },
          ),
          ListTile(
            leading: const Icon(LineIcons.user),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              onTabChange(1); // Assuming Profile is at index 1
            },
          ),
          const Divider(),
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

