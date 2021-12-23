import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'annotation_event.dart';
part 'annotation_state.dart';

class AnnotationBloc extends Bloc<AnnotationEvent, AnnotationState> {
  AnnotationBloc() : super(PanUpdateState(lateX: 0, lateY: 0)) {
    double? deltaX;
    double? deltaY;
    on<AnnotationEvent>((event, emit) {
      if (event is PanUpdate) {
        deltaX = event.panUpdate.globalPosition.dx;
        deltaY = event.panUpdate.globalPosition.dy;
        emit(PanUpdateState(
          lateX: deltaX!,
          lateY: deltaY!,
        ));
      }
    });
  }
}
