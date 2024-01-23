import 'package:rxdart/rxdart.dart';
import 'package:doctor_application/domain/models/models.dart';
import 'package:doctor_application/domain/useCase/cancel_reservation_use_case.dart';
import 'package:doctor_application/domain/useCase/done_reservation_use_case.dart';
import 'package:doctor_application/domain/useCase/get_reservations_use_case.dart';
import 'package:doctor_application/presentation/base/base_view_model.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer_impl.dart';


class ActiveReservationsViewModel extends BaseViewModel with ReservationsViewModelInputs, ReservationsViewModelOutputs {
  final BehaviorSubject  _activeReservationsStreamController = BehaviorSubject<ReservationsViewObject>();
  final BehaviorSubject  isDoneStreamController = BehaviorSubject<bool>();
  final BehaviorSubject  isCanceledStreamController = BehaviorSubject<bool>();
  final GetActiveReservationsUseCase _getActiveReservationsUseCase;
  final CancelReservationUseCase _cancelReservationUseCase;
  final DoneReservationUseCase _doneReservationUseCase;
  List<ReservationModel>? reservations;
  String patientId = '' ;


  ActiveReservationsViewModel(this._getActiveReservationsUseCase, this._cancelReservationUseCase, this._doneReservationUseCase);

  @override
  void start() {
    getReservations();
  }

  @override
  void dispose() {
    super.dispose();
    _activeReservationsStreamController.close();
    isDoneStreamController.close();
    isCanceledStreamController.close();
  }

  @override
  Sink get inputReservations => _activeReservationsStreamController.sink;

  getReservations() async {
    if(reservations == null) {
      inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    }


    (await _getActiveReservationsUseCase.execute(GetActiveReservationsUseCaseInputs(patientId))).fold((failure) {
      inputState.add(ErrorState(StateRendererType.fullScreenErrorState, failure.message));
    }, (data) {
      reservations = data.reservations;
      if(!_activeReservationsStreamController.isClosed) {
        inputReservations.add(ReservationsViewObject(data.reservations ?? []));
      }

      if(!stateStreamController.isClosed) {
        inputState.add(ContentState());
      }
    });
  }


  @override
  Stream<ReservationsViewObject> get outputReservations => _activeReservationsStreamController.stream.map((reservation) => reservation);

  @override
  cancelReservation(String reservationId) async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.popupLoadingState));
    (await _cancelReservationUseCase.execute(CancelReservationUseCaseInput(reservationId))).fold((failure) {
    inputState.add(ErrorState(StateRendererType.popupErrorState, failure.message));
    }, (data) async {
      await getReservations();
      isCanceledStreamController.add(true);
      if(!stateStreamController.isClosed) {
        inputState.add(ContentState());
      }
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
      isDoneStreamController.add(true);
      if(!stateStreamController.isClosed) {
        inputState.add(ContentState());
      }
      });
  }
}

mixin class ReservationsViewModelInputs{
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
  Stream<ReservationsViewObject> get outputReservations {
    // TODO: implement outputReservations
    throw UnimplementedError();
  }
}

class ReservationsViewObject {
  List<ReservationModel> reservations;

  ReservationsViewObject(this.reservations);
}