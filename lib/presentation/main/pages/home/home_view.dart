import 'package:flutter/material.dart';
import 'package:doctor_application/app/di.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:doctor_application/presentation/main/pages/home/home_view_model.dart';
import 'package:doctor_application/presentation/resources/color_manager.dart';
import 'package:doctor_application/presentation/resources/routes_manager.dart';
import 'package:doctor_application/presentation/resources/strings_manager.dart';
import 'package:doctor_application/presentation/resources/values_manager.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewModel _viewModel = instance<HomeViewModel>();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    super.initState();
      _bind();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return _getContentWidget(size);
  }

  Widget _getContentWidget(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: AppPadding.p30,
            left: AppPadding.p10,
            right: AppPadding.p10,
          ),
          child: Text(
            AppStrings.availableDepartments,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        StreamBuilder<FlowState>(
          stream: _viewModel.outPutState,
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return snapshot.data!.getScreenWidget(
                    context,
                    contentScreenWidget: _departments(size),
                    retryActionFunction: () => _viewModel.start(),
                    buttonTitle: AppStrings.retryAgain,
                  ) ??
                  Container();
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }

  Widget _departments(Size size) {
    return StreamBuilder<HomeViewObject>(
      stream: _viewModel.outputHomeData,
      builder: (context, snapshot) {
        return Flexible(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: AppPadding.p15),
            itemCount: snapshot.data?.departments.length ?? 0,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p20, vertical: AppPadding.p10),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.governoratesRoute,
                      arguments: {
                        'departmentId': snapshot.data?.departments[index].id,
                        'departmentName':
                            snapshot.data?.departments[index].name,
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(AppPadding.p10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppSize.s20),
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.primary.withOpacity(.5),
                            spreadRadius: 2,
                            blurRadius: 2,
                          ),
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          snapshot.data?.departments[index].name ?? '',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const Icon(Icons.arrow_forward_ios_outlined),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
