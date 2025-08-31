import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/Domain/use_cases/get_product_use_case.dart';
import 'package:movies/presentation/home_screen/ui/cubit/home_state.dart';

@injectable
class HomeViewModel extends Cubit<HomeStates> {
  GetProductUseCase productUseCase;

  HomeViewModel({required this.productUseCase}) : super(HomeInitialState());
  //todo: hold Data - handle Logic
  void getData() async {
    emit(HomeLoadingState());
    final result = await productUseCase.invoke();

    result.fold(
        (error) => emit(HomeErrorState(failures: error)),
        (productsList) =>
            emit(HomeSuccessState(getProductsEntity: productsList)));
  }
}
