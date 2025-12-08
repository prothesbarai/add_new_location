import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../global_location_service/add_address/address_list_page/address_list_page.dart';
import '../../global_location_service/location_provider/location_provider.dart';

class DemoPage extends StatelessWidget {
  final String welcome;
  const DemoPage({super.key,required this.welcome});

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    final selectedLocation = locationProvider.selectedLocation;

    if (selectedLocation != null) {
      if (kDebugMode) {
        print('=== SELECTED LOCATION ===');
        print('Title: ${selectedLocation['title']}');
        print('Street: ${selectedLocation['street']}');
        print('Area: ${selectedLocation['areaName']}');
        print('Latitude: ${selectedLocation['userLat']}');
        print('Longitude: ${selectedLocation['userLong']}');
        print('Icon: ${selectedLocation['icon']}');
        print('ID: ${selectedLocation['id']}');
        print('=======================');
      }

    } else {
      if (kDebugMode) {
        print('No location selected');
      }
    }

    IconData getIcon(String iconName) {
      switch (iconName) {
        case 'home': return Icons.home;
        case 'work': return Icons.work;
        case 'favorite': return Icons.favorite_border;
        default: return Icons.location_on_outlined;
      }
    }
    return Scaffold(
      appBar: AppBar(foregroundColor: Colors.black,title: Text(welcome),centerTitle: true,),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(welcome,style: TextStyle(color: Colors.pink,fontSize: 28,fontWeight: FontWeight.bold),),
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Address', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),),
                      const SizedBox(height: 10),
                      if (selectedLocation != null) ...[
                        Row(
                          children: [
                            Icon(getIcon(selectedLocation['icon'] ?? ''), color: Colors.blue,),
                            const SizedBox(width: 10),
                            Text(selectedLocation['title'] ?? 'Home', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600,),),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(selectedLocation['street'] ?? 'No address', style: const TextStyle(fontSize: 14),),
                        const SizedBox(height: 4),
                        Text(selectedLocation['areaName'] ?? '', style: const TextStyle(fontSize: 14, color: Colors.grey,),),
                        const SizedBox(height: 8),
                        Text('Coordinates: ${selectedLocation['userLat']?.toStringAsFixed(4)}, ''${selectedLocation['userLong']?.toStringAsFixed(4)}', style: const TextStyle(fontSize: 12, color: Colors.grey,),),
                      ] else ...[
                        const Text('No address selected'),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const AddressListPage(),),);},
                          child: const Text('Select Address'),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
