import 'package:awesome_place_search/awesome_place_search.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSearchPage extends StatefulWidget {
  const MapSearchPage({super.key});

  @override
  State<MapSearchPage> createState() => _MapSearchPageState();
}

class _MapSearchPageState extends State<MapSearchPage> {

  GoogleMapController? mapController;
  Marker? marker;
  String selectedAddress = "Search to select location";
  LatLng currentPos = const LatLng(23.8103, 90.4125);

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  /// >>> ============= GET CURRENT LOCATION ===================================
  Future<void> getCurrentLocation() async{
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {return;}
    final pos = await Geolocator.getCurrentPosition();
    setState(() {
      currentPos = LatLng(pos.latitude, pos.longitude);
      marker = Marker(markerId: const MarkerId("current"),position: currentPos); // Create New Marker
    });
    mapController?.animateCamera(CameraUpdate.newLatLngZoom(currentPos, 16),); // Map Go to Place and zoom place
  }
  /// <<< ============= GET CURRENT LOCATION ===================================

  /// >>> ============= UPDATE MAP LOCATION ====================================
  Future<void> updateMap(LatLng pos) async{
    setState(() {
      currentPos = pos;
      marker = Marker(markerId: const MarkerId("selected"),position: pos);
    });
    mapController?.animateCamera(CameraUpdate.newLatLngZoom(pos, 16));
    final place = await placemarkFromCoordinates(pos.latitude, pos.longitude);
    setState(() {
      selectedAddress = "${place.first.name ?? ""} ${place.first.street ?? ""}".trim();
    });
  }
  /// <<< ============= UPDATE MAP LOCATION ====================================

  /// >>> ============= OPEN MAP SEARCH BOX FROM BOTTOM DRAWER =================
  void _openSearch(){
    AwesomePlaceSearch(
        context: context,
        apiKey: "YOUR_GOOGLE_MAPS_API_KEY",
        hint: "Search your address",
        onTap: (Future<PredictionModel>value) async{
          PredictionModel place = await value;
          if(place.latitude != null && place.longitude != null){
            LatLng latLng = LatLng(place.latitude!, place.longitude!);
            mapController?.animateCamera(CameraUpdate.newLatLngZoom(latLng, 16));
            updateMap(latLng);
          }
        },
    ).show();
  }
  /// <<< ============= OPEN MAP SEARCH BOX FROM BOTTOM DRAWER =================


  /// >>> Return location back to previous screen ==============================
  void returnLocation(){Navigator.pop(context,{"name": selectedAddress, "lat": currentPos.latitude, "lng": currentPos.longitude,});}
  /// <<< Return location back to previous screen ==============================


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          /// >>> Show Google Map ==============================================
          GoogleMap(
            initialCameraPosition: CameraPosition(target: currentPos,zoom: 16),
            markers: marker != null ? {marker!} : {},
            onMapCreated: (controller) => mapController = controller,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            onTap: updateMap, // Tapping anywhere on the map will place a new marker
          ),
          // >>> Floating Button
          Positioned(
            bottom: 180,
            right: 20,
            child: FloatingActionButton(
              onPressed: () async {
                Position pos = await Geolocator.getCurrentPosition();
                LatLng latLng = LatLng(pos.latitude, pos.longitude);
                mapController?.animateCamera(CameraUpdate.newLatLngZoom(latLng, 16));
                setState(() {
                  marker = Marker(markerId: const MarkerId("current"), position: latLng);
                });
              },
              child: const Icon(Icons.my_location),
            ),
          ),
          /// <<< Show Google Map ==============================================


          /// >>> Top Search Button ============================================
          Positioned(
              top: 40,
              left: 20,
              right: 20,
              child: GestureDetector(
                onTap: _openSearch,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.grey),
                      const SizedBox(width: 10),
                      Expanded(child: Text(selectedAddress, style: const TextStyle(color: Colors.grey), overflow: TextOverflow.ellipsis,)),
                    ],
                  ),
                ),
              )
          ),
          /// <<< Top Search Button ============================================


          /// >>> BOTTOM CONFIRM CARD BUTTON ===================================
          if(!selectedAddress.contains("Search to select location"))...[
            Positioned(
              bottom: 40,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8,)],),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(selectedAddress, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: returnLocation,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.pink, minimumSize: const Size(double.infinity, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),),
                      child:Text("Confirm Location", style: TextStyle(fontSize: 16,color: Colors.black),),
                    ),
                  ],
                ),
              ),
            ),
          ],
          /// <<< BOTTOM CONFIRM CARD BUTTON ===================================

        ],
      ),
    );
  }
}
