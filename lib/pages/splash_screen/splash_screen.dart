import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../global_location_service/location_provider/location_provider.dart';
import '../../global_location_service/location_service/location_dont_allow_control_pages/global_denied_forever_page.dart';
import '../../global_location_service/location_service/location_dont_allow_control_pages/global_permission_check_intro_page.dart';
import '../home_page/home_page.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkDeliveryArea();
    });
  }


  /// >>> =========================== Delivery Area Select And Decision Make Start Here ====================
  Future<void> _checkDeliveryArea() async {
    final provider = Provider.of<LocationProvider>(context, listen: false);
    final isFirstTime = provider.isFirstTime;
    final permissionFlag = provider.permissionFlag;
    Future.delayed(Duration.zero, () {
      if (!mounted) return;
      if (isFirstTime && permissionFlag == "denied") {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GlobalPermissionCheckIntroPage()),);
      } else if (isFirstTime && permissionFlag == "denied_forever") {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GlobalDeniedForeverPage()),);
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()),);
      }
    });
  }
  /// >>> =========================== Delivery Area Select And Decision Make End Here =======================


  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.white,
        body: Container(decoration: const BoxDecoration(color: Colors.blue),),
      ),
    );
  }
}
