import 'package:dartz/dartz.dart';
import 'package:e_commerce/src/domain/entities/add_to_cart/addtocart_response_enitiy.dart';
import '../../../entities/home_entites/categoryorbrand_response_entity.dart';
import '../../../../helper/failuers/failures.dart';

abstract class HomeRepository {
  Future<Either<Failure, CategoryOrBrandResponseEntity>> getAllCategory();
  Future<Either<Failure, CategoryOrBrandResponseEntity>> getAllBrand();
  Future<Either<Failure, AddToCartResponseEntity>> addToCart(
      {required String productId});
}
