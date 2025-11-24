import 'package:flutter/material.dart';
import '../../global_location_service/add_address/address_list_page/address_list_page.dart';
import 'demo_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> gridItems = [
      {
        "icon": Icons.location_on,
        "title": "Location",
        "page": const AddressListPage(),
      },
      {
        "icon": Icons.person,
        "title": "Profile",
        "page": const DemoPage(welcome: "Profile",),
      },
      {
        "icon": Icons.settings,
        "title": "Settings",
        "page": const DemoPage(welcome: "Settings",),
      },
      {
        "icon": Icons.lock,
        "title": "Privacy",
        "page": const DemoPage(welcome: "Privacy",),
      },
      {
        "icon": Icons.info,
        "title": "About",
        "page": const DemoPage(welcome: "About",),
      },
      {
        "icon": Icons.help,
        "title": "Help",
        "page": const DemoPage(welcome: "Help",),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// >>> Logo Icon + Name Sections ==================================
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.account_circle, size: 58),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Account Title", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("Subtitle here", style: TextStyle(fontSize: 14, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
            /// <<< Logo Icon + Name Sections ==================================

            SizedBox(height: 16),

            /// >>> Grid Section ===============================================
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  itemCount: gridItems.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10,),
                  itemBuilder: (context, index) {
                    final item = gridItems[index];
                    return GestureDetector(
                      onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => item["page"]),);},
                      child: Card(
                        elevation: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(item["icon"], size: 32),
                            SizedBox(height: 8),
                            Text(item["title"]),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            /// <<< Grid Section ===============================================
          ],
        ),
      ),
    );
  }
}
