import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/Data/Data%20Sources/remote/product_remote_data_source.dart';
import 'package:movies/Data/Models/GetProductsDm.dart';
import 'package:movies/Domain/entitys/GetProductsEntity.dart';
import 'package:movies/core/api%20manager/api_endpoints.dart';
import 'package:movies/core/api%20manager/api_manager.dart';
import 'package:movies/core/utils/failures.dart';

@Injectable(as: ProductRemoteDataSource)
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  ApiManager apiManager;

  ProductRemoteDataSourceImpl({required this.apiManager});
  @override
  Future<Either<Failures, List<GetProductsDm>>> getProducts() async {
    final List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    try {
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        final response = await apiManager.getData(
          path: ApiEndpoints.getAllProducts,
        );

        print("RESPONSE Profile BODY: ${response.data}");
        print("STATUS Profile CODE: ${response.statusCode}");

          final List<GetProductsDm> productList = (response.data as List)
            .map((e) => GetProductsDm.fromJson(e))
            .toList();

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(productList);
        } else {
          return Left(ServerError(errorMessage: "Server error"));
        }
      } else {
        return Left(NetworkError(errorMessage: "No Internet Connection"));
      }
    } catch (e) {
      print("ERROR: $e");
      return Left(ServerError(errorMessage: e.toString()));
    }
  }
}
