import 'package:flutter/material.dart';
import 'package:doctor_application/app/app_prefs.dart';
import 'package:doctor_application/app/di.dart';
import 'package:doctor_application/domain/models/models.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:doctor_application/presentation/common/widgets/custom_app_bar.dart';
import 'package:doctor_application/presentation/profile/profile_view_model.dart';
import 'package:doctor_application/presentation/resources/color_manager.dart';
import 'package:doctor_application/presentation/resources/strings_manager.dart';
import 'package:doctor_application/presentation/resources/values_manager.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ProfileViewModel _viewModel = instance<ProfileViewModel>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  _bind() async {
    _viewModel.patientId = await _appPreferences.getUserId();
    _viewModel.start();
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Profile',centerTitle: true),
      body: _userInformation(size),
    );
  }

  Widget _userInformation(Size size) {
    return StreamBuilder<FlowState>(
      stream: _viewModel.outPutState,
      builder: (context, snapshot) {
        return snapshot.data?.getScreenWidget(context,
                contentScreenWidget: _getContentWidget(size),
                retryActionFunction: () {
              _viewModel.start();
            }, buttonTitle: AppStrings.retryAgain) ??
            LoadingState(
                    stateRendererType: StateRendererType.fullScreenLoadingState)
                .getScreenWidget(context);
      },
    );
  }

  Widget _getContentWidget(Size size) {
    return StreamBuilder<ProfileModel>(
      stream: _viewModel.outputProfileData,
      builder: (context, snapshot) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10,vertical: AppPadding.p20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('User Name : ',
                    style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(
                  height: AppSize.s10,
                ),
                Text(snapshot.data?.patient?.name??'',
                    style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(
                  height: AppSize.s30,
                ),
                Text("Phone Number : ",
                    style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(
                  height: AppSize.s10,
                ),
                Text(snapshot.data?.patient?.phoneNumber??'',
                    style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(
                  height: AppSize.s30,
                ),
                Text("Date Of Birth : ",
                    style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(
                  height: AppSize.s10,
                ),
                Text(snapshot.data?.patient?.dateOfBirth.split('T')[0]??'',
                    style: Theme.of(context).textTheme.labelLarge),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _updateButton() {
    return Expanded(
      flex: 1,
      child: Center(
        child: Container(
          width: AppSize.s150,
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: ColorManager.darkPrimary1,
                spreadRadius: AppSize.s2,
                blurRadius: AppSize.s2,
              )
            ],
            borderRadius: BorderRadius.circular(AppSize.s20),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ColorManager.primary,
                ColorManager.darkPrimary2,
              ],
            ),
          ),
          child: MaterialButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            child: Text(
              'Update Profile',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
        ),
      ),
    );
  }


  @override
  void dispose() {
    super.dispose();
    _viewModel.dispose();
  }
}
