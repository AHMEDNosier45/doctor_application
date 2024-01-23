import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:doctor_application/presentation/resources/values_manager.dart';

class RatingBarWidget extends StatelessWidget {
  const RatingBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: 1,
      minRating: 1,
      // allowHalfRating: true,
      // updateOnDrag: true,
      itemCount: 5,
      itemSize: AppSize.s20,
      itemPadding: const EdgeInsets.symmetric(horizontal: AppPadding.p4),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        debugPrint(rating.toString());
      },
    );
  }
}
