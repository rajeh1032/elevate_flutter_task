import 'package:either_dart/either.dart';
import 'package:movies/Domain/entitys/GetProductsEntity.dart';
import 'package:movies/core/utils/failures.dart';

abstract class ProductRepository {
   Future<Either<Failures, List<GetProductsEntity>>> getProducts();
}