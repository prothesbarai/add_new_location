import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../../pages/home_page/home_page.dart';
import '../location_provider/location_provider.dart';
import 'global_fetch_location_area.dart';
import 'location_dont_allow_control_pages/global_denied_forever_page.dart';
import 'global_overlay_loading_and_update_hive.dart';

class LocationPermissionService {

  static Future<void> fetchPermission(BuildContext context) async {
    final provider = Provider.of<LocationProvider>(context, listen: false);


    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Text("Your Location Service Off"),
            content: const Text("Please enable Location (GPS) to continue."),
            actions: [
              ElevatedButton(
                onPressed: () {Navigator.pop(context);},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade600,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                child: const Text("Cancel",style: TextStyle(color: Colors.white),),
              ),

              ElevatedButton(
                onPressed: () async {Navigator.pop(context);await Geolocator.openLocationSettings();},
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xffae026a),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                child: const Text("Enable",style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        );
      }
      return;
    }



    LocationPermission permission = await Geolocator.checkPermission();

    // Ask Every Time
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
        // Allow
        await provider.setFirstTime(false);
        await provider.setPermissionFlag("granted");

        if(context.mounted){OverlayLoadingAndUpdateHive.show(context, "Loading...",Colors.white,Color(0xffae026a),Color(0xffae026a));}
        if(context.mounted){await FetchLocationArea.fetchLocation(context);}
        if(context.mounted){OverlayLoadingAndUpdateHive.hide(context);}
        if (context.mounted) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()),);
        }
        return;
      } else if (permission == LocationPermission.deniedForever) {
        // Again Denied Forever
        await provider.setPermissionFlag("denied_forever");
        if (context.mounted) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GlobalDeniedForeverPage()),);
        }
        return;
      } else {
        // User Again Deny
        await provider.setPermissionFlag("denied");
        await Geolocator.openAppSettings();
        return;
      }
    }

    // Direct Allow
    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      await provider.setFirstTime(false);
      await provider.setPermissionFlag("granted");
      if (context.mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()),);
      }
      return;
    }

    //  Forever Denied
    if (permission == LocationPermission.deniedForever) {
      await provider.setPermissionFlag("denied_forever");
      if (context.mounted) {
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GlobalDeniedForeverPage()),);
      }
      return;
    }

  }
}