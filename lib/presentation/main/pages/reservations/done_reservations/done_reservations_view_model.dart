import 'package:rxdart/rxdart.dart';
import 'package:doctor_application/domain/models/models.dart';
import 'package:doctor_application/domain/useCase/cancel_reservation_use_case.dart';
import 'package:doctor_application/domain/useCase/done_reservation_use_case.dart';
import 'package:doctor_application/domain/useCase/get_done_reservations_use_case.dart';
import 'package:doctor_application/presentation/base/base_view_model.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer_impl.dart';


class DoneReservationsViewModel extends BaseViewModel with DoneReservationsViewModelInputs, ReservationsViewModelOutputs {
  final BehaviorSubject  _doneReservationsStreamController = BehaviorSubject<DoneReservationsViewObject>();
  final GetDoneReservationsUseCase _getDoneReservationsUseCase;
  final CancelReservationUseCase _cancelReservationUseCase;
  final DoneReservationUseCase _doneReservationUseCase;
  List<ReservationModel>? doneReservations;
  String patientId = '' ;


  DoneReservationsViewModel(this._getDoneReservationsUseCase, this._cancelReservationUseCase, this._doneReservationUseCase);

  @override
  void start() {
    getReservations();
  }

  @override
  void dispose() {
    super.dispose();
    _doneReservationsStreamController.close();
  }

  @override
  Sink get inputReservations => _doneReservationsStreamController.sink;

  getReservations() async {
    if(doneReservations == null) {
      inputState.add(LoadingState(
          stateRendererType: StateRendererType.fullScreenLoadingState));
    }


    (await _getDoneReservationsUseCase.execute(GetDoneReservationsUseCaseInputs(patientId))).fold((failure) {
      inputState.add(ErrorState(StateRendererType.fullScreenErrorState, failure.message));
    }, (data) {
      doneReservations = data.reservations;
      if(!_doneReservationsStreamController.isClosed) {
        inputReservations.add(
            DoneReservationsViewObject(data.reservations ?? []));
      }

      if(!stateStreamController.isClosed) {
        inputState.add(ContentState());
      }
    });
  }


  @override
  Stream<DoneReservationsViewObject> get outputReservations => _doneReservationsStreamController.stream.map((reservation) => reservation);

  @override
  cancelReservation(String reservationId) async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.popupLoadingState));
    (await _cancelReservationUseCase.execute(CancelReservationUseCaseInput(reservationId))).fold((failure) {
      inputState.add(ErrorState(StateRendererType.popupErrorState, failure.message));
    }, (data) async {
      await getReservations();
      inputState.add(ContentState());
    });
  }

  @override
  doneReservation(String reservationId) async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.popupLoadingState));
    (await _doneReservationUseCase.execute(DoneReservationUseCaseInput(reservationId))).fold((failure) {
      inputState.add(ErrorState(StateRendererType.popupErrorState, failure.message));
    }, (data) async {
      await getReservations();
      inputState.add(ContentState());
    });
  }
}

mixin class DoneReservationsViewModelInputs{
  cancelReservation(String reservationId) {
    // TODO: implement cancelReservation
    throw UnimplementedError();
  }
  doneReservation(String reservationId) {
    // TODO: implement doneReservation
    throw UnimplementedError();
  }
  Sink get inputReservations {
    // TODO: implement inputReservations
    throw UnimplementedError();
  }
}

mixin class ReservationsViewModelOutputs{
  Stream<DoneReservationsViewObject> get outputReservations {
    // TODO: implement outputReservations
    throw UnimplementedError();
  }
}

class DoneReservationsViewObject {
  List<ReservationModel> doneReservations;

  DoneReservationsViewObject(this.doneReservations);
}