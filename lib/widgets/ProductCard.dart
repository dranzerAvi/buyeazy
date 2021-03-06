import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hamro_gadgets/Constants/colors.dart';
import 'package:hamro_gadgets/Constants/products.dart';

class ProductCard extends StatefulWidget {
  String imageUrl;
  String name;
  int mp;
  int disprice;
  String description;
  String details;
  List<String> detailsurls = [];
  String rating;
  Map specs;
  int quantity;
  bool inStore;
  String varientid;
  ProductCard(
      this.imageUrl,
      this.name,
      this.mp,
      this.disprice,
      this.description,
      this.details,
      this.detailsurls,
      this.rating,
      this.specs,
      this.quantity,
      this.inStore,
      this.varientid);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  var length;
  var qty = 1;
  int choice = 0;

  @override
  void initState() {
    choice = 0;
    print('-------------');
    print(widget.detailsurls.length);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height * 0.4,
      width: double.infinity,
      child: InkWell(
        onTap: () {},
        child: Container(
            height: height * 0.4,
            width: double.infinity,
            child: Card(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.quantity > 0
                        ? Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: MediaQuery.of(context).size.height *
                                          0.02,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text('in stock',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02)),
                                  ],
                                )),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.cancel,
                                      color: Colors.red,
                                      size: MediaQuery.of(context).size.height *
                                          0.02,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text('Out of stock',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02)),
                                  ],
                                )),
                          ),
                    (widget.inStore && widget.quantity > 0)
                        ? Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.business,
                                    color: Colors.blue,
                                    size: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                  Text(' In Store',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02))
                                ],
                              ),
                            ),
                          )
                        : Container()
                  ],
                ),
                SizedBox(height: height * 0.01),
                FancyShimmerImage(
                  imageUrl: widget.imageUrl,
                  shimmerDuration: Duration(seconds: 2),
                  height: height * 0.2,
                  // width: width * 0.47,
                  boxFit: BoxFit.fill,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: RatingBar.builder(
                      initialRating: double.parse(widget.rating),
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 12,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ),
                ),
                Container(
                  height: height * 0.07,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontSize: height * 0.02),
                        maxLines: 2),
                  ),
                ),
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Rs.${(widget.mp).toString()}',
                              style: TextStyle(
                                  fontSize: height * 0.017,
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.w300)),
                          Text('Rs.${(widget.disprice).toString()}',
                              style: TextStyle(
                                  fontSize: height * 0.02,
                                  fontWeight: FontWeight.w500)),
                        ]),
                  ),
                  Spacer(),
                  Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(height * 0.012),
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              ' - ${((int.parse(widget.mp.toString()) - int.parse(widget.disprice.toString())) / int.parse(widget.mp.toString()) * 100).toStringAsFixed(0)}%',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            )),
                      )),
                ]),
              ],
            ))

//        child: Card(
//          child: Row(
//            children: [
//              Stack(
//                children: [
//                  Positioned(
//                      child:ClipRRect(
//                          borderRadius: BorderRadius.circular(4),
//                          child:FancyShimmerImage(
//                            shimmerDuration: Duration(seconds:2),
//                            imageUrl:widget.imageUrl,
//                            height:height*01,
//                            width: width*0.45,
//                            boxFit: BoxFit.fill,
//                          )
//                      )
//                  ),
//                  Positioned(
//                    right:2,
//                    top:2,
//                    child:Container(color:Colors.red,child: Padding(
//                      padding: const EdgeInsets.all(4.0),
//                      child: Text('${((int.parse(widget.mp.toString()) - int.parse(widget.disprice.toString())) / int.parse(widget.mp.toString()) * 100).toStringAsFixed(0)} % off',style: TextStyle(color:Colors.white),),
//                    )),
//
//                  )
//                ],
//              ),
//              Container(
//                  margin: EdgeInsets.symmetric(
//                    horizontal: 8,
//                    vertical: 8,
//                  ),
//                  child:SingleChildScrollView(
//                    child: Column(
//mainAxisAlignment: MainAxisAlignment.start,
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: [
//                        Padding(
//                          padding:  EdgeInsets.only(top:8.0),
//                          child: Container(width:width*0.4,child: Text(widget.name,textAlign: TextAlign.left,style:TextStyle(fontSize: height*0.020,fontWeight: FontWeight.bold))),
//                        ),
//                        SizedBox(height:height*0.02),
//                        SizedBox(width:width*0.4,child: Text('${widget.details[0].display}',style:TextStyle(color:Colors.black.withOpacity(0.8),fontSize:height*0.017))),
//                        Row(
//
//                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                          children: [
//
//                            Text('Rs.${(widget.disprice).toString()}',style:TextStyle(fontSize:height*0.02,fontWeight: FontWeight.w500)),
//                            SizedBox(width:width*0.02),
//                            Text('Rs.${(widget.mp).toString()}',style:TextStyle(fontSize:height*0.02,decoration: TextDecoration.lineThrough,fontWeight: FontWeight.w500))
//                          ],
//                        ),
//                            SizedBox(height:height*0.01),
//
//
//
//
//
//
//
//                        SizedBox(height:height*0.01),
//                        qty==0||qty==null?InkWell(
//                          onTap: (){
//                            addToCart(
//                              name:widget.name,
//                              imgUrl: widget.imageUrl,
//                              price:widget.disprice.toString(),
//                              qty:1
//                            );
//                          },
//                          child:Container(height:height*0.04,width:width*0.2,child:Padding(
//                            padding:  EdgeInsets.only(top:5.0),
//                            child: Text('Add',textAlign: TextAlign.center,style:TextStyle(color:Colors.white,fontSize: height*0.02,fontWeight: FontWeight.bold)),
//                          ),decoration: BoxDecoration(color: primarycolor,borderRadius: BorderRadius.all(Radius.circular(5.0))),)
//                        ):Container(decoration:BoxDecoration(
//    borderRadius:BorderRadius.all(Radius.circular(5)),color:primarycolor,),
//                            child:Row(
//                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                          children: [
//                            InkWell(
//                              onTap: ()async{
//                                await getAllItems();
//                                for(var v in cartItems){
//                                  if (v.productName == widget.name) {
//                                    var newQty = v.qty + 1;
//                                    updateItem(
//                                        id: v.id,
//                                        name: v.productName,
//                                        imgUrl: v.imgUrl,
//                                        price: v.price,
//                                        qty: newQty,
//                                        );
//                                  }
//                                }
//                              },
//                              child:Icon(
//                                Icons.add,
//                                color:Colors.white,
//                              )
//                            ),
//                            Text(qty.toString(),style:TextStyle(color:Colors.white)),
//                            InkWell(
//                              onTap: () async {
//                                await getAllItems();
//
//                                for (var v in cartItems) {
//                                  if (v.productName == widget.name) {
//                                    if (v.qty == 1) {
//                                      removeItem(v.productName);
//                                    } else {
//                                      var newQty = v.qty - 1;
//                                      updateItem(
//                                          id: v.id,
//                                          name: v.productName,
//                                          imgUrl: v.imgUrl,
//                                          price: v.price,
//                                          qty: newQty,
//                                          );
//                                    }
//                                  }
//                                }
//                              },
//                              child: Icon(
//                                Icons.remove,
//                                color: Colors.white,
//                              ),
//                            )
//                          ],
//                        ),
//                          height:height*0.03,
//                          width:width*0.3,
//                        )
//                      ],
//                    ),
//                  )
//              )
//            ],
//          ),
//        ),
            ),
      ),
    );
  }
}
