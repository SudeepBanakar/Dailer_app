import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';
import 'dail_pad_screen.dart';
import 'call_history_screen.dart';
import 'contact_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;
  final List<Widget> _screens = [
    ContactsScreen(),
    DialPadScreen(),
    CallHistoryScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Phone Dialer', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: Colors.white,
            ),
            onPressed: () => themeProvider.toggleTheme(),
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border, size: 28),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.access_time, color: Colors.white),
            ),
            label: 'Recents',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts, size: 28),
            label: 'Contacts',
          ),
        ],
      ),
    );
  }
}
