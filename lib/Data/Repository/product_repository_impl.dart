// ignore: implementation_imports
import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/Data/Data%20Sources/remote/product_remote_data_source.dart';
import 'package:movies/Domain/entitys/get_products_entity.dart';
import 'package:movies/Domain/repository/product_repository.dart';
import 'package:movies/core/utils/failures.dart';

@Injectable(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;

  ProductRepositoryImpl({required this.productRemoteDataSource});
  @override
  Future<Either<Failures, List<GetProductsEntity>>> getProducts() async {
    var either = await productRemoteDataSource.getProducts();
    return either.fold((error) => Left(error), (response) => Right(response));
  }
}
