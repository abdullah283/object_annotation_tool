import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:object_annotation_tool/blocs/annotation_bloc/bloc/annotation_bloc.dart';

class ReturnCreatedBox extends StatefulWidget {
  const ReturnCreatedBox(
      {required this.top,
      required this.left,
      required this.right,
      required this.bottom,
      required this.widhtX,
      required this.heightY,
      Key? key})
      : super(key: key);
  final double top;
  final double left;
  final double right;
  final double bottom;
  final double heightY;
  final double widhtX;
  @override
  State<ReturnCreatedBox> createState() => _ReturnCreatedBoxState();
}

class _ReturnCreatedBoxState extends State<ReturnCreatedBox> {
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
  late Stack stack;
  @override
  Widget build(BuildContext context) {
    AnnotationBloc _annotationBloc = BlocProvider.of<AnnotationBloc>(context);
    return BlocBuilder<AnnotationBloc, AnnotationState>(
        bloc: _annotationBloc,
        builder: (context, _panEndState) {
          if (_panEndState is PanEndState) {
            Positioned sizeBox = Positioned(
                top: widget.top,
                left: widget.left,
                right: widget.right,
                bottom: widget.bottom,
                child: Center(
                  child: Container(
                    height: widget.heightY,
                    width: widget.widhtX,
                    child: Text(
                      _panEndState.tagName,
                      style: TextStyle(
                          color: Colors.orangeAccent,
                          fontSize: widget.heightY > widget.widhtX
                              ? widget.widhtX / 4
                              : widget.heightY / 4),
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2)),
                  ),
                ));
            widgets.add(sizeBox);
            stack = Stack(children: widgets.map((e) => e).toList());
            return stack;
          } else {
            return widgets.length == 1 ? const SizedBox() : stack;
          }
        });
  }
}
