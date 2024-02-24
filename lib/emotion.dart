import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tensorflow_lite_flutter/tensorflow_lite_flutter.dart';


List<CameraDescription>?camera;

class emotion extends StatefulWidget {
  const emotion({super.key});

  @override
  State<emotion> createState() => _emotionState();
}

class _emotionState extends State<emotion> {
  CameraController? cameraController;
  String output='';
  String con="";
  loadcamera(){
    cameraController=CameraController(camera![0],ResolutionPreset.max);
    cameraController!.initialize().then((value) {
      if(!mounted){
        return;
      }
      else{
        setState(() {
          cameraController!.startImageStream((image) {
            runmodel(image);
          });
        });
      }
    });
  }
  runmodel(CameraImage img)async{
    var recognitions = await Tflite.runModelOnFrame(
        bytesList: img.planes.map((plane) {return plane.bytes;}).toList(),// required
        imageHeight: img.height,
        imageWidth: img.width,
        imageMean: 127.5,   // defaults to 127.5
        imageStd: 127.5,    // defaults to 127.5
        rotation: 90,       // defaults to 90, Android only
        numResults: 2,      // defaults to 5
        threshold: 0.1,     // defaults to 0.1
        asynch: true        // defaults to true
    );
    for(
    var element in recognitions!){
      setState(() {
        output=element['label'];
        con=element['confidence'];

      });
    }
  }
loadmodel()async{
  await  Tflite.loadModel(model: 'assets/model_unquant.tflite',labels: 'assets/labels.txt');
}
@override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadcamera();
    loadmodel();

  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cameraController!.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
body: Column(
  children: [
    Padding(
      padding: const EdgeInsets.all(50.0),
      child: Text("Emotion Detector",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
    ),
   Padding(
     padding: const EdgeInsets.all(8.0),
     child: Container(
      height: 400,
       width: double.infinity,

       decoration: BoxDecoration(
           color: Colors.red,
     borderRadius: BorderRadius.circular(20)
       ),
child: CameraPreview(cameraController!),
     ),
   ),
    SizedBox(height: 30,),
    Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(output,style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),),
        ),
        SizedBox(width: 10,),
        Center(
          child: Text(con,style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20
          ),),
        ),
      ],
    ),
SizedBox(height: 30,),
Text("Don't Forget to contact me on soical media "),
    SizedBox(height: 40,),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(Icons.telegram),
        Icon(Icons.facebook),
        Icon(Icons.messenger)
         ],
    ),
         ],
),
    );
  }
}
