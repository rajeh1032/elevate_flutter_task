import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_styles.dart';

class ProductCard extends StatelessWidget {
  String image;
  String title;
  double price;

  String description;
  String? rating;

  ProductCard(
      {required this.image,
      required this.title,
      required this.price,
      required this.description,
      this.rating,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.lightBlue, width: 2.w),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              child: Image.asset(
                //todo: add image
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        //todo: add title
                        title,
                        style: AppStyles.regular16darkBlue.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        //todo: add description
                        description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.regular16darkBlue.copyWith(
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(
                        //todo: add price
                        'EGP ${price}',
                        style: AppStyles.regular16darkBlue.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        //todo: add price before sale
                        'EGP 1,300',
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 10.sp,
                          color: AppColors.blue,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Expanded(
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 14.sp,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              rating ?? '4.5',
                              style: AppStyles.regular16darkBlue.copyWith(
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        GestureDetector(
                          onDoubleTap: () {
                            //todo: add to cart
                          },
                          child: Container(
                            width: 40.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: AppColors.blue,
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            child: Icon(
                              Icons.add,
                              color: AppColors.white,
                              size: 18.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
