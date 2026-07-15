import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:what_2_eat/features/recipes/data/models/generate_recipe_request.dart';
import 'package:what_2_eat/shared/data/models/recipe_list_data.dart';

part 'recipe_api.g.dart';

@RestApi()
abstract class RecipeApi {
  factory RecipeApi(Dio dio, {String baseUrl}) = _RecipeApi;

  @POST('/api/recipes/generate')
  Future<RecipeEnvelope> generateRecipe(@Body() GenerateRecipeRequest body);

  @GET('/api/recipes')
  Future<RecipeListEnvelope> listRecipes({
    @Query('q') String? query,
    @Query('category') String? category,
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  @GET('/api/recipes/{id}')
  Future<RecipeEnvelope> getRecipe(@Path('id') String id);
}
