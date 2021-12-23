// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:object_annotation_tool/bloc/annotation_bloc.dart';
import 'package:object_annotation_tool/bloc/bloc/panstartbloc_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:object_annotation_tool/widgets/returnBox.dart';
import 'returnBox.dart';

class HomePage extends StatefulWidget {
  HomePage({this.tagName, Key? key}) : super(key: key);
  String? tagName;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double alignmentContainerX;
  late double alignmentContainerY;
  late double heightY;
  late double widhtX;
  late double lateX;
  late double lateY;
  late String tagName;
  File? imageFile;
  XFile? picture;
  final ImagePicker _imagePicker = ImagePicker();
  @override
  void initState() {
    alignmentContainerX = 1;
    alignmentContainerY = 1;
    heightY = 0;
    widhtX = 0;
    lateX = 0;
    lateY = 0;
    tagName = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AnnotationBloc _annotationBloc = BlocProvider.of<AnnotationBloc>(context);
    PanstartblocBloc _panStartBloc = BlocProvider.of<PanstartblocBloc>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.photo_camera),
          onPressed: () async {
            return await _openCamera(context).then((value) => setState(() {
                  imageFile = File(picture!.path);
                }));
          }),
      body: GestureDetector(
        onPanStart: (details) {
          debugPrint('start Calisti');
          return context
              .read<PanstartblocBloc>()
              .add(PanStart(panStart: details));
        },
        onPanEnd: (details) => context
            .read<PanstartblocBloc>()
            .add(PanEnd(panEnd: details, context: context)),
        onPanUpdate: (details) {
          debugPrint('update Calisti');
          return context
              .read<AnnotationBloc>()
              .add(PanUpdate(panUpdate: details));
        },
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: BlocBuilder<PanstartblocBloc, PanstartblocState>(
            bloc: _panStartBloc,
            builder: (context, panstartstate) {
              return BlocBuilder<AnnotationBloc, AnnotationState>(
                bloc: _annotationBloc,
                builder: (context, panupdatestate) {
                  if (panstartstate is PanStartState) {
                    alignmentContainerX = panstartstate.startX;
                    alignmentContainerY = panstartstate.startY;
                  }
                  if (panstartstate is PanEndState) {
                    tagName = panstartstate.tagName;
                  }
                  if (panupdatestate is PanUpdateState) {
                    lateX = panupdatestate.lateX;
                    lateY = panupdatestate.lateY;
                    heightY = (lateY - alignmentContainerY).abs();
                    widhtX = (lateX - alignmentContainerX).abs();
                    if (imageFile != null) {
                      if (lateY != 0 && lateX != 0) {
                        return Stack(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: Image.file(imageFile!, fit: BoxFit.cover),
                            ),
                            Positioned(
                                top: alignmentContainerY,
                                left: alignmentContainerX,
                                child: Container(
                                  height: heightY,
                                  width: widhtX,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 2)),
                                )),
                            ReturnBox(
                              alignmentContainerX: alignmentContainerX,
                              alignmentContainerY: alignmentContainerY,
                              widhtX: widhtX,
                              heightY: heightY,
                              tagName: tagName,
                            )
                          ],
                        );
                      } else {
                        return Stack(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: Image.file(imageFile!, fit: BoxFit.cover),
                            ),
                            const Positioned(
                                top: 350,
                                left: 100,
                                child: Text(
                                  'Create a box ',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 40),
                                ))
                          ],
                        );
                      }
                    } else {
                      return Center(
                        child: Container(
                          height: 180,
                          width: 250,
                          color: Colors.white,
                          child: Text(
                            'Take a photo ',
                            style: TextStyle(color: Colors.red, fontSize: 40),
                          ),
                        ),
                      );
                    }
                  } else {
                    return Center(
                      child: Container(
                        height: 180,
                        width: 250,
                        color: Colors.white,
                        child: Text(
                          'Take a photo ',
                          style: TextStyle(color: Colors.red, fontSize: 40),
                        ),
                      ),
                    );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Future<XFile?> _openCamera(BuildContext context) async {
    picture = await _imagePicker.pickImage(source: ImageSource.camera);
    return picture;
  }
}
