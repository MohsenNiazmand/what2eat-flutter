// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$favoriteRecipeIdsHash() => r'3d99a07996922da9f1646e3e954d9fe9c940a635';

/// See also [favoriteRecipeIds].
@ProviderFor(favoriteRecipeIds)
final favoriteRecipeIdsProvider = AutoDisposeProvider<Set<String>>.internal(
  favoriteRecipeIds,
  name: r'favoriteRecipeIdsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoriteRecipeIdsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FavoriteRecipeIdsRef = AutoDisposeProviderRef<Set<String>>;
String _$favoriteRecipeIdsNotifierHash() =>
    r'11b1d95f901331fe1fd24ce80b510b574c3e7065';

/// See also [FavoriteRecipeIdsNotifier].
@ProviderFor(FavoriteRecipeIdsNotifier)
final favoriteRecipeIdsNotifierProvider =
    NotifierProvider<FavoriteRecipeIdsNotifier, Set<String>>.internal(
      FavoriteRecipeIdsNotifier.new,
      name: r'favoriteRecipeIdsNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$favoriteRecipeIdsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FavoriteRecipeIdsNotifier = Notifier<Set<String>>;
String _$favoritesListNotifierHash() =>
    r'37416ad378a0dc92e3fbb8d3d1a989ea6b2189c7';

/// See also [FavoritesListNotifier].
@ProviderFor(FavoritesListNotifier)
final favoritesListNotifierProvider =
    AutoDisposeAsyncNotifierProvider<
      FavoritesListNotifier,
      List<Favorite>
    >.internal(
      FavoritesListNotifier.new,
      name: r'favoritesListNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$favoritesListNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FavoritesListNotifier = AutoDisposeAsyncNotifier<List<Favorite>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
