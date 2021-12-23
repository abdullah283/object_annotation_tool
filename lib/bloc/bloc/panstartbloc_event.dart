// ignore_for_file: must_be_immutable

part of 'panstartbloc_bloc.dart';

abstract class PanstartblocEvent extends Equatable {
  const PanstartblocEvent();

  @override
  List<Object> get props => [];
}

class PanStart extends PanstartblocEvent {
  DragStartDetails panStart;
  PanStart({required this.panStart});
  @override
  List<Object> get props => [panStart];
}

class PanEnd extends PanstartblocEvent {
  DragEndDetails panEnd;
  BuildContext context;
  PanEnd({required this.panEnd, required this.context});
  @override
  List<Object> get props => [panEnd, context];
}
