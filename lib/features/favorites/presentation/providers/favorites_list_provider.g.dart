// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$favoriteRecipeIdsHash() => r'7c38e887df902d1d2213cec7989499e510a8fb69';

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
String _$favoritesListNotifierHash() =>
    r'cbcf559e6aa7b0d9c13cecd7210d8685240201c9';

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
