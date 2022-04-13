import 'dart:convert';

import 'package:ecommerce_app/app_screen/totalorder_screen.dart';
import 'package:ecommerce_app/model/ProductItemModel.dart';
import 'package:ecommerce_app/repository/product_bloc.dart';
import 'package:ecommerce_app/repository/product_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../apimanager/HttpService.dart';
import '../repository/product_event.dart';
import 'detail_page.dart';

class ProductScreen extends StatefulWidget {
   ProductScreen() : super();

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
   late ProductBloc productbloc;

  @override
  void initState() {
    productbloc=BlocProvider.of<ProductBloc>(context);
   // productbloc.add(GetProductResponse());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc,ProductState>(
      bloc:productbloc,
      builder:(context,state)
      {
        if(state is LoadingState)
        {
          return CircularProgressIndicator();
        }
        else if(state is GetProductImagesData)
        {
          print("state is ${state.productItemModel}");
          return Text("");
          // return buildGridView(state.productItemModel);
        }
        return Container();
      },
    );
  }

  Widget buildGridView(List<ProductItemModel> productItemModel) {
      return Scaffold(
        appBar:AppBar(title:Text("Ecommerce App"),
        actions: [
          Image.asset("assets/images/cart_icon.png"),
        ],),
      body: GridView.builder(
        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3),
        itemCount:productItemModel.length,itemBuilder:(context,index)
      {
        String? image=productItemModel[0].images![index].url;
        return Card(
         child:Container(
        child:Column(
      children: [
        Image.network(image!)
      ],
      ),
        ),
        );
      },),
    );
  }

   @override
   void dispose() {
     super.dispose();
   }

}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //late ProductBloc productbloc;
  var httpService=HttpService();
  int count=0;
  List<ProductItemModel> addedItemList=[];
  List<ProductItemModel> finalItemList=[];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BlocBuilder<ProductBloc,ProductState>(
        bloc:BlocProvider.of<ProductBloc>(context),
        builder:(context,state)
          {
            if(state is LoadingState)
            {
              return  CircularProgressIndicator();
            }
            else if(state is GetProductImagesData)
            {
              print("state is ${state.productItemModel}");
              return buildGridView(state.productItemModel);
            }
            return Center(child: CircularProgressIndicator());
          }

      ),
    );
  }

  Widget buildGridView(ProductItemModel productItemModel) {
      return Scaffold(
        appBar:AppBar(title:Text("Ecommerce App"),
        actions: [
          GestureDetector(
            onTap:()
            {
              Navigator.push(context,MaterialPageRoute(builder:(context)=>const TotalOrderList()));
            },
            child: Padding(
              padding: const EdgeInsets.only(right:20),
              child: Image.asset("assets/images/cart_icon.png",height:20,width:20,),
            ),
          ),
        ],),
      body: GridView.builder(
        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3,
        childAspectRatio:0.7),
        itemCount:productItemModel.images?.length,itemBuilder:(context,index)
      {
        String? image=productItemModel.images![index].url;
        return Card(
         child:Container(
        child:Column(
      children: [
        Expanded(
          child: GestureDetector(
              onTap:()
              {
                Navigator.push(context,MaterialPageRoute(builder:(context)=>DetailItemPage(
                    productItemModel.images![index].url
                )));
              },
              child:Image.network(image!,fit:BoxFit.cover,)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Price "+productItemModel.images![index].price.toString()),
        ),
        GestureDetector(
          onTap:() async{
            addedItemList.add(productItemModel);
            finalItemList.addAll(addedItemList);
            print("the final item length is $finalItemList");
            // Obtain shared preferences.
            final prefs = await SharedPreferences.getInstance();
            String user=jsonEncode(finalItemList);
            prefs.setString("userlist", user);
            Fluttertoast.showToast(msg:"Item added to cart");
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:Image.asset("assets/images/cart_icon.png",height:20,width:20,),
          ),
        )
      ],
      ),
        ),
        );
      },),
    );
  }
}

