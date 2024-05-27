import 'package:flutter/material.dart';
import 'package:projekakhir/home.dart';
import 'package:projekakhir/login_screen.dart';
import 'package:projekakhir/profile_screen.dart';
import 'package:projekakhir/saran_kesan_screen.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    HomeScreen(),
    SaranKesanScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logOut() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feedback),
            label: 'Saran Kesan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 255, 238, 0),
        unselectedItemColor: Colors.grey, // warna item yang tidak dipilih
        backgroundColor: const Color.fromARGB(255, 0, 0, 0), // warna latar belakang
        onTap: (index) {
          if (index == 3) {
            _logOut(); // jika tombol logout ditekan, panggil fungsi log out
          } else {
            _onItemTapped(index);
          }
        },
      ),
    );
  }
}
