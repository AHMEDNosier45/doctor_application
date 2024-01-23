import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:doctor_application/presentation/resources/assets_manager.dart';
import 'package:doctor_application/presentation/resources/color_manager.dart';
import 'package:doctor_application/presentation/resources/constants_manager.dart';
import 'package:doctor_application/presentation/resources/strings_manager.dart';
import 'package:doctor_application/presentation/resources/values_manager.dart';

enum StateRendererType {
  // POPUP STATES (DIALOG).
  popupLoadingState,
  popupErrorState,
  popupSuccessState,

  // FULL SCREEN STATED (FULL SCREEN)
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,
  // general
  contentState
}

class StateRenderer extends StatelessWidget {
  final StateRendererType stateRendererType;
  final String title;
  final String message;
  final String buttonTitle;
  final Function? retryActionFunction;
  final BuildContext con5text;

  const StateRenderer({
    required this.stateRendererType,
    this.title = AppConstants.empty,
    this.message = AppConstants.empty,
    this.retryActionFunction,
    super.key,
    this.buttonTitle = AppConstants.empty, required this.con5text,
  });

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(con5text, buttonTitle);
  }

  _getStateWidget(context, String buttonTitle) {
    switch (stateRendererType) {
      case StateRendererType.popupLoadingState:
        return _getPopUpDialog([
          _getAnimatedImage(JsonAssets.loading),
          _getMessage(message, context)
        ]);
      case StateRendererType.popupErrorState:
        return _getPopUpDialog(
          [
            _getAnimatedImage(JsonAssets.error),
            _getMessage(message, context),
            _getRetryButton(buttonTitle, context)
          ],
        );
      case StateRendererType.popupSuccessState:
        return _getPopUpDialog(
          [
            _getAnimatedImage(JsonAssets.success),
            _getMessage(title, context),
            _getMessage(message, context),
            _getRetryButton(buttonTitle, context)
          ],
        );
      case StateRendererType.fullScreenLoadingState:
        return _getItemsColumn([
          _getAnimatedImage(JsonAssets.loading),
          _getMessage(message, context)
        ]);
      case StateRendererType.fullScreenErrorState:
        return _getItemsColumn([
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message, context),
          _getRetryButton(AppStrings.retryAgain, context)
        ]);
      case StateRendererType.fullScreenEmptyState:
        return _getItemsColumn([
          _getAnimatedImage(JsonAssets.empty),
          _getMessage(message, context)
        ]);
      case StateRendererType.contentState:
        return Container();
      default:
        return Container();
    }
  }

  _getPopUpDialog(List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s14)),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p5),
        decoration: BoxDecoration(
            color: ColorManager.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(AppSize.s14),
            boxShadow: const [BoxShadow(color: Colors.black26)]),
        child: _getDialogContent(children),
      ),
    );
  }

  Widget _getDialogContent(List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  Widget _getItemsColumn(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage(String animationName) {
    return Lottie.asset(
      height: AppSize.s100,
      width: AppSize.s100,
      animationName,
    );
  }

  Widget _getMessage(String message, context) {
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget _getRetryButton(String buttonTitle, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(AppSize.s0, AppSize.s4),
                blurRadius: AppSize.s5,
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ColorManager.primary,
                ColorManager.darkPrimary2,
              ],
            ),
            borderRadius: BorderRadius.circular(AppSize.s30),
          ),
          child: MaterialButton(
            onPressed: () {
              retryActionFunction?.call();
            },
            child: Text(
              buttonTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
      ),
    );
  }
}
