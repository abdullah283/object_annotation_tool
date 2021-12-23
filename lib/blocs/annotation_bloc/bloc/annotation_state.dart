part of 'annotation_bloc.dart';

abstract class AnnotationState extends Equatable {
  const AnnotationState();

  @override
  List<Object> get props => [AnnotationState];
}

class AnnotationInitial extends AnnotationState {}

class PanEndState extends AnnotationState {
  final String tagName;
  const PanEndState({required this.tagName});
  @override
  List<Object> get props => [tagName];
}

class PanStartState extends AnnotationState {
  final double startX;
  final double startY;

  const PanStartState({required this.startX, required this.startY});
  @override
  List<Object> get props => [startX, startY];
}

class PanUpdateState extends AnnotationState {
  final double deltaX;
  final double deltaY;

  const PanUpdateState({
    required this.deltaX,
    required this.deltaY,
  });

  @override
  List<Object> get props => [deltaX, deltaY];
}
