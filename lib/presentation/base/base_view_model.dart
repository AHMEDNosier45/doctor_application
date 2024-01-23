
import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel extends BaseViewModelInputs with BaseViewModelOutputs{
 final BehaviorSubject stateStreamController = BehaviorSubject<FlowState>();

 @override
 void dispose(){
  stateStreamController.close();
 }

 @override
 Sink get inputState => stateStreamController.sink;

 @override
 Stream<FlowState> get outPutState => stateStreamController.stream.map((flowState) => flowState);
}


abstract class BaseViewModelInputs{
 void start();
 void dispose();

 Sink get inputState;
}
mixin class BaseViewModelOutputs{
 Stream<FlowState> get outPutState {
   // TODO: implement outPutState
   throw UnimplementedError();
 }
}