import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../widgets/addName.dart';
part 'panstartbloc_event.dart';
part 'panstartbloc_state.dart';

class PanstartblocBloc extends Bloc<PanstartblocEvent, PanstartblocState> {
  PanstartblocBloc() : super(PanstartblocInitial()) {
    on<PanstartblocEvent>((event, emit) async {
      if (event is PanStart) {
        double startX = event.panStart.globalPosition.dx;
        double startY = event.panStart.globalPosition.dy;
        emit(PanStartState(startX: startX, startY: startY));
      }
      if (event is PanEnd) {
        bool isFinite = event.panEnd.primaryVelocity!.isFinite;
       
         String tagName = await Navigator.push(event.context,
            MaterialPageRoute(builder: (context) => const AddName()));
        // ignore: unnecessary_null_comparison
        if (tagName != null) {
          debugPrint('yaptı');
          emit(PanEndState(isFinite: isFinite, tagName: tagName));
        } 
      }
    });
  }
}
