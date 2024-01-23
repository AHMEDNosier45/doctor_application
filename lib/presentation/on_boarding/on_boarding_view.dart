import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:doctor_application/app/app_prefs.dart';
import 'package:doctor_application/app/di.dart';
import 'package:doctor_application/domain/models/models.dart';
import 'package:doctor_application/presentation/on_boarding/on_boarding_view_model.dart';
import 'package:doctor_application/presentation/resources/assets_manager.dart';
import 'package:doctor_application/presentation/resources/color_manager.dart';
import 'package:doctor_application/presentation/resources/constants_manager.dart';
import 'package:doctor_application/presentation/resources/routes_manager.dart';
import 'package:doctor_application/presentation/resources/strings_manager.dart';
import 'package:doctor_application/presentation/resources/values_manager.dart';


class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController();
  final OnBoardingViewModel _viewModel = OnBoardingViewModel();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  bool? isDoctor;

  _bind() {
    _appPreferences.setOnBoardingScreenViewed();
    _viewModel.start();
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _viewModel.outPutSliderViewObject,
      builder: (context, snapshot) {
        return _getContentWidget(snapshot.data);
      },
    );
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    } else {
      return Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ColorManager.darkPrimary2,
                ColorManager.primary,
              ],
            ),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: PageView.builder(
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: sliderViewObject.numOfSlides,
                  onPageChanged: (index) {
                    _viewModel.onPageChanged(index);
                  },
                  itemBuilder: (context, index) =>
                      OnBoardingPage(sliderViewObject.sliderObject),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < sliderViewObject.numOfSlides; i++)
                          Padding(
                            padding: const EdgeInsets.all(AppPadding.p8),
                            child: _getProperCircle(i, sliderViewObject.currentIndex),
                          )
                      ],
                    ),
                    const SizedBox(height: AppSize.s20,),
                    Center(
                      child: Container(
                        width: AppSize.s160,
                        decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.circular(AppSize.s50)),
                        child: MaterialButton(
                          onPressed: () {
                            if(_viewModel.currentIndex == 2){
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  Routes.authRoute,
                                  ModalRoute.withName(Routes.splashRoute));
                            }else {
                              _pageController.animateToPage(_viewModel.goNext(),
                                  duration: const Duration(
                                      milliseconds:
                                      AppConstants.sliderAnimationTime),
                                  curve: Curves.bounceInOut);
                            }
                          },
                          child: Text(
                            _viewModel.currentIndex == 2 ? AppStrings.signIn : AppStrings.next,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }


  Widget _getProperCircle(int index, int currentIndex) {
    if (index == currentIndex) {
      return SvgPicture.asset(ImageAssets.solidCircleIc);
    } else {
      return SvgPicture.asset(ImageAssets.hollowCircleIc);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject _sliderObject;

  const OnBoardingPage(this._sliderObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSize.s40),
        Text(
            _sliderObject.title,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        const SizedBox(height: AppSize.s15),
        Text(
            _sliderObject.subTitle,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        const SizedBox(height: AppSize.s60),
        Center(
          child: Image.asset(_sliderObject.image),
        ),
      ],
    ),
    );
  }
}
