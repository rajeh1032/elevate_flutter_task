import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/Domain/entitys/get_products_entity.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/di/di.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_styles.dart';
import 'package:movies/core/utils/custom_elvated_button.dart';
import 'package:movies/presentation/home_screen/product_card.dart';
import 'package:movies/presentation/home_screen/ui/cubit/home_state.dart';
import 'package:movies/presentation/home_screen/ui/cubit/home_view_model.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel viewModel = getIt<HomeViewModel>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewModel, HomeStates>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return const SafeArea(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is HomeErrorState) {
          return SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64.sp,
                    color: AppColors.lightBlue,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Error',
                    style: AppStyles.bold20LightBlue,
                  ),
                  SizedBox(height: 8.h),
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: Text(
                      state.failures.errorMessage,
                      style: AppStyles.regular16lightBlue,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  CustomElvatedButton(
                    onPressed: () => viewModel.getData(),
                    text: 'Retry',
                    backgroundColor: AppColors.blue,
                    textStyle: AppStyles.regular16lightBlue
                        .copyWith(color: AppColors.white),
                  ),
                ],
              ),
            ),
          );
        } else if (state is HomeSuccessState) {
          //state.getProductsEntity.
          return Scaffold(
            body: GridView.builder(
              padding: EdgeInsets.all(16.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12.h,
                crossAxisSpacing: 12.w,
                childAspectRatio: 0.7,
              ),
              itemCount: state.getProductsEntity.length,
              itemBuilder: (BuildContext context, int index) {
                final product = state.getProductsEntity[index];
                return ProductCard(
                  image: product.image ?? AppAssets.shoes,
                  title: product.title ?? "No Title",
                  description: product.description ?? "No Description",
                  price: product.price ?? 0,
                  rating: product.rating?.rate ?? 0,
                );
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
