import 'package:flutter/material.dart';

class drawerPage extends StatelessWidget {
  const drawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              "Diabetes care taker",
            ),
            accountEmail: Text("diabetescaretaker@gmail.com"),
          ),
          ListTile(
            horizontalTitleGap: 0,
            onTap: () {},
            leading: Icon(Icons.library_books),
            title: Text(
              "Diabetes Education library",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          ListTile(
            horizontalTitleGap: 0,
            onTap: () {},
            leading: Icon(Icons.library_books),
            title: Text(
              "Exercise Tracking",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          ListTile(
            horizontalTitleGap: 0,
            onTap: () {},
            leading: Icon(Icons.library_books),
            title: Text(
              "Diabetes Related Test Reminders",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          ListTile(
            horizontalTitleGap: 0,
            onTap: () {},
            leading: Icon(Icons.library_books),
            title: Text(
              "Emergency Alert",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Divider(
            thickness: 2,
          ),
          ListTile(
            horizontalTitleGap: 0,
            onTap: () {},
            leading: Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: Text(
              "Logout",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }
}
