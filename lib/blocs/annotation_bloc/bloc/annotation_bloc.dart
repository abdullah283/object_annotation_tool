import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:object_annotation_tool/widgets/addName.dart';

part 'annotation_event.dart';
part 'annotation_state.dart';

class AnnotationBloc extends Bloc<AnnotationEvent, AnnotationState> {
  AnnotationBloc() : super(AnnotationInitial()) {
    on<AnnotationEvent>((event, emit) async {
      /***************************************************************/
      if (event is PanEndEvent) {
        String tagName = await Navigator.push(event.context,
            MaterialPageRoute(builder: (context) => const AddName()));
        if (tagName.isNotEmpty) {
          emit(PanEndState(tagName: tagName));
        }
      }
      /***************************************************************/
      if (event is PanStartEvent) {
        double startX = event.panStartEvent.globalPosition.dx;
        double startY = event.panStartEvent.globalPosition.dy;
        emit(PanStartState(startX: startX, startY: startY));
      }
      /***************************************************************/
      if (event is PanUpdateEvent) {
        double deltaX = event.panUpdateEvent.globalPosition.dx;
        double deltaY = event.panUpdateEvent.globalPosition.dy;
        emit(PanUpdateState(
          deltaX: deltaX,
          deltaY: deltaY,
        ));
      }
    });
  }
}
