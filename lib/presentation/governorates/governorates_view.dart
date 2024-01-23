import 'package:flutter/material.dart';
import 'package:doctor_application/presentation/common/widgets/custom_app_bar.dart';
import 'package:doctor_application/presentation/resources/color_manager.dart';
import 'package:doctor_application/presentation/resources/routes_manager.dart';
import 'package:doctor_application/presentation/resources/values_manager.dart';

class GovernoratesView extends StatefulWidget {
  final String departmentId;
  final String departmentName;
  const GovernoratesView({Key? key, required this.departmentId, required this.departmentName}) : super(key: key);

  @override
  State<GovernoratesView> createState() => _GovernoratesViewState();
}

class _GovernoratesViewState extends State<GovernoratesView> {
  List<String> egyptGovernorates = [
    'All',
    "Cairo",
    "Giza",
    "Qalyubia",
    "Alexandria",
    "Beheira",
    "Matrouh",
    "Kafr El Sheikh",
    "Damietta",
    "Dakahlia",
    "Sharqia",
    "Port Said",
    "Ismailia",
    "Suez",
    "Monufia",
    "Gharbia",
    "Faiyum",
    "Beni Suef",
    "Minya",
    "Assiut",
    "Sohag",
    "Qena",
    "Luxor",
    "Aswan",
    "New Valley",
    "North Sinai",
    "South Sinai",
    "Red Sea"
  ];

  List<String> egyptGovernoratesArabic = [
  "القاهرة",
  "الجيزة",
  "القليوبية",
  "الإسكندرية",
  "البحيرة",
  "مطروح",
  "كفر الشيخ",
  "دمياط",
  "الدقهلية",
  "الشرقية",
  "بورسعيد",
  "الإسماعيلية",
  "السويس",
  "المنوفية",
  "الغربية",
  "الفيوم",
  "بني سويف",
  "المنيا",
  "أسيوط",
  "سوهاج",
  "قنا",
  "الأقصر",
  "أسوان",
  "الوادي الجديد",
  "شمال سيناء",
  "جنوب سيناء",
  "البحر الأحمر"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Select Governorate', centerTitle: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => _item(index),
              separatorBuilder: (context, index) => const Divider(thickness: 2,),
              itemCount: egyptGovernorates.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _item(int index) {
    return InkWell(
      overlayColor: MaterialStatePropertyAll(ColorManager.lightBlue),
      onTap: () {
        Navigator.pushNamed(context, Routes.specializationDetailsRoute,arguments: {
          'departmentId':widget.departmentId,
          'departmentName':widget.departmentName,
          'governorate': egyptGovernorates[index],
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p20,horizontal: AppPadding.p20),
        child: Text(
          egyptGovernorates[index],
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
    );
  }
}
