// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../Data/Data%20Sources/remote/impl/product_remote_data_source_impl.dart'
    as _i635;
import '../../Data/Data%20Sources/remote/product_remote_data_source.dart'
    as _i180;
import '../../Data/Repository/product_repository_impl.dart' as _i87;
import '../../Domain/repository/product_repository.dart' as _i940;
import '../../Domain/use_cases/get_product_use_case.dart' as _i793;
import '../../presentation/home_screen/ui/cubit/home_view_model.dart' as _i271;
import '../api%20manager/api_manager.dart' as _i949;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i949.ApiManager>(() => _i949.ApiManager());
    gh.factory<_i180.ProductRemoteDataSource>(() =>
        _i635.ProductRemoteDataSourceImpl(apiManager: gh<_i949.ApiManager>()));
    gh.factory<_i940.ProductRepository>(() => _i87.ProductRepositoryImpl(
        productRemoteDataSource: gh<_i180.ProductRemoteDataSource>()));
    gh.factory<_i793.GetProductUseCase>(() => _i793.GetProductUseCase(
        productRepository: gh<_i940.ProductRepository>()));
    gh.factory<_i271.HomeViewModel>(() =>
        _i271.HomeViewModel(productUseCase: gh<_i793.GetProductUseCase>()));
    return this;
  }
}
