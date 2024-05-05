import 'package:e_commerce/src/domain/usecases/home_usecase/add_to_cart_usecase.dart';
import 'package:e_commerce/src/feature/cart/view/cart_screen.dart';
import 'package:e_commerce/src/widget/custom_text_form_app.dart';
import 'package:flutter_svg/svg.dart';

import '../../../domain/entities/product_entites/product_response_entity.dart';
import '../../../domain/usecases/product_usecase/all_product_usecase.dart';
import '../../home/view/home_screen.dart';
import '../../../widget/product_details_view.dart';
import '../../../widget/product_item.dart';
import '../view_modle/product_view_model_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});
  final ProductViewModelCubit viewModel = ProductViewModelCubit(
      allProductUseCases: injectAllProductUseCase(),
      addToCartUseCase: injectAddToCartUseCase());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: SingleChildScrollView(
        child: BlocProvider<ProductViewModelCubit>(
          create: (context) => viewModel..getAllProduct(),
          child: BlocBuilder<ProductViewModelCubit, ProductViewModelState>(
            builder: (context, state) {
              return Column(
                children: [
                  // ContainerSearchWidget(
                  //   controller: viewModel.searchController,
                  //   numberOfBages: viewModel.numberOfCartItem,
                  // ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormApp(
                          hintText: 'what do you search for?',
                          isSearch: true,
                          validator: (text) {},
                          controller: viewModel.searchController,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.h,
                            vertical: 8.h,
                          ),
                        ),
                      ),
                      Gap(7.w),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(CartScreen.routeName);
                        },
                        child: Badge(
                          label: Text(viewModel.numberOfCartItem.toString()),
                          alignment: Alignment.topLeft,
                          child: SvgPicture.asset(
                            'assets/icons/icon-shopping-cart.svg',
                            width: 35.w,
                            height: 35.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(15.h),
                  state is ProductViewModelLoading
                      ? Center(child: CircularProgressIndicator())
                      : state is ProductViewModelError
                          ? Center(child: Text(state.errorMessage ?? 'wrong'))
                          : GridViewAllProduct(
                              listProduct: viewModel.listProduct ?? [],
                            ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class GridViewAllProduct extends StatelessWidget {
  final List<ProductDataEntity> listProduct;
  const GridViewAllProduct({
    super.key,
    required this.listProduct,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.8,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 13,
          crossAxisSpacing: 13,
          childAspectRatio: 0.82,
        ),
        itemBuilder: (context, index) => InkWell(
          focusColor: Colors.transparent,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailsView.routeName,
              arguments: listProduct[index],
            );
          },
          child: ProductItem(
            onTapAddCard: () {
              ProductViewModelCubit.get(context)
                  .addToCart(productId: listProduct[index].id ?? '');
            },
            onTapLove: () {},
            descriptionImage: listProduct[index].description ?? '',
            pathImage: listProduct[index].imageCover ?? '',
            price: listProduct[index].price.toString(),
          ),
        ),
        itemCount: listProduct.length,
      ),
    );
  }
}