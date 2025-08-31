import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/Domain/entitys/get_products_entity.dart';
import 'package:movies/Domain/repository/product_repository.dart';
import 'package:movies/core/utils/failures.dart';

@injectable
class GetProductUseCase {
  ProductRepository productRepository;
  GetProductUseCase({required this.productRepository});

  Future<Either<Failures, List<GetProductsEntity>>> invoke() {
    return productRepository.getProducts();
  }
}
