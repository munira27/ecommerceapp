import 'package:ecommerce_app/apimanager/HttpService.dart';
import 'package:ecommerce_app/repository/product_bloc.dart';
import 'package:ecommerce_app/repository/product_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

import 'app_screen/product_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var httpService=HttpService();
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'Flutter Demo',
      home: BlocProvider.value(
          value:ProductBloc(httpService:httpService)..add(GetProductResponse()),
          child: MyHomePage()),
    );
  }
}



