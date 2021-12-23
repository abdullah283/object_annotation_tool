part of 'annotation_bloc.dart';

abstract class AnnotationState extends Equatable {
  const AnnotationState();

  @override
  List<Object> get props => [AnnotationState];
}

class PanUpdateState extends AnnotationState {
  double lateX;
  double lateY;

  PanUpdateState({
    required this.lateX,
    required this.lateY,
  });

  @override
  List<Object> get props => [lateX, lateY];
}
