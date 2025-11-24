import 'package:flutter/material.dart';
import '../global_location_permission_service.dart';

class GlobalPermissionCheckIntroPage extends StatefulWidget {
  const GlobalPermissionCheckIntroPage({super.key});

  @override
  State<GlobalPermissionCheckIntroPage> createState() => _GlobalPermissionCheckIntroPageState();
}
class _GlobalPermissionCheckIntroPageState extends State<GlobalPermissionCheckIntroPage> {

  bool _isProcessing = false;


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
                    backgroundColor: Color.fromRGBO(174, 1, 106, 1),
                    child: Icon(Icons.location_on_outlined,size: 100,color: Colors.white,),
                  ),
                  Column(
                    children: [
                      SizedBox(height: 30,),
                      Text("Asking your location access for :",style: TextStyle(color:Color.fromRGBO(174, 1, 106, 1),fontSize: 25, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                      SizedBox(height: 30,),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(border: Border.all(color: Color.fromRGBO(174, 1, 106, 1)), borderRadius: BorderRadius.circular(50)),
                                padding: EdgeInsets.all(6.0),
                                child: Icon(Icons.star,color: Color.fromRGBO(174, 1, 106, 1),size: 18,)
                            ),
                            SizedBox(width: 15),
                            Expanded(child: Text("Show Store",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),softWrap: true,),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(border: Border.all(color: Color.fromRGBO(174, 1, 106, 1)), borderRadius: BorderRadius.circular(50)),
                                padding: EdgeInsets.all(6.0),
                                child: Icon(Icons.star,color: Color.fromRGBO(174, 1, 106, 1),size: 18,)
                            ),
                            SizedBox(width: 15),
                            Expanded(child: Text("Finding the nearby shop from you",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),softWrap: true,),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(border: Border.all(color: Color.fromRGBO(174, 1, 106, 1)), borderRadius: BorderRadius.circular(50)),
                                padding: EdgeInsets.all(6.0),
                                child: Icon(Icons.star,color: Color.fromRGBO(174, 1, 106, 1),size: 18,)
                            ),
                            SizedBox(width: 15),
                            Expanded(child: Text("Faster delivery",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),softWrap: true,),),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: _isProcessing ? null : () async{
                      setState(() { _isProcessing = true; });
                      await LocationPermissionService.fetchPermission(context);
                      setState(() { _isProcessing = false; });
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(174, 1, 106, 1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50),), padding: EdgeInsets.symmetric(vertical: 15)),
                    child: Text("Continue",style: TextStyle(color: Colors.white),)
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}