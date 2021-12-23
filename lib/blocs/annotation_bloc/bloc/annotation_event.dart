part of 'annotation_bloc.dart';

abstract class AnnotationEvent extends Equatable {
  const AnnotationEvent();

  @override
  List<Object> get props => [AnnotationEvent];
}

class PanEndEvent extends AnnotationEvent {
  final DragEndDetails panEndEvent;
  final BuildContext context;
  const PanEndEvent({required this.panEndEvent, required this.context});
  @override
  List<Object> get props => [panEndEvent, context];
}

class PanStartEvent extends AnnotationEvent {
  final DragStartDetails panStartEvent;
  const PanStartEvent({required this.panStartEvent});
  @override
  List<Object> get props => [panStartEvent];
}

class PanUpdateEvent extends AnnotationEvent {
  final DragUpdateDetails panUpdateEvent;
  const PanUpdateEvent({required this.panUpdateEvent});
  @override
  List<Object> get props => [panUpdateEvent];
}
