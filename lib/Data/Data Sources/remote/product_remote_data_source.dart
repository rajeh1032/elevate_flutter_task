import 'package:either_dart/either.dart';
import 'package:movies/Domain/entitys/get_products_entity.dart';
import 'package:movies/core/utils/failures.dart';

abstract class ProductRemoteDataSource {
  Future<Either<Failures, List<GetProductsEntity>>>  getProducts();
}
