import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../location_provider/location_provider.dart';
import '../map_search_page/map_search_page.dart';

class AddressListPage extends StatefulWidget {
  const AddressListPage({super.key});

  @override
  State<AddressListPage> createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  int _selectedIndex = 0; // Default first item selected

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<LocationProvider>(context, listen: false);
    final savedIndex = provider.selectedDynamicAddressId;
    if (savedIndex != null) {
      _selectedIndex = savedIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocationProvider>(context);
    List<Map<String, dynamic>> addressList = List.from(provider.allLocations);
    // Ensure selected index is within bounds
    if (_selectedIndex >= addressList.length) _selectedIndex = 0;
    // Move selected address to top
    if (_selectedIndex != 0 && addressList.isNotEmpty) {
      addressList.sort((a, b) {final aIndex = provider.allLocations.indexOf(a);return aIndex == _selectedIndex ? -1 : 1;});
    }

    IconData getIcon(String iconName) {
      switch (iconName) {
        case 'home':
          return Icons.home;
        case 'work':
          return Icons.work;
        case 'favorite':
          return Icons.favorite_border;
        default:
          return Icons.location_on_outlined;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(elevation: 0, backgroundColor: Colors.white, foregroundColor: Colors.black, title: const Text("Addresses", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: addressList.length,
        itemBuilder: (context, index) {
          final item = addressList[index];
          final originalIndex = provider.allLocations.indexOf(item);
          return addressItem(
            icon: getIcon(item["icon"] ?? ""),
            title: item["title"] ?? "Home",
            address: item["street"] ?? "Unknown",
            note: item["note"] ?? "none",
            isSelected: index == 0,
            onSelect: () async {
              setState(() {_selectedIndex = originalIndex;});
              await provider.userSelectDynamicLocation(id: originalIndex);
            },
            onDelete: () async {
              final originalIndex = provider.allLocations.indexOf(item);
              if (_selectedIndex == originalIndex) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Selected address cannot be removed."), duration: Duration(seconds: 2),),);return;}
              if (provider.allLocations.length <= 1) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("At least one address must remain."), duration: Duration(seconds: 2),),);return;}
              await provider.deleteLocation(originalIndex);
              if (_selectedIndex > originalIndex) {setState(() {_selectedIndex -= 1;});}
            },
            onEdit: () {
              // Handle edit
            },
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(color: Colors.white),
          child: SizedBox(
            height: 55,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),),
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const MapSearchPage(),),);},
              child: const Text("Add New Address", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black,),),
            ),
          ),
        ),
      ),
    );
  }

  /// >>> Address Item Widget ==================================================
  Widget addressItem({required IconData icon, required String title, required String address, required String note, required bool isSelected, required VoidCallback onSelect, required VoidCallback onDelete, required VoidCallback onEdit,}) {
    return InkWell(
      onTap: onSelect,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: isSelected ? Colors.blue.shade50 : Colors.white,),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Radio(
              activeColor: Colors.pink,
              value: true,
              groupValue: isSelected,
              onChanged: (_) => onSelect(),
            ),
            Icon(icon, size: 30, color: Colors.black87),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  Text(address, style: const TextStyle(fontSize: 13)),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(padding: EdgeInsets.zero, constraints: const BoxConstraints(), icon: const Icon(Icons.edit_outlined, size: 20), onPressed: onEdit,),
                IconButton(padding: EdgeInsets.zero, constraints: const BoxConstraints(), icon: const Icon(Icons.delete_outline, size: 20), onPressed: onDelete,),
              ],
            ),
          ],
        ),
      ),
    );
  }
  /// <<< Address Item Widget ==================================================
}
