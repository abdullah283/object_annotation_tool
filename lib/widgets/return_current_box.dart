import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:object_annotation_tool/blocs/annotation_bloc/bloc/annotation_bloc.dart';
import 'return_created_box.dart';

class ReturnCurrentBox extends StatefulWidget {
  const ReturnCurrentBox({required this.imageFile, Key? key}) : super(key: key);
  final File imageFile;
  @override
  _ReturnCurrentBoxState createState() => _ReturnCurrentBoxState();
}

class _ReturnCurrentBoxState extends State<ReturnCurrentBox> {
  late double _alignmentContainerX;
  late double _alignmentContainerY;
  late double _heightY;
  late double _widhtX;
  late double _lateX;
  late double _lateY;
  late bool _control;
  @override
  void initState() {
    _alignmentContainerX = 0;
    _alignmentContainerY = 0;
    _heightY = 0;
    _widhtX = 0;
    _lateX = 0;
    _lateY = 0;
    _control = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AnnotationBloc _annotationBloc = BlocProvider.of<AnnotationBloc>(context);
    return Scaffold(
        body: GestureDetector(
      onPanStart: (details) {
        return context
            .read<AnnotationBloc>()
            .add(PanStartEvent(panStartEvent: details));
      },
      onPanUpdate: (details) {
        if (_control == true) {
          return context
              .read<AnnotationBloc>()
              .add(PanUpdateEvent(panUpdateEvent: details));
        }
      },
      onPanEnd: (details) {
        return context
            .read<AnnotationBloc>()
            .add(PanEndEvent(panEndEvent: details, context: context));
      },
//********* GESTURE DEDECTOR OLUŞTURULAN SİZEBOX YAPISINI DENETLİYOR *********//
      child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: BlocBuilder<AnnotationBloc, AnnotationState>(
              bloc: _annotationBloc,
              builder: (context, _annotationState) {
//*************** BU BOLUMDE BLOC YAPISINDAN GELEN VERİLER ALINIYOR **********//
                if (_annotationState is PanStartState) {
                  _alignmentContainerX = _annotationState.startX;
                  _alignmentContainerY = _annotationState.startY;
                  _heightY = 0;
                  _widhtX = 0;
                  _control = true;
                }
                if (_annotationState is PanEndState) {
                  _control = false;
                }
                if (_annotationState is PanUpdateState && _control == true) {
                  _lateX = _annotationState.deltaX;
                  _lateY = _annotationState.deltaY;
                  _heightY = (_lateY - _alignmentContainerY).abs();
                  _widhtX = (_lateX - _alignmentContainerX).abs();
                }
//********* BU BOLUMDE ELDE EDİLEN VERİLER STACK YAPISINA VERİLİYOR **********//
                if (_annotationState is AnnotationInitial) {
                  return Stack(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Image.file(widget.imageFile, fit: BoxFit.cover),
                      ),
                      Center(
                        child: Container(
                          color: Colors.white,
                          child: const Text(
                            'Create a box ',
                            style: TextStyle(color: Colors.amber, fontSize: 40),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Stack(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Image.file(widget.imageFile, fit: BoxFit.cover),
                      ),
                      Positioned(
                          top: _alignmentContainerY,
                          left: _alignmentContainerX,
                          child: Container(
                            height: _heightY,
                            width: _widhtX,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 2)),
                          )),
                      ReturnCreatedBox(
                        alignmentContainerX: _alignmentContainerX,
                        alignmentContainerY: _alignmentContainerY,
                        widhtX: _widhtX,
                        heightY: _heightY,
                      )
                    ],
                  );
                }
              })),
    ));
  }
}
