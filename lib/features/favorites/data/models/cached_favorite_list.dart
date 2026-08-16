import 'package:hive_ce/hive.dart';
import 'package:what_2_eat/shared/domain/entities/favorite.dart';

part 'cached_favorite_list.g.dart';

@HiveType(typeId: 4)
class CachedFavoriteList {
  CachedFavoriteList({required this.favorites});

  @HiveField(0)
  final List<Favorite> favorites;
}
