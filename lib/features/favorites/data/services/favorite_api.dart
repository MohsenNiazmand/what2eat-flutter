import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:what_2_eat/features/favorites/data/models/favorite_model.dart';
import 'package:what_2_eat/shared/data/models/message_response.dart';

part 'favorite_api.g.dart';

@RestApi()
abstract class FavoriteApi {
  factory FavoriteApi(Dio dio, {String baseUrl}) = _FavoriteApi;

  @GET('/api/favorites')
  Future<FavoriteListEnvelope> listFavorites();

  @POST('/api/favorites')
  Future<FavoriteEnvelope> addFavorite(@Body() AddFavoriteRequest body);

  @DELETE('/api/favorites/{recipeId}')
  Future<MessageResponse> removeFavorite(@Path('recipeId') String recipeId);
}
