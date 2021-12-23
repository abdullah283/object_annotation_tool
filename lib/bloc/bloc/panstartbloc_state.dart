// ignore_for_file: must_be_immutable

part of 'panstartbloc_bloc.dart';

abstract class PanstartblocState extends Equatable {
  const PanstartblocState();

  @override
  List<Object> get props => [PanstartblocState];
}

class PanstartblocInitial extends PanstartblocState {}

class PanStartState extends PanstartblocState {
  double startX;
  double startY;

  PanStartState({required this.startX, required this.startY});
  @override
  List<Object> get props => [startX, startY];
}

class PanEndState extends PanstartblocState {
  bool isFinite;
  String tagName;
  PanEndState({required this.isFinite, required this.tagName});
  @override
  List<Object> get props => [isFinite, tagName];
}
