import 'package:category/api/ApiCalls.dart';
import 'package:category/blocs/home_blocs.dart';
import 'package:category/blocs/home_events.dart';
import 'package:category/blocs/home_state.dart';
import 'package:category/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SwiperController _swiperController=SwiperController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:(context) => HomeBloc(RepositoryProvider.of<UserRepository>(context),)
          ..add(LoadHomeEvent()),
      child: Scaffold(
        appBar:  AppBar(
          backgroundColor: Colors.white,
          title: Text("Fashion",style: TextStyle(color: Colors.black),),
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.black,),
            onPressed: (){},
          ),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.search,color: Colors.black,)),
            IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border,color: Colors.black,),),
            IconButton(onPressed: (){}, icon: Image.asset("assets/shopping-bag-03.png")),
          ],
        ),
        body: BlocBuilder<HomeBloc,HomeState>(
          builder: (context,state){
            if(state is HomePageLoadingState){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if(state is HomePageLoadedState)
              {
                return SingleChildScrollView(
                  child:  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      //for categories
                      Container(
                        padding: EdgeInsets.all(18.0),
                        child: Wrap(
                          spacing: 5.0,
                          runSpacing: 8.0,
                          children: List.generate(state.categories.length, (index){
                            return RoundImageWithText(
                                imageURL: state.categories[index]['image'],
                                text:state.categories[index]['title']);
                          } ),

                        ),
                      ),
                      //for banners
                      Container(
                        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 7.0),
                        child:Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder
                            (borderRadius: BorderRadius.circular(80.0)),
                          child: Container(
                            height: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(80))
                            ),
                            child:Swiper(
                              controller: _swiperController,
                              itemWidth: 250,
                              outer: false,
                              itemBuilder: (c,i){
                                return Container(
                                  child: Image.network(state.banners[i],fit:BoxFit.cover,height: 120,),
                                );
                              },
                              pagination: new SwiperPagination(builder: DotSwiperPaginationBuilder(
                                  activeColor: Colors.black,color:Colors.grey,activeSize: 8,size: 5
                              ),
                                  margin: EdgeInsets.all(5.0)),
                              itemCount: state.banners.length,
                            ),
                          ),
                        ),
                      ),
                      //for data
                      Container(
                        padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0,0.0),
                        child: Text(
                          " Trending in fashion ",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Container(
                        height: 80.0,
                        padding: EdgeInsets.all(10.0),
                        child:  ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(state.filters.length, (index){
                            return Container(
                              margin: EdgeInsets.all(5.0),
                              padding: EdgeInsets.all(6.0),
                              child: TextButton(
                                child: Text(state.filters[index],style: TextStyle(color: Colors.black),),
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                            side: BorderSide(color: Colors.black)
                                        )
                                    )
                                ),
                                onPressed: (){},
                              ),
                            );
                          }),
                        ),
                      ),

                      Container(
                        child: Wrap(
                          spacing: 5.0,
                          runSpacing: 5.0,
                          children: List.generate(state.product.length, (index){
                            return  ProductCard(state.product[index]);
                          }),
                        ),
                      ),
                    ],
                  ),
                );
              }
             if(state is HomePageErrorState)
               {
                 print(state.error);
                 return  Center(
                   child: Text("Something went wrong"),
                 );
               }
            return Container();

          },
        ),
      ),

    );
  }

  Widget ProductCard(ProductModel product) {
    return Card(
      child: Column(
        children: [
          Stack(
            alignment:AlignmentDirectional.bottomStart,
            children: [
            Image.network(
                product.imageURL,
                width: 182,
                height: 186,
                fit:BoxFit.fill
            ),
            Container(
              width: 55,
              height: 13,
              decoration:     BoxDecoration(
                  borderRadius: BorderRadius.circular(2.5),
                  color: Color(0xccfcfcfa))
          ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/Star-4.png",
                    width: 10,
                    height: 10,
                  ),
                  Text(
                      product.ratingValue,
                      style: TextStyle(
                        fontSize: 8,
                      )
                  ),
                  Text(
                     " | ",
                      style: TextStyle(
                        fontSize: 8,
                      )
                  ),

                  Text(
                      product.ratingCount,
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                      )
                  )
                ],
              ),
],),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      product.brand,
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w400,
                      )
                  ),
                  Text(
                      product.title,
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w300,
                      )
                  ),
                  Text(
                      product.price,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      )
                  ),
                  Text(
                      product.saving,
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.green,
                        fontWeight: FontWeight.w400,
                      )
                  )
                ],
              ),
              SizedBox(width: 20,),
              IconButton(onPressed: (){},
                  icon: Icon(Icons.favorite_border))

            ],
          ),
        ],
      ),
    );
  }


}


class RoundImageWithText extends StatelessWidget {
  final String imageURL;
  final String text;
  const RoundImageWithText({Key? key, required this.imageURL, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // CircleAvatar(
        //   radius: 38,
        //   backgroundImage: NetworkImage(imageURL),
        // ),
        ClipOval(
          child: Image.network(
            imageURL,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        Text(text,style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),)

      ],
    );
  }
}
