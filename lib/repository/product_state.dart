
import 'package:ecommerce_app/model/ProductItemModel.dart';

abstract class ProductState
{
  ProductState();
}
class GetProductImagesData extends ProductState
{
  ProductItemModel productItemModel;
  GetProductImagesData(this.productItemModel);
}
class InitialState extends ProductState
{
  InitialState();
}
class LoadingState extends ProductState
{
  LoadingState();
}
class ErrorState extends ProductState
{
  String error;
  ErrorState(this.error);
}