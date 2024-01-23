import 'package:flutter/material.dart';
import 'package:doctor_application/app/di.dart';
import 'package:doctor_application/app/extensions.dart';
import 'package:doctor_application/domain/models/models.dart';
import 'package:doctor_application/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:doctor_application/presentation/common/widgets/custom_app_bar.dart';
import 'package:doctor_application/presentation/resources/assets_manager.dart';
import 'package:doctor_application/presentation/resources/color_manager.dart';
import 'package:doctor_application/presentation/resources/routes_manager.dart';
import 'package:doctor_application/presentation/resources/strings_manager.dart';
import 'package:doctor_application/presentation/resources/values_manager.dart';
import 'package:doctor_application/presentation/specialization_details/specialization_details_view_model.dart';

class SpecializationDetailsView extends StatefulWidget {
  final String governorate;
  final String departmentId;
  final String departmentName;
  const SpecializationDetailsView(
      {Key? key,
      required this.governorate,
      required this.departmentId,
      required this.departmentName})
      : super(key: key);

  @override
  State<SpecializationDetailsView> createState() =>
      _SpecializationDetailsViewState();
}

class _SpecializationDetailsViewState extends State<SpecializationDetailsView> {
  final SpecializationDetailsViewModel _viewModel =
      instance<SpecializationDetailsViewModel>();

  _bind() {
    _viewModel.departmentId = widget.departmentId;
    _viewModel.start();
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  void setState(VoidCallback fn) {
    if(mounted){
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(title: widget.departmentName,centerTitle: true),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outPutState,
        builder: (context, snapshot) {
          if(snapshot.data != null) {
          return snapshot.data?.getScreenWidget(context,
                  contentScreenWidget: _getContentWidget(size),
                  buttonTitle: AppStrings.retryAgain, retryActionFunction: () {
                _viewModel.start();
              }) ??
              _getContentWidget(size);
          }else{
            return Container();
          }
        },

      ),
    );
  }

  Widget _getContentWidget(Size size) {
    return StreamBuilder<SpecializationDetailsViewObject>(
      stream: _viewModel.outputSpecializationDetailsData,
      builder: (context, snapshot) {
        if(snapshot.data != null) {
          if (snapshot.data!.doctors.isNotEmpty) {
            if(widget.governorate == 'All'){
              return _doctorsList(snapshot.data!.doctors);
            }else{
              final matchingGovernorate = snapshot.data!.doctors
                  .where((doctor) =>
              doctor.governorate == widget.governorate)
                  .toList();

              if ((matchingGovernorate.isEmpty).orFalse()) {
                return Center(
                  child: Text(
                    'No doctors in this governorate',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                );
              }else {
                return _doctorsList(matchingGovernorate);
              }
            }
          }else{
            return Center(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
              child: Text('No doctors joined this department.',style: Theme.of(context).textTheme.labelLarge,),
            ),);
          }
        }else{
          return Container();
        }
      },
    );
  }

  Widget _doctorsList(List<DoctorModel> doctors) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: doctors.length,
      itemBuilder: (context, index) {

            return doctorItem(index, doctors);

      },
    );
  }

  Widget doctorItem(int index, List<DoctorModel>? doctors) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: AppMargin.m5),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(AppSize.s5),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(.3),
                spreadRadius: 2,
                blurRadius: 2,
              offset: const Offset(0, 1),
            )
          ]
      ),
      child: Column(
        children: [
          doctorDetailsSection(index, doctors),
          doctorDetailsSection2(index, doctors),
        ],
      ),
    );
  }

  Widget doctorDetailsSection(int index, List<DoctorModel>? doctors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10,vertical: AppPadding.p10),
      decoration: BoxDecoration(
        color: Colors.grey.shade200
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            ImageAssets.doctor,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: AppSize.s20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dr.${(doctors?[index].name).orEmpty()}',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                (doctors?[index].department.name).orEmpty(),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: ColorManager.grey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: AppSize.s15,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(ColorManager.error)),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.doctorDetailsRoute,
                      arguments: doctors?[index].id);
                },
                child: Text(
                  'Book Now',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget doctorDetailsSection2(int index, List<DoctorModel>? doctors){
    return Container(
      padding: const EdgeInsets.all(AppPadding.p10),
      decoration: BoxDecoration(
        color: ColorManager.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.description,
                color: ColorManager.darkPrimary2,
              ),
              const SizedBox(
                width: AppSize.s10,
              ),
              Expanded(
                child: Text(doctors?[index].description ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: ColorManager.grey),
                ),
              )
            ],
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: ColorManager.darkPrimary2,
              ),
              const SizedBox(
                width: AppSize.s10,
              ),
              Expanded(
                child: Text(
                  doctors?[index].address ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: ColorManager.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: ColorManager.darkPrimary2,
                    ),
                    const SizedBox(
                      width: AppSize.s10,
                    ),
                    Text(
                      '${doctors?[index].phoneNumber}',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(color: ColorManager.grey),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p5,vertical: AppPadding.p5),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: ColorManager.primary
                      ),
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.attach_money_outlined,
                        color: ColorManager.darkPrimary2,
                      ),
                      const SizedBox(
                        width: AppSize.s5,
                      ),
                      Text(
                        'Fees: ${doctors?[index].fee.toString()} EGP',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: ColorManager.grey),
                      ),
                      const SizedBox(
                        width: AppSize.s5,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
