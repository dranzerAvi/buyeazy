import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/carousel/gf_carousel.dart';
import 'package:hamro_gadgets/Constants/colors.dart';
import 'package:hamro_gadgets/Constants/products.dart';
import 'package:hamro_gadgets/Constants/screens.dart';
import 'package:hamro_gadgets/services/database_helper.dart';
import 'package:hamro_gadgets/widgets/ProductCard.dart';
import 'package:hamro_gadgets/widgets/bottom_nav_bar.dart';
import 'package:hamro_gadgets/widgets/custom_floating_button.dart';
import 'package:hamro_gadgets/widgets/nav_drawer.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomeScreen extends StatefulWidget {
  static const int TAB_NO = 0;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dbHelper = DatabaseHelper.instance;
  static const int TAB_NO = 1;
  List<String>imageList=[];
  List<Products>newproducts=[];
  List<String>banners=[];
  TextEditingController _cont= TextEditingController();
  PersistentTabController _controller=PersistentTabController();
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Scaffold(

      floatingActionButton: CustomFloatingButton(CurrentScreen(
          currentScreen: HomeScreen(), tab_no: HomeScreen.TAB_NO)),
      appBar:AppBar(

        backgroundColor: primarycolor,
title:Text('Hamro Gadgets',style:TextStyle(color:Colors.white)),
centerTitle: true,
//       actions: [
//
//         Center(child: Container(width:width*0.5,child: TextFormField(controller:_cont,decoration: InputDecoration(filled: true,fillColor: Colors.white,prefixIcon: Icon(Icons.search,color:Colors.grey),hintText: 'Search here',hintStyle: TextStyle(color:Colors.grey)),)))
//       ],
      ),
      drawer: CustomDrawer(),


body:SingleChildScrollView(
  child:   Column(



    children: [



          StreamBuilder(
              stream:FirebaseFirestore.instance.collection('FullLengthBanner').snapshots(),
              builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snap){
                if(snap.hasData&&!snap.hasError&&snap.data!=null){



            imageList.clear();



            for(int i =0;i<snap.data.docs.length;i++){



              imageList.add(snap.data.docs[i]['imageURL']);



            }



            return Padding(



              padding: const EdgeInsets.all(8.0),



              child: Container(



                height:170,



                width:MediaQuery.of(context).size.width,



                child:GFCarousel(



                  items:imageList.map((url){return Container(



          child: Padding(



          padding: const EdgeInsets.all(1.0),



          child: FancyShimmerImage(



          shimmerDuration: Duration(seconds: 2),



          imageUrl: '$url',



          width: 10000.0,



          ),



          ),



          );



          },



          ).toList(),



          onPageChanged: (index) {



          setState(() {



      //                                    print('change');



          });



          },



          viewportFraction: 1.0,



          aspectRatio:



          (MediaQuery.of(context).size.width / 18) /



          (MediaQuery.of(context).size.width /



          40),



          autoPlay: true,



          pagination: true,



          passiveIndicator: Colors.grey.withOpacity(0.4),



          activeIndicator: Colors.white,



          pauseAutoPlayOnTouch: Duration(seconds: 8),



          pagerSize: 8,



          )),



            );



                }else {return Container();}}),



      SizedBox(height:height*0.02),

      Row(children: [

        Padding(

          padding:  EdgeInsets.only(left:12.0),

          child: Text('New Products',style:TextStyle(color:Colors.black,fontSize: height*0.025,fontWeight: FontWeight.bold)),

        ),

  //      InkWell(

  //        onTap: (){

  //

  //        },

  //      )

      ],),

      SizedBox(height:height*0.02),

      StreamBuilder(



        stream:FirebaseFirestore.instance.collection('Products').where('newProduct',isEqualTo: true).where('status',isEqualTo:'active').snapshots(),



      builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snap){



      if(snap.hasData&&!snap.hasError&&snap.data!=null){



        newproducts.clear();



        for(int i =0;i<snap.data.docs.length;i++){



        List<Details>all=[];



        Details det=Details(snap.data.docs[i]['details']['Display'],snap.data.docs[i]['details']['Graphic']);



        all.add(det);



        List<Specs> sp=[];



        Specs spe=Specs(snap.data.docs[i]['specs']['CPU'],snap.data.docs[i]['specs']['Model'],snap.data.docs[i]['specs']['RAM'],snap.data.docs[i]['specs']['Storage']);



        sp.add(spe);



        Products pro=Products(snap.data.docs[i]['Brands'],snap.data.docs[i]['Category'],snap.data.docs[i]['SubCategories'],List.from(snap.data.docs[i]['colors']),snap.data.docs[i]['description'],all,List.from(snap.data.docs[i]['detailsGraphicURLs']),snap.data.docs[i]['disPrice'],snap.data.docs[i]['docID'],List.from(snap.data.docs[i]['imageURLs']),snap.data.docs[i]['mp'],snap.data.docs[i]['name'],snap.data.docs[i]['noOfPurchases'],snap.data.docs[i]['quantity'],snap.data.docs[i]['rating'].toString(),sp,snap.data.docs[i]['status']);







       newproducts.add(pro);







        }



        print(newproducts.length);

        print('&&&&&&&&&&&&&&&');

        print(newproducts[2].detailsurls.length);

        print('***************');

        print(newproducts[0].imageurls.length);



        return Container(

          height:height*0.4,



          child: ListView.builder(

            itemCount: newproducts.length,

            shrinkWrap: true,

              scrollDirection: Axis.horizontal,

            itemBuilder:(context,index){

              var item =newproducts[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProductCard(item.imageurls[0], item.name, item.mp, item.disprice,item.description,item.details,item.imageurls,item.rating,item.specs,item.quantity),
              );

            }

          ),

        );



      }



      else{



        return Container();



      }



        }



      ),

      SizedBox(height:height*0.02),

      Row(children: [

        Padding(

          padding:  EdgeInsets.only(left:12.0),

          child: Text('Laptops',style:TextStyle(color:Colors.black,fontSize: height*0.025,fontWeight: FontWeight.bold)),

        ),

  //      InkWell(

  //        onTap: (){

  //

  //        },

  //      )

      ],),

      SizedBox(height:height*0.02),

      StreamBuilder(



          stream:FirebaseFirestore.instance.collection('Products').where('newProduct',isEqualTo: true).snapshots(),



          builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snap){



            if(snap.hasData&&!snap.hasError&&snap.data!=null){



              newproducts.clear();



              for(int i =0;i<snap.data.docs.length;i++){



                List<Details>all=[];



                Details det=Details(snap.data.docs[i]['details']['Display'],snap.data.docs[i]['details']['Graphic']);



                all.add(det);



                List<Specs> sp=[];



                Specs spe=Specs(snap.data.docs[i]['specs']['CPU'],snap.data.docs[i]['specs']['Model'],snap.data.docs[i]['specs']['RAM'],snap.data.docs[i]['specs']['Storage']);



                sp.add(spe);



                Products pro=Products(snap.data.docs[i]['Brands'],snap.data.docs[i]['Category'],snap.data.docs[i]['SubCategories'],List.from(snap.data.docs[i]['colors']),snap.data.docs[i]['description'],all,List.from(snap.data.docs[i]['detailsGraphicURLs']),snap.data.docs[i]['disPrice'],snap.data.docs[i]['docID'],List.from(snap.data.docs[i]['imageURLs']),snap.data.docs[i]['mp'],snap.data.docs[i]['name'],snap.data.docs[i]['noOfPurchases'],snap.data.docs[i]['quantity'],snap.data.docs[i]['rating'].toString(),sp,snap.data.docs[i]['status']);







                newproducts.add(pro);







              }



              print(newproducts.length);

              print('&&&&&&&&&&&&&&&');

              print(newproducts[2].detailsurls.length);

              print('***************');

              print(newproducts[0].imageurls.length);



              return Container(

                height:height*0.4,



                child: ListView.builder(

                    itemCount: newproducts.length,

                    shrinkWrap: true,

                    scrollDirection: Axis.horizontal,

                    itemBuilder:(context,index){

                      var item =newproducts[index];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ProductCard(item.imageurls[0], item.name, item.mp, item.disprice,item.description,item.details,item.imageurls,item.rating,item.specs,item.quantity),
                      );

                    }

                ),

              );



            }



            else{



              return Container();



            }



          }



      ),
      SizedBox(height:height*0.02),
      StreamBuilder(



          stream:FirebaseFirestore.instance.collection('AdBanner').snapshots(),



          builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snap){



            if(snap.hasData&&!snap.hasError&&snap.data!=null){

             banners.clear();





              for(int i =0;i<snap.data.docs.length;i++) {
banners.add(snap.data.docs[i]['imageURL']);

              }


              return Container(





                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.network(banners[0],height: height*0.2,width:width*0.4,),
                    Image.network(banners[1],height: height*0.2,width:width*0.4,),
                  ],
                )

              );



            }



            else{



              return Container();



            }



          }



      ),

      SizedBox(height:height*0.02),
      Row(children: [
        Padding(
          padding:  EdgeInsets.only(left:12.0),
          child: Text('Headphones',style:TextStyle(color:Colors.black,fontSize: height*0.025,fontWeight: FontWeight.bold)),
        ),
//      InkWell(
//        onTap: (){
//
//        },
//      )
      ],),
      SizedBox(height:height*0.02),
      StreamBuilder(

          stream:FirebaseFirestore.instance.collection('Products').where('newProduct',isEqualTo: true).snapshots(),

          builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snap){

            if(snap.hasData&&!snap.hasError&&snap.data!=null){

              newproducts.clear();

              for(int i =0;i<snap.data.docs.length;i++){

                List<Details>all=[];

                Details det=Details(snap.data.docs[i]['details']['Display'],snap.data.docs[i]['details']['Graphic']);

                all.add(det);

                List<Specs> sp=[];

                Specs spe=Specs(snap.data.docs[i]['specs']['CPU'],snap.data.docs[i]['specs']['Model'],snap.data.docs[i]['specs']['RAM'],snap.data.docs[i]['specs']['Storage']);

                sp.add(spe);

                Products pro=Products(snap.data.docs[i]['Brands'],snap.data.docs[i]['Category'],snap.data.docs[i]['SubCategories'],List.from(snap.data.docs[i]['colors']),snap.data.docs[i]['description'],all,List.from(snap.data.docs[i]['detailsGraphicURLs']),snap.data.docs[i]['disPrice'],snap.data.docs[i]['docID'],List.from(snap.data.docs[i]['imageURLs']),snap.data.docs[i]['mp'],snap.data.docs[i]['name'],snap.data.docs[i]['noOfPurchases'],snap.data.docs[i]['quantity'],snap.data.docs[i]['rating'].toString(),sp,snap.data.docs[i]['status']);



                newproducts.add(pro);



              }

              print(newproducts.length);
              print('&&&&&&&&&&&&&&&');
              print(newproducts[2].detailsurls.length);
              print('***************');
              print(newproducts[0].imageurls.length);

              return Container(
                height:height*0.4,

                child: ListView.builder(
                    itemCount: newproducts.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder:(context,index){
                      var item =newproducts[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ProductCard(item.imageurls[0], item.name, item.mp, item.disprice,item.description,item.details,item.imageurls,item.rating,item.specs,item.quantity),
                      );
                    }
                ),
              );

            }

            else{

              return Container();

            }

          }

      ),
      SizedBox(height:height*0.02),

      Row(children: [
        Padding(
          padding:  EdgeInsets.only(left:12.0),
          child: Text('Speakers',style:TextStyle(color:Colors.black,fontSize: height*0.025,fontWeight: FontWeight.bold)),
        ),
//      InkWell(
//        onTap: (){
//
//        },
//      )
      ],),
      SizedBox(height:height*0.02),
      StreamBuilder(

          stream:FirebaseFirestore.instance.collection('Products').where('newProduct',isEqualTo: true).snapshots(),

          builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snap){

            if(snap.hasData&&!snap.hasError&&snap.data!=null){

              newproducts.clear();

              for(int i =0;i<snap.data.docs.length;i++){

                List<Details>all=[];

                Details det=Details(snap.data.docs[i]['details']['Display'],snap.data.docs[i]['details']['Graphic']);

                all.add(det);

                List<Specs> sp=[];

                Specs spe=Specs(snap.data.docs[i]['specs']['CPU'],snap.data.docs[i]['specs']['Model'],snap.data.docs[i]['specs']['RAM'],snap.data.docs[i]['specs']['Storage']);

                sp.add(spe);

                Products pro=Products(snap.data.docs[i]['Brands'],snap.data.docs[i]['Category'],snap.data.docs[i]['SubCategories'],List.from(snap.data.docs[i]['colors']),snap.data.docs[i]['description'],all,List.from(snap.data.docs[i]['detailsGraphicURLs']),snap.data.docs[i]['disPrice'],snap.data.docs[i]['docID'],List.from(snap.data.docs[i]['imageURLs']),snap.data.docs[i]['mp'],snap.data.docs[i]['name'],snap.data.docs[i]['noOfPurchases'],snap.data.docs[i]['quantity'],snap.data.docs[i]['rating'].toString(),sp,snap.data.docs[i]['status']);



                newproducts.add(pro);



              }

              print(newproducts.length);
              print('&&&&&&&&&&&&&&&');
              print(newproducts[2].detailsurls.length);
              print('***************');
              print(newproducts[0].imageurls.length);

              return Container(
                height:height*0.4,

                child: ListView.builder(
                    itemCount: newproducts.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder:(context,index){
                      var item =newproducts[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ProductCard(item.imageurls[0], item.name, item.mp, item.disprice,item.description,item.details,item.imageurls,item.rating,item.specs,item.quantity),
                      );
                    }
                ),
              );

            }

            else{

              return Container();

            }

          }

      )

    ],



  ),
),
    );




  }
}