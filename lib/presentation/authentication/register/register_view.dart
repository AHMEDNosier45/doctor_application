import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:doctor_application/app/di.dart';
import 'package:doctor_application/presentation/authentication/register/register_view_model.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:doctor_application/presentation/resources/assets_manager.dart';
import 'package:doctor_application/presentation/resources/color_manager.dart';
import 'package:doctor_application/presentation/resources/routes_manager.dart';
import 'package:doctor_application/presentation/resources/strings_manager.dart';
import 'package:doctor_application/presentation/resources/theme_manager.dart';
import 'package:doctor_application/presentation/resources/values_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();

  _bind() {
    _viewModel.start();
    _phoneNumberController.addListener(
        () => _viewModel.setPhoneNumber(_phoneNumberController.text));
    _dateOfBirthController.addListener(
        () => _viewModel.setDateOfBirth(_dateOfBirthController.text));
    _nameController.addListener(() => _viewModel.setName(_nameController.text));
    _viewModel.isRegisteredSuccessfullyStreamController.stream
        .listen((isLoggedIn) {
      if (isLoggedIn) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
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
                      stream: _viewModel.outputIsNameValid,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _nameController,
                          style: Theme.of(context).textTheme.titleSmall,
                          decoration: InputDecoration(
                            label: const Text(AppStrings.nameLabel),
                            hintText: AppStrings.nameHint,
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.nameError,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: AppSize.s30),
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
                    const SizedBox(height: AppSize.s30),
                    StreamBuilder<bool>(
                      stream: _viewModel.outputIsDateOfBirthValid,
                      builder: (context, snapshot) {
                        return InkWell(
                          onTap: () async => await _pickDate(),
                          child: TextFormField(
                            controller: _dateOfBirthController,
                            enabled: false,
                            style: Theme.of(context).textTheme.titleSmall,
                            decoration: InputDecoration(
                              label: const Text(AppStrings.dateOfBirthLabel),
                              hintText: AppStrings.dateOfBirthHint,
                              errorText: (snapshot.data ?? true)
                                  ? null
                                  : AppStrings.dateOfBirthError,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: AppSize.s30),
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
                                    _viewModel.register();
                                  }
                                : null,
                            child: Text(
                              AppStrings.register,
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

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2030),
      builder: (context, child) => Theme(
          data: ThemeManager.getApplicationTheme(),
          child: child ?? Container()),
    );

    if (pickedDate != null) {
      _dateOfBirthController.text = DateFormat('MM-dd-yyyy').format(pickedDate);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _dateOfBirthController.dispose();
    _viewModel.dispose();
    super.dispose();
  }
}
