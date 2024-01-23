import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:doctor_application/app/app_prefs.dart';
import 'package:doctor_application/app/di.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:doctor_application/presentation/common/widgets/custom_app_bar.dart';
import 'package:doctor_application/presentation/resources/assets_manager.dart';
import 'package:doctor_application/presentation/resources/color_manager.dart';
import 'package:doctor_application/presentation/resources/routes_manager.dart';
import 'package:doctor_application/presentation/resources/strings_manager.dart';
import 'package:doctor_application/presentation/resources/values_manager.dart';
import 'package:doctor_application/presentation/verification/verification_view_model.dart';

class VerificationView extends StatefulWidget {
  final String phoneNumber;

  const VerificationView({Key? key, required this.phoneNumber})
      : super(key: key);

  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _verifyCodeController = TextEditingController();
  final VerificationViewModel _viewModel = instance<VerificationViewModel>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  _bind() {
    _viewModel.start();
    _viewModel.setPhoneNumber(widget.phoneNumber);
    _viewModel.isVerifiedSuccessfullyStreamController.stream
        .listen((isLoggedIn) {
      if (isLoggedIn) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPreferences.setUserLoggedIn();
          Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
        });
      }
    });

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Verification',centerTitle: true),
      body: StreamBuilder<FlowState>(
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
      ),
    );
  }

  _getContentWidget(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p30, vertical: AppPadding.p60),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(ImageAssets.splashLogo),
              const SizedBox(height: AppSize.s20),
              Text(
                AppStrings.createAccount,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: AppSize.s30),
              Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      StreamBuilder<bool>(
                        stream: _viewModel.outputIsVerifyCodeValid,
                        builder: (context, snapshot) {
                          return _otpWidget();
                        },
                      ),
                      const SizedBox(height: AppSize.s30),
                      _resendCodeWidget(),
                    ],
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _otpWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.p40),
      child: OTPTextField(
        length: 6,
        width: 300,
        fieldWidth: 40,
        style: TextStyle(fontSize: 20, color: ColorManager.primary),
        textFieldAlignment: MainAxisAlignment.spaceAround,
        fieldStyle: FieldStyle.underline,
        onCompleted: (pin) {
          _viewModel.setVerifyCode(pin);
          _viewModel.verification();
        },
        onChanged: (value) {},
      ),
    );
  }

  Widget _resendCodeWidget() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: AppStrings.didReceiveACode,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          TextSpan(
            text: 'Resend',
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                _viewModel.resend();
              },
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: ColorManager.primary),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _verifyCodeController.dispose();
    _viewModel.dispose();
    super.dispose();
  }
}
