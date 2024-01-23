// ignore_for_file: void_checks

import 'dart:async';
import 'dart:ffi';

import 'package:rxdart/rxdart.dart';
import 'package:doctor_application/domain/models/models.dart';
import 'package:doctor_application/domain/useCase/get_departments_use_case.dart';
import 'package:doctor_application/presentation/base/base_view_model.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer_impl.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInput, HomeViewModelOutput {
  final BehaviorSubject _homeDataStreamController = BehaviorSubject<HomeViewObject>();
  final GetDepartmentsUseCase _getDepartmentsUseCase;

  HomeViewModel(this._getDepartmentsUseCase);

  @override
  void start() {
    getHomeData();
  }

  @override
  void dispose() {
    super.dispose();
    _homeDataStreamController.close();
  }

  //input

  @override
  Sink get inputHomeData => _homeDataStreamController.sink;

  getHomeData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _getDepartmentsUseCase.execute(Void)).fold((failure) {
      inputState.add(ErrorState(StateRendererType.fullScreenErrorState, failure.message));
    }, (data) {
      if(!_homeDataStreamController.isClosed) {
        inputHomeData.add(HomeViewObject(data.departments ?? []));
      }

      if(!stateStreamController.isClosed) {
        inputState.add(ContentState());
      }
    });
  }

  //output

  @override
  Stream<HomeViewObject> get outputHomeData =>
      _homeDataStreamController.stream.map((homeData) => homeData);
}

mixin class HomeViewModelInput {
  Sink get inputHomeData {
    // TODO: implement inputHomeData
    throw UnimplementedError();
  }
}

mixin class HomeViewModelOutput {
  Stream<HomeViewObject> get outputHomeData {
    // TODO: implement outputHomeData
    throw UnimplementedError();
  }
}

class HomeViewObject {
  List<DepartmentModel> departments;

  HomeViewObject(this.departments);
}
