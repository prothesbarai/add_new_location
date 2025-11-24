import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../../pages/home_page/home_page.dart';
import '../global_fetch_location_area.dart';
import '../location_dont_allow_control_pages/global_denied_forever_page.dart';
import '../global_overlay_loading_and_update_hive.dart';

Widget buildGlobalPopupItem(BuildContext context) {
  bool isLoading = false;
  Box permissionFlagBox = Hive.box("GetAndStorePermissionFlag");
  String permissionFlag = permissionFlagBox.get("permission_flag");
  //final cartProvider = Provider.of<CartProvider>(context);
  return StatefulBuilder(
    builder: (context, setState) {
      return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
          contentPadding: EdgeInsets.zero,
          content: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 15,),
                    Text("Your current location", style: TextStyle(color: Color(0xFF0bceaf),fontSize: 21.7), textAlign: TextAlign.center,),
                    SizedBox(height: 5,),
                    ListTile(
                      leading: Icon(Icons.location_on_outlined, color: Color(0xFF0bceaf),size: 40,),
                      /*title: Consumer<DeliveryAreaProvider>(
                        builder: (context, provider, _) {
                          return Text(provider.selectedAreaName ?? "Detecting...", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),);
                        },
                      ),*/
                      subtitle: Text("Saved Location"),
                    ),
                    SizedBox(height: 20,),

                    permissionFlag == "granted"?
                    ElevatedButton(
                      onPressed: ()=>showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
                          contentPadding: EdgeInsets.zero,
                          content: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Are you sure ?",style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF0bceaf),fontSize: 20),),
                                    SizedBox(height: 15,),
                                    Text("If you change location, your cart will be removed.",style: TextStyle(color: Colors.black,fontSize: 16),textAlign: TextAlign.center,),
                                  ],
                                ),
                              ),


                              closeButton(context),
                            ],
                          ),
                          actions: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                        onPressed: ()=>Navigator.pop(context),
                                        style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0bceaf), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50),), padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),),
                                        child: Text("No",style: TextStyle(color: Colors.white),)
                                    ),
                                    SizedBox(width: 15,),
                                    ElevatedButton(
                                        onPressed: isLoading ? null : () async {
                                          setState(() {isLoading = true; });
                                          if(isLoading){if(context.mounted){OverlayLoadingAndUpdateHive.show(context, "Loading...",Colors.transparent, Colors.grey,Colors.grey);}}
                                          if(context.mounted){await FetchLocationArea.fetchLocation(context);}
                                          //cartProvider.clearCart();
                                          setState(() {isLoading = false; });
                                          if(!isLoading){if(context.mounted){OverlayLoadingAndUpdateHive.hide(context);}}
                                          if (context.mounted) {
                                            Navigator.pop(context);
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()),);
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0bceaf), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50),), padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),),
                                        child: Text("Yes",style: TextStyle(color: Colors.white),)
                                    )
                                  ],
                                ),
                                SizedBox(height: 15),
                              ],
                            )
                          ],
                        ),
                      ),

                      style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0bceaf), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50),), padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.gps_fixed, color: Colors.white),
                          SizedBox(width: 10,),
                          Text("Update location using GPS", style: TextStyle(color: Colors.white,fontSize: 14),)
                        ],
                      ),
                    ):
                    ElevatedButton(
                      onPressed: ()=> showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
                          contentPadding: EdgeInsets.zero,
                          content: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Firstly Need Your Location Permission",style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF0bceaf),fontSize: 20),),
                                  ],
                                ),
                              ),


                              closeButton(context),
                            ],
                          ),
                          actions: [
                            ElevatedButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => GlobalDeniedForeverPage(),));
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0bceaf), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50),), padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),),
                                child: Text("OK",style: TextStyle(color: Colors.white),)
                            ),
                          ],
                        ),
                      ),
                      style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0bceaf), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50),), padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.gps_fixed, color: Colors.white),
                          SizedBox(width: 10,),
                          Text("Need permission for GPS", style: TextStyle(color: Colors.white,fontSize: 14),)
                        ],
                      ),
                    ),

                    SizedBox(height: 10,),


                    ElevatedButton(
                      onPressed: ()=>showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
                          contentPadding: EdgeInsets.zero,
                          content: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Are you sure ?",style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF0bceaf),fontSize: 20),),
                                    SizedBox(height: 15,),
                                    Text("If you change location, your cart will be removed.",style: TextStyle(color: Colors.black,fontSize: 16),textAlign: TextAlign.center,),
                                  ],
                                ),
                              ),


                              closeButton(context),
                            ],
                          ),
                          actions: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                        onPressed: ()=>Navigator.pop(context),
                                        style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0bceaf), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50),), padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),),
                                        child: Text("No",style: TextStyle(color: Colors.white),)
                                    ),
                                    SizedBox(width: 15,),
                                    ElevatedButton(
                                        onPressed: (){
                                          Navigator.pop(context);
                                          //Navigator.push(context, MaterialPageRoute(builder: (context) => DeliveryAreaPointSelectPage(showHeaderFooter: true,showCurrentDeliveryPoint: true,),));
                                        },
                                        style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0bceaf), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50),), padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),),
                                        child: Text("Yes",style: TextStyle(color: Colors.white),)
                                    )
                                  ],
                                ),
                                SizedBox(height: 15,),
                              ],
                            )
                          ],
                        ),
                      ),

                      style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFffff00), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50),), padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.location_on_outlined, color: Color(0xFF0bceaf)),
                          SizedBox(width: 10,),
                          Text("Update your location manually", style: TextStyle(color: Color(0xFF0bceaf),fontSize: 14),)
                        ],
                      ),
                    )

                  ],
                ),
              ),


              closeButton(context),
            ],
          )
      );
    },
  );
}



Widget closeButton(BuildContext context) {
  return Positioned(
    right: 5,
    top: 5,
    child: GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle,border: Border.all(color: Colors.red,width: 1)),
        padding: EdgeInsets.all(3),
        child: Icon(Icons.close, color: Colors.red, size: 20),
      ),
    ),
  );
}




