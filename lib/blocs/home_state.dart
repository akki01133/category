import 'package:equatable/equatable.dart';

import '../model/product_model.dart';
abstract class HomeState extends Equatable{}
//loading state
class HomePageLoadingState extends HomeState{
  @override
  List<Object?> get props=>[];
}

//loaded state
class HomePageLoadedState extends HomeState{
  HomePageLoadedState({required this.product,
  required this.categories,
  required this.banners,
  required this.filters});
  final List<ProductModel> product;
  final List categories;
  final List banners;
  final List filters;
  @override
  List<Object?> get props=>[product,categories,banners,filters];
}
//loading error state
class HomePageErrorState extends HomeState{
  HomePageErrorState(this.error);
  final String error;
  @override
  List<Object?> get props=>[error];
}