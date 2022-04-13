import 'package:ecommerce_app/model/ProductItemModel.dart';
import 'package:ecommerce_app/repository/product_event.dart';
import 'package:ecommerce_app/repository/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../apimanager/HttpService.dart';

class ProductBloc extends Bloc<ProductEvent,ProductState>
{
  HttpService httpService=new HttpService();
  ProductBloc({required this.httpService}) : super(InitialState());

  @override
  ProductState get intialState=>InitialState();

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async*{
    // TODO: implement mapEventToState
    if(event is GetProductResponse)
    {
      //yield LoadingState();
      try
      {
        ProductItemModel users=await httpService.getProductItems();
        print("hi");
        yield GetProductImagesData(users);
      }
      catch(e)
      {
        yield ErrorState(e.toString());
      }
    }
  }



}