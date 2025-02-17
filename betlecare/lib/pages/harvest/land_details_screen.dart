import 'package:flutter/material.dart';

import '../../widgets/appbar/app_bar.dart';

class LandDetailsScreen extends StatefulWidget {
  const LandDetailsScreen({Key? key}) : super(key: key);

  @override
  _LandDetailsScreenState createState() => _LandDetailsScreenState();
}

class _LandDetailsScreenState extends State<LandDetailsScreen> {
  List<Map<String, dynamic>> _lands = [
    {'name': 'මහවැලි ඉඩම', 'size': '2.5 අක්කර', 'location': 'අනුරාධපුරය'},
    {'name': 'කුඹුර', 'size': '1.75 අක්කර', 'location': 'පොලොන්නරුව'},
    {'name': 'ගෙවත්ත', 'size': '20 පර්චස්', 'location': 'කුරුණෑගල'},
    // Add more sample data as needed
  ];

  List<Map<String, dynamic>> _filteredLands = [];

  @override
  void initState() {
    _filteredLands = _lands;
    super.initState();
  }

  void _filterLands(String query) {
    setState(() {
      _filteredLands = _lands
          .where((land) =>
      land['name'].toLowerCase().contains(query.toLowerCase()) ||
          land['location'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _showLandDetails(BuildContext context, Map<String, dynamic> land) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(land['name']),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('ස්ථානය: ${land['location']}'),
              Text('ප්‍රමාණය: ${land['size']}'),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('වසන්න'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('මකන්න', style: TextStyle(color: Colors.red)),
              onPressed: () {
                _deleteLand(land);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteLand(Map<String, dynamic> land) {
    setState(() {
      _lands.remove(land);
      _filteredLands = List.from(_lands);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${land['name']} ඉවත් කරන ලදී')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(title: 'ඉඩම් විස්තර'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterLands,
              decoration: InputDecoration(
                labelText: 'සොයන්න',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredLands.length,
              itemBuilder: (context, index) {
                final land = _filteredLands[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Icon(Icons.landscape, color: Colors.white),
                    ),
                    title: Text(land['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${land['location']} | ${land['size']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.info_outline),
                      onPressed: () => _showLandDetails(context, land),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement add new land functionality
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}

