import 'package:emotion_detector/emotion.dart';
import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class newww extends StatefulWidget {
  const newww({super.key});

  @override
  State<newww> createState() => _newwwState();
}

class _newwwState extends State<newww> {
  void nav() {
    Future.delayed(Duration(seconds: 3), () {
      return Navigator.push(
          context, MaterialPageRoute(builder: (context) => emotion()));
    });
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    nav();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(100),
            child: Text("Please Wait",style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),),
          ),
          Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            )
          ),
        ],
      ),
    );
  }
}
