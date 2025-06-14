import 'package:movies/Domain/entitys/GetProductsEntity.dart';
import 'package:movies/core/utils/failures.dart';

abstract class HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeErrorState extends HomeStates {
  Failures failures;
  HomeErrorState({required this.failures});
}

class HomeSuccessState extends HomeStates {
  final List<GetProductsEntity> getProductsEntity;
  HomeSuccessState({required this.getProductsEntity});
}
