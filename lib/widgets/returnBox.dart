import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:object_annotation_tool/bloc/annotation_bloc.dart';
import 'package:object_annotation_tool/bloc/bloc/panstartbloc_bloc.dart';

class ReturnBox extends StatefulWidget {
  ReturnBox(
      {required this.alignmentContainerX,
      required this.alignmentContainerY,
      required this.widhtX,
      required this.heightY,
      required this.tagName,
      Key? key})
      : super(key: key);
  double alignmentContainerX;
  double alignmentContainerY;
  double heightY;
  double widhtX;
  String tagName;
  @override
  State<ReturnBox> createState() => _ReturnBoxState();
}

class _ReturnBoxState extends State<ReturnBox> {
  List<Positioned> widgets = [
    Positioned(
        top: 0,
        left: 0,
        child: Container(
          height: 0,
          width: 0,
          color: Colors.black,
        )),
  ];
  Stack? stack;
  @override
  Widget build(BuildContext context) {
    PanstartblocBloc _panStartBloc = BlocProvider.of<PanstartblocBloc>(context);
    AnnotationBloc _annotationBloc = BlocProvider.of<AnnotationBloc>(context);
    return BlocBuilder<PanstartblocBloc, PanstartblocState>(
        bloc: _panStartBloc,
        builder: (context, panEndState) {
          if (panEndState is PanEndState) {
            Positioned sizeBox = Positioned(
                top: widget.alignmentContainerY,
                left: widget.alignmentContainerX,
                child: Container(
                  child: Text(
                    widget.tagName,
                    style: TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: widget.heightY > widget.widhtX
                            ? widget.widhtX / 4
                            : widget.heightY / 4),
                  ),
                  height: widget.heightY,
                  width: widget.widhtX,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2)),
                ));
            widgets.add(sizeBox);
            stack = Stack(children: widgets.map((e) => e).toList());
            return stack!;
          } else {
            return widgets.length == 1 ? Text('') : stack!;
          }
        });
  }
}
