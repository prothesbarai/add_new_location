import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:awesome_place_search/awesome_place_search.dart';
import 'package:provider/provider.dart';
import '../location_provider/location_provider.dart';

/*class MapPickerPage extends StatefulWidget {
  const MapPickerPage({super.key});

  @override
  State<MapPickerPage> createState() => _MapPickerPageState();
}

class _MapPickerPageState extends State<MapPickerPage> {
  GoogleMapController? mapController;
  LatLng? selectedLatLng;
  CameraPosition initialCamera = const CameraPosition(
    target: LatLng(23.8103, 90.4125), // default Dhaka
    zoom: 16,
  );

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<LocationProvider>(context, listen: false);
    double lat = provider.locationMap['userLat'];
    double lng = provider.locationMap['userLong'];
    selectedLatLng = LatLng(lat, lng);
    initialCamera = CameraPosition(target: selectedLatLng!, zoom: 16);
  }

  // Search button logic
  void _openSearch() {
    AwesomePlaceSearch(
      context: context,
      apiKey: "YOUR_GOOGLE_MAPS_API_KEY",
      hint: "Search your address",
      onTap: (Future<PredictionModel> value) async {
        PredictionModel place = await value;
        if (place.latitude != null && place.longitude != null) {
          LatLng latLng = LatLng(place.latitude!, place.longitude!);
          mapController?.animateCamera(CameraUpdate.newLatLngZoom(latLng, 16));
          setState(() {
            selectedLatLng = latLng;
          });
        }
      },
    ).show();
  }

  // Confirm Location + Name dialog
  Future<void> _saveLocationDialog() async {
    final provider = Provider.of<LocationProvider>(context, listen: false);
    TextEditingController nameController = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Location Name"),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(hintText: "Enter location name"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (selectedLatLng != null && nameController.text.isNotEmpty) {
                final location = UserLocationModel(
                  name: nameController.text,
                  lat: selectedLatLng!.latitude,
                  lng: selectedLatLng!.longitude,
                  street: "",
                  level: ""
                );
                provider.addLocation(location);
                Navigator.pop(context); // close dialog
                Navigator.pop(context); // back to HomePage
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick Your Location"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _openSearch,
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: initialCamera,
        onMapCreated: (c) => mapController = c,
        onTap: (latLng) {
          setState(() {
            selectedLatLng = latLng;
          });
        },
        markers: selectedLatLng != null
            ? {
          Marker(
            markerId: const MarkerId("selected"),
            position: selectedLatLng!,
          )
        }
            : {},
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _saveLocationDialog,
        label: const Text("Confirm Location"),
        icon: const Icon(Icons.check),
      ),
    );
  }
}*/
// Update your existing MapPickerPage to return data
class MapPickerPage extends StatefulWidget {
  const MapPickerPage({super.key});

  @override
  State<MapPickerPage> createState() => _MapPickerPageState();
}

class _MapPickerPageState extends State<MapPickerPage> {
  GoogleMapController? mapController;
  LatLng? selectedLatLng;
  CameraPosition initialCamera = const CameraPosition(
    target: LatLng(23.8103, 90.4125),
    zoom: 16,
  );

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<LocationProvider>(context, listen: false);
    final locationMap = provider.locationMap;
    if (locationMap.isNotEmpty &&
        locationMap['userLat'] != null &&
        locationMap['userLong'] != null) {
      double lat = locationMap['userLat'];
      double lng = locationMap['userLong'];
      selectedLatLng = LatLng(lat, lng);
      initialCamera = CameraPosition(target: selectedLatLng!, zoom: 16);
    }
  }

  void _openSearch() {
    AwesomePlaceSearch(
      context: context,
      apiKey: "YOUR_GOOGLE_MAPS_API_KEY",
      hint: "Search your address",
      onTap: (Future<PredictionModel> value) async {
        PredictionModel place = await value;
        if (place.latitude != null && place.longitude != null) {
          LatLng latLng = LatLng(place.latitude!, place.longitude!);
          mapController?.animateCamera(CameraUpdate.newLatLngZoom(latLng, 16));
          setState(() {
            selectedLatLng = latLng;
          });
        }
      },
    ).show();
  }

  Future<void> _saveLocationDialog() async {
    TextEditingController nameController = TextEditingController();

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Location Name"),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(hintText: "Enter location name"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (selectedLatLng != null && nameController.text.isNotEmpty) {
                Navigator.pop(context, {
                  'name': nameController.text,
                  'lat': selectedLatLng!.latitude,
                  'lng': selectedLatLng!.longitude,
                });
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );

    if (result != null) {
      Navigator.pop(context, result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick Your Location"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _openSearch,
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: initialCamera,
        onMapCreated: (c) => mapController = c,
        onTap: (latLng) {
          setState(() {
            selectedLatLng = latLng;
          });
        },
        markers: selectedLatLng != null
            ? {
          Marker(
            markerId: const MarkerId("selected"),
            position: selectedLatLng!,
          )
        }
            : {},
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _saveLocationDialog,
        label: const Text("Confirm Location"),
        icon: const Icon(Icons.check),
      ),
    );
  }
}