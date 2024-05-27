import 'package:flutter/material.dart';
import 'basenetwork.dart';
import 'fruitmodel.dart';
import 'detail_screen.dart';
import 'profile_screen.dart';
import 'saran_kesan_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Welcome>> futureFruits;
  List<Welcome> _allFruits = [];
  List<Welcome> _searchResults = [];
  TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    futureFruits = BaseNetwork.fetchFruits();
    futureFruits.then((fruits) {
      setState(() {
        _allFruits = fruits;
        _searchResults = fruits;
      });
    });
    _searchController.addListener(_filterFruits);
  }

  void _filterFruits() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _searchResults = _allFruits.where((fruit) {
        return fruit.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = <Widget>[
      buildFruitList(),
      ProfileScreen(),
      SaranKesanScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Fruit App'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search fruits by name...',
                border: InputBorder.none,
                icon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }

  Widget buildFruitList() {
    return Center(
      child: FutureBuilder<List<Welcome>>(
        future: futureFruits,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_searchResults[index].name),
                  subtitle: Text(_searchResults[index].family),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(fruit: _searchResults[index]),
                      ),
                    );
                  },
                );
              },
            );
          }
          return Text("No fruits found");
        },
      ),
    );
  }
}
