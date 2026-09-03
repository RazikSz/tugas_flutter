import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/post_models.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: 'https://dummyjson.com/')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('recipes?limit=10')
  Future<RecipeResponse> getRecipes();

  @GET('recipes?limit=10')
  Future<RecipeResponse> getAllPosts();

  @GET('recipes?limit=10')
  Future<RecipeResponse> getCocktails();

  @GET('recipes/search')
  Future<RecipeResponse> searchRecipes(@Query('q') String query);
}


extension ApiServiceHelper on ApiService {
  Future<List<RecipeModel>> fetchData() async {
    final response = await getRecipes();
    return response.recipes ?? [];
  }
}

