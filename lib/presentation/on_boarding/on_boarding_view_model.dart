import 'dart:async';

import 'package:doctor_application/domain/models/models.dart';
import 'package:doctor_application/presentation/base/base_view_model.dart';
import 'package:doctor_application/presentation/resources/assets_manager.dart';
import 'package:doctor_application/presentation/resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  final StreamController _sliderViewObjectStreamController = StreamController<SliderViewObject>();
  late final List<SliderObject> _list = _getSliderData();
  int currentIndex = 0;

  @override
  void start() {
    _postDataToView();
  }

  @override
  void dispose() {
    super.dispose();
    _sliderViewObjectStreamController.close();
  }

  @override
  int goNext() {
    int nextIndex = ++currentIndex;
    return nextIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = --currentIndex;
    if (previousIndex == -1) {
      previousIndex = _list.length - 1;
    }
    return previousIndex;
  }

  @override
  void onPageChanged(int index) {
    currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _sliderViewObjectStreamController.sink;

  @override
  Stream<SliderViewObject> get outPutSliderViewObject => _sliderViewObjectStreamController.stream.map((sliderViewObject) => sliderViewObject);

  List<SliderObject> _getSliderData() => [
        SliderObject(AppStrings.onBoardingTitle1,
            AppStrings.onBoardingSubTitle1, ImageAssets.onBoardingLogo1),
        SliderObject(AppStrings.onBoardingTitle2,
            AppStrings.onBoardingSubTitle2, ImageAssets.onBoardingLogo2),
        SliderObject(AppStrings.onBoardingTitle3,
            AppStrings.onBoardingSubTitle3, ImageAssets.onBoardingLogo3),
        // SliderObject(AppStrings.onBoardingTitle4,
        //     AppStrings.onBoardingSubTitle4, ImageAssets.onBoardingLogo4),
      ];

  void _postDataToView(){
    inputSliderViewObject.add(SliderViewObject(_list[currentIndex], _list.length, currentIndex));
  }

}

mixin class OnBoardingViewModelInputs {
  int goNext() {
    // TODO: implement goNext
    throw UnimplementedError();
  }
  int goPrevious() {
    // TODO: implement goPrevious
    throw UnimplementedError();
  }
  void onPageChanged(int index) {
    // TODO: implement onPageChanged
  }

  Sink get inputSliderViewObject {
    // TODO: implement inputSliderViewObject
    throw UnimplementedError();
  }
}

mixin class OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outPutSliderViewObject {
    // TODO: implement outPutSliderViewObject
    throw UnimplementedError();
  }
}
