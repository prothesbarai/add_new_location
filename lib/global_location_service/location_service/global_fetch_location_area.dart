import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:turf/along.dart' as turf;
import 'package:uuid/uuid.dart';
import '../location_provider/location_provider.dart';

class FetchLocationArea {
  static Future<void> fetchLocation(BuildContext context) async{
    final provider = Provider.of<LocationProvider>(context, listen: false);
    try{
      Position position = await Geolocator.getCurrentPosition(locationSettings: LocationSettings(accuracy: LocationAccuracy.high,distanceFilter: 0));
      final userPosition = turf.Position(position.longitude, position.latitude);


      await setLocaleIdentifier("en_US");
      List<Placemark> placeMark = await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placeMark[0];

      debugPrint("Turf User Position Location : $userPosition");
      debugPrint("Name : ${place.name} street : ${place.street}, administrativeArea(Division) : ${place.administrativeArea}, subAdministrativeArea (District): ${place.subAdministrativeArea}, thoroughfare: ${place.thoroughfare}, subThoroughfare: ${place.subThoroughfare}, locality(Area): ${place.locality}, subLocality(Sub-Area): ${place.subLocality}, postalCode: ${place.postalCode}, isoCountryCode: ${place.isoCountryCode}, country: ${place.country}");

      if (context.mounted) {
        await provider.addLocation({
          'id': const Uuid().v4(), // Unique ID
          'userLong': position.longitude,
          'userLat': position.latitude,
          'street': "${place.name}",
          'icon': 'home',
          'areaName': '${place.subLocality}',
          'title': 'Home' // Default Title
        });
      }

    }catch(e){
      debugPrint("Error fetching location: $e");
    }
  }

}

