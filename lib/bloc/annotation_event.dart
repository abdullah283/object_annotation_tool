// ignore_for_file: must_be_immutable

part of 'annotation_bloc.dart';

abstract class AnnotationEvent extends Equatable {
  const AnnotationEvent();
}

class PanUpdate extends AnnotationEvent {
  DragUpdateDetails panUpdate;
  PanUpdate({required this.panUpdate});
  @override
  List<Object> get props => [panUpdate];
}
