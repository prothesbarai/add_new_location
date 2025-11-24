import 'package:flutter/material.dart';

class DemoPage extends StatelessWidget {
  final String welcome;
  const DemoPage({super.key,required this.welcome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(foregroundColor: Colors.black,title: Text(welcome),centerTitle: true,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(welcome,style: TextStyle(color: Colors.pink,fontSize: 28,fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}
