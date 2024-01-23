import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:doctor_application/app/app_prefs.dart';
import 'package:doctor_application/app/di.dart';
import 'package:doctor_application/presentation/authentication/login/login_view_model.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:doctor_application/presentation/resources/assets_manager.dart';
import 'package:doctor_application/presentation/resources/color_manager.dart';
import 'package:doctor_application/presentation/resources/routes_manager.dart';
import 'package:doctor_application/presentation/resources/strings_manager.dart';
import 'package:doctor_application/presentation/resources/values_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  _bind() {
    _viewModel.start();
    _phoneNumberController.addListener(
        () => _viewModel.setPhoneNumber(_phoneNumberController.text));

    _viewModel.isUserLoggedInSuccessfullyStreamController.stream
        .listen((isLoggedIn) {
      if (isLoggedIn) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPreferences.setUserId(_viewModel.doctorId);
          _appPreferences.setUserLoggedIn();
          Navigator.of(context)
              .pushNamedAndRemoveUntil(Routes.mainRoute, ModalRoute.withName(Routes.splashRoute), arguments: {
            'phoneNumber': _phoneNumberController.text,
            'pageIndex': 0,
          });
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
      stream: _viewModel.outPutState,
      builder: (context, snapshot) {
        return snapshot.data?.getScreenWidget(
              context,
              contentScreenWidget: _getContentWidget(context),
              buttonTitle: AppStrings.ok,
              retryActionFunction: () => dismissDialog(context),
            ) ??
            _getContentWidget(context);
      },
    );
  }

  _getContentWidget(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p40, vertical: AppPadding.p10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(ImageAssets.splashLogo),
              const SizedBox(height: AppSize.s20),
              Text(
                AppStrings.loginToAccount,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: AppSize.s30),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StreamBuilder<bool>(
                      stream: _viewModel.outputIsPhoneNumberValid,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: _phoneNumberController,
                          style: Theme.of(context).textTheme.titleSmall,
                          decoration: InputDecoration(
                            label: const Text(AppStrings.phoneNumberLabel),
                            hintText: AppStrings.phoneNumberHint,
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.phoneNumberError,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: AppSize.s40),
                    StreamBuilder<bool>(
                      stream: _viewModel.outputAreAllInputsValid,
                      builder: (context, snapshot) {
                        return Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: ColorManager.black,
                                  offset: const Offset(AppSize.s0, AppSize.s4),
                                  blurRadius: AppSize.s5)
                            ],
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Theme.of(context).primaryColor,
                                Theme.of(context).primaryColorDark,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: MaterialButton(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 60),
                            disabledColor: ColorManager.grey,
                            disabledTextColor: ColorManager.white,
                            onPressed: (snapshot.data ?? false)
                                ? () {
                                    _viewModel.login();
                                  }
                                : null,
                            child: Text(
                              AppStrings.login,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _passController.dispose();
    _viewModel.dispose();
    super.dispose();
  }
}
