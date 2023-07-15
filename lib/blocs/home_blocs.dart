import 'package:category/api/ApiCalls.dart';
import 'package:category/blocs/home_events.dart';
import 'package:category/blocs/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/product_model.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState>{
  final UserRepository userRepository;

  HomeBloc(this.userRepository): super(HomePageLoadingState()){
    on<LoadHomeEvent>((event,emit)async{
      emit(HomePageLoadingState());
      try{
       final data = await userRepository.getCategories();
        List productList = data['data']['products'];
        List filterList=data['data']['filters'];
        List bannerList=data['banners'];
        List categoriesList=data['categories'];
      List<ProductModel> prodList =productList.map((e) => ProductModel.fromJson(e)).toList();

       emit(HomePageLoadedState(product: prodList,
       categories: categoriesList,
         banners: bannerList,
         filters: filterList
       ));
      }catch(e){
        emit(HomePageErrorState(e.toString()));
      }
    });
  }
}