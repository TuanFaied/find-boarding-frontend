import 'package:flutter/material.dart';
import '../../allBoaardingHouseList.dart'; // Corrected typo in the import
import '../../Login/components/login_form.dart';
import '../../SearchPage.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    print('${UserData.currentUser?.imageUrl}');
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 133, 8),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 221, 133, 8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        'http://192.168.239.100:8000${UserData.currentUser?.imageUrl}'),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Hi,${UserData.currentUser?.username} ', 
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
         
          GestureDetector(
            onTap: () {
              
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 50,
              width: 370,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 236, 231, 143),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search),
                  SizedBox(width: 10),
                  Text('Search for boardings by university or faculty...'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
         
          Expanded(
            child: BoardingHouseList(),
          ),
        ],
      ),
    );
  }
}

