
import 'package:camera/camera.dart';
import 'package:emotion_detector/emotion.dart';
import 'package:emotion_detector/new.dart';
import 'package:flutter/material.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
camera=await availableCameras();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: newww(),
  ));
}
