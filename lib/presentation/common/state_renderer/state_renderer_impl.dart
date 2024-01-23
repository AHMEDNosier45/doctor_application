import 'package:flutter/material.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer.dart';
import 'package:doctor_application/presentation/resources/constants_manager.dart';
import 'package:doctor_application/presentation/resources/strings_manager.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String? message;

  LoadingState(
      {required this.stateRendererType, String message = AppStrings.loading});

  @override
  String getMessage() => message ?? AppStrings.loading;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// error state (popup, full_screen)

class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// success state (popup)

class SuccessState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  SuccessState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// content state

class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => AppConstants.empty;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}

// empty state

class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.fullScreenEmptyState;
}

extension FlowStateExtension on FlowState {
  getScreenWidget(
    BuildContext context,
     {
       Widget? contentScreenWidget,
    Function? retryActionFunction,
    String buttonTitle = AppConstants.empty,
  }) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() == StateRendererType.popupLoadingState) {
            _showPopup(context, getStateRendererType(), message: getMessage());
            return contentScreenWidget;
          } else {
            return StateRenderer(stateRendererType: getStateRendererType(), con5text: context,);
          }
        }
      case ErrorState:
        {

          if (getStateRendererType() == StateRendererType.popupErrorState) {
            dismissDialog(context);
            _showPopup(
              context,
              getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction,
              buttonTitle: buttonTitle,
            );
            return contentScreenWidget;
          } else {
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction,
              buttonTitle: buttonTitle, con5text: context,
            );
          }
        }
      case SuccessState:
        {
          if (getStateRendererType() == StateRendererType.popupSuccessState) {
            _showPopup(
              context,
              getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction,
              buttonTitle: buttonTitle,
            );
            return contentScreenWidget;
          } else {
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction,
              buttonTitle: buttonTitle, con5text: context,
            );
          }
        }
      case EmptyState:
        {
          return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: () {}, con5text: context,);
        }
      case ContentState:
        {
          return contentScreenWidget;
        }
      default:
        {
          return contentScreenWidget;
        }
    }
  }

  _showPopup(
    BuildContext context,
    StateRendererType stateRendererType, {
    String? message,
    String title = AppConstants.empty,
    Function? retryActionFunction,
    String buttonTitle = AppConstants.empty,
  }) async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => StateRenderer(
          stateRendererType: stateRendererType,
          message: message ?? AppStrings.loading,
          title: title,
          retryActionFunction: retryActionFunction ?? () {},
          buttonTitle: buttonTitle, con5text: context,
        ),
      ),
    );
  }
}

_isCurrentDialogShowing(context) => ModalRoute.of(context)?.isCurrent != true;

dismissDialog(BuildContext context) {
  if (_isCurrentDialogShowing(context)) {
    Navigator.of(context, rootNavigator: true).pop(true);
  }
}
