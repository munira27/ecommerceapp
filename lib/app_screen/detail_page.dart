import 'package:flutter/material.dart';

class DetailItemPage extends StatefulWidget {
  String? imageUrl;
   DetailItemPage(this.imageUrl);

  @override
  _DetailItemPageState createState() => _DetailItemPageState();
}

class _DetailItemPageState extends State<DetailItemPage> {

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
      body:Padding(
        padding: const EdgeInsets.only(left:15,right:15,top:10),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.center,
          children: [
            SizedBox(height:300,child:Image.network(widget.imageUrl!),),
            Text("Blossom Data Products",style:TextStyle(fontSize:20),),
            SizedBox(height:8,),
            Center(child: Text("It is a beautiful product which can be use for various purposes.purchase this "
                "it will be beneficial and useful."))
          ],
        ),
      ),
    );
  }
}
