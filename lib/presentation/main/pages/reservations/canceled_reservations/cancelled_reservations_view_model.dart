import 'package:rxdart/rxdart.dart';
import 'package:doctor_application/domain/models/models.dart';
import 'package:doctor_application/domain/useCase/cancel_reservation_use_case.dart';
import 'package:doctor_application/domain/useCase/done_reservation_use_case.dart';
import 'package:doctor_application/domain/useCase/get_cancelled_reservations_use_case.dart';
import 'package:doctor_application/presentation/base/base_view_model.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer_impl.dart';


class CancelledReservationsViewModel extends BaseViewModel with CancelledReservationsViewModelInputs, ReservationsViewModelOutputs {
  final BehaviorSubject  _cancelledReservationsStreamController = BehaviorSubject<CancelledReservationsViewObject>();
  final GetCancelledReservationsUseCase _getCancelledReservationsUseCase;
  final CancelReservationUseCase _cancelReservationUseCase;
  final DoneReservationUseCase _doneReservationUseCase;
  List<ReservationModel>? cancelledReservations;
  String patientId = '' ;


  CancelledReservationsViewModel(this._getCancelledReservationsUseCase, this._cancelReservationUseCase, this._doneReservationUseCase);

  @override
  void start() {
    getReservations();
  }

  @override
  void dispose() {
    super.dispose();
    _cancelledReservationsStreamController.close();
  }

  @override
  Sink get inputReservations => _cancelledReservationsStreamController.sink;

  getReservations() async {
    if(cancelledReservations == null) {
      inputState.add(LoadingState(
          stateRendererType: StateRendererType.fullScreenLoadingState));
    }


    (await _getCancelledReservationsUseCase.execute(GetCancelledReservationsUseCaseInputs(patientId))).fold((failure) {
      inputState.add(ErrorState(StateRendererType.fullScreenErrorState, failure.message));
    }, (data) {
      cancelledReservations = data.reservations;
      if(!_cancelledReservationsStreamController.isClosed) {
        inputReservations.add(
            CancelledReservationsViewObject(data.reservations ?? []));
      }

      if(!stateStreamController.isClosed) {
        inputState.add(ContentState());
      }
    });
  }


  @override
  Stream<CancelledReservationsViewObject> get outputReservations => _cancelledReservationsStreamController.stream.map((reservation) => reservation);

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

mixin class CancelledReservationsViewModelInputs{
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
  Stream<CancelledReservationsViewObject> get outputReservations {
    // TODO: implement outputReservations
    throw UnimplementedError();
  }
}

class CancelledReservationsViewObject {
  List<ReservationModel> cancelledReservations;

  CancelledReservationsViewObject(this.cancelledReservations);
}