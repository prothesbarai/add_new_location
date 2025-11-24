import 'package:flutter/material.dart';
import '../../global_location_service/add_address/address_list_page/address_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {


    final List<Map<String, dynamic>> gridItems = [
      {
        "icon": Icons.location_on,
        "title": "Location",
      },
      {
        "icon": Icons.person,
        "title": "Profile",
      },
      {
        "icon": Icons.settings,
        "title": "Settings",
      },
    ];


    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,foregroundColor: Colors.black,),
        body: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.account_circle, size: 48),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Account Title", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        Text("Subtitle here", style: TextStyle(fontSize: 14, color: Colors.grey),),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: gridItems.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10,),
                  itemBuilder: (context, index) {
                    final item = gridItems[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddressListPage(),));
                      },
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


              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("More content here...", style: TextStyle(fontSize: 16),),
              ),
            ],
          ),
        ),
    );
  }
}
