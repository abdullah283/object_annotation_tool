import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:object_annotation_tool/blocs/annotation_bloc/bloc/annotation_bloc.dart';
import 'package:object_annotation_tool/widgets/return_current_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? imageFile;
  XFile? picture;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//****************************FLOATİNGACTIONBUTTON ***************************//
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
            heroTag: 'camera',
            child: const Icon(Icons.photo_camera),
            onPressed: () async {
              return _openCamera(context).then((value) {
                if (value != null) {
                  imageFile = File(picture!.path);
                }
                if (imageFile != null) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return BlocProvider(
                      create: (context) => AnnotationBloc(),
                      child: ReturnCurrentBox(
                        imageFile: imageFile!,
                      ),
                    );
                  }));
                }
              });
            }),
        const SizedBox(
          height: 10,
        ),
        FloatingActionButton(
            heroTag: 'gallery',
            child: const Icon(Icons.photo_album),
            onPressed: () async {
              return _openGallery(context).then((value) {
                if (value != null) {
                  imageFile = File(picture!.path);
                }
                if (imageFile != null) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return BlocProvider(
                      create: (context) => AnnotationBloc(),
                      child: ReturnCurrentBox(
                        imageFile: imageFile!,
                      ),
                    );
                  }));
                }
              });
            })
      ]),
      body: Center(
        child: Container(
          color: Colors.white,
          child: const Text(
            'Take a photo ',
            style: TextStyle(color: Colors.amber, fontSize: 40),
          ),
        ),
      ),
    );
  }

//****************************** CAMERA FONCTION *****************************//
  Future<XFile?> _openCamera(BuildContext context) async {
    picture = await _imagePicker.pickImage(source: ImageSource.camera);
    return picture;
  }

//***************************** GALLERY FONCTION *****************************//
  Future<XFile?> _openGallery(BuildContext context) async {
    picture = await _imagePicker.pickImage(source: ImageSource.gallery);
    return picture;
  }
}
