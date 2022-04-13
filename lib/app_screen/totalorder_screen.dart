import 'dart:convert';

import 'package:ecommerce_app/model/ProductItemModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TotalOrderList extends StatefulWidget {
  const TotalOrderList() : super();

  @override
  _TotalOrderListState createState() => _TotalOrderListState();
}

class _TotalOrderListState extends State<TotalOrderList> {
  List<dynamic> listdata=[];
  @override
  void initState() {
    getList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:Text("Ecommerce App"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:20),
            child: Image.asset("assets/images/cart_icon.png",height:20,width:20,),
          ),
        ],),
      body:listdata.isEmpty?ListView.builder(itemCount:listdata.length,
      itemBuilder:(BuildContext c,int index)
        {
          return Card(
            child:Row(
              children: [
                Image.network(listdata[index].toString()),
              ],
            ),
          );
        },):const CircularProgressIndicator(),
    );
  }

   getList() async {
    final prefs = await SharedPreferences.getInstance();
    var list=prefs.getString("userlist");
     listdata=jsonDecode(list!);
    return listdata;
    print("the listdata length is $listdata");
  }
}
