import 'package:ecommerce_frontend/data/models/product/product_model.dart';

abstract class CategoryProductState{
  final List<ProductModel> products;
  CategoryProductState(this.products);
}

class CategoryProductInitialState extends CategoryProductState{
  CategoryProductInitialState(): super([]);
}

class CategoryProductLoadingState extends CategoryProductState{
  CategoryProductLoadingState(super.products);
}
class CategoryProductLoaddedState extends CategoryProductState{
  CategoryProductLoaddedState(super.products);
}

class CategoryProductErrorState extends CategoryProductState{
  final String message;
  CategoryProductErrorState(super.products, this.message);
}
