import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../global_location_permission_service.dart';


class GlobalDeniedForeverPage extends StatefulWidget {
  const GlobalDeniedForeverPage({super.key});

  @override
  State<GlobalDeniedForeverPage> createState() => _GlobalDeniedForeverPageState();
}

class _GlobalDeniedForeverPageState extends State<GlobalDeniedForeverPage>{

  bool isChecked = false;


  Future<void> _openAppSettings() async {
    final opened = await Geolocator.openAppSettings();
    setState(() {isChecked = opened;});
  }


  Future<void> _callPermision() async {
    if (mounted){await LocationPermissionService.fetchPermission(context);}
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 20.0,left: 20.0,right: 20.0,bottom: 55.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: 80,),
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.red,
                    child: Icon(Icons.location_on_outlined,size: 100,color: Colors.white,),
                  ),
                  Column(
                    children: [
                      SizedBox(height: 30,),
                      Text("Without your location, we are unable to show products",style: TextStyle(color: Colors.black,fontSize: 27, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                      SizedBox(height: 30,),
                      Text(
                        "Please turn on location service in settings or enter your location manually to see our products",
                        style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18,color: Colors.green),softWrap: true,textAlign: TextAlign.center,),
                      SizedBox(height: 20,)
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: isChecked ? _callPermision :_openAppSettings,
                        style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(174, 1, 106, 1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50),), padding: EdgeInsets.symmetric(vertical: 15)),
                        child: Text("Go to Settings",style: TextStyle(color: Colors.white),)
                    ),
                  ),
                  SizedBox(height: 10,),
                ],
              )
            ],
          ),
        ),
      )

    );
  }
}