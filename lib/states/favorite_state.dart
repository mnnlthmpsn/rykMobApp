import 'package:royalkitchen/models/favorite_model.dart';

class FavoriteState {
  List<Favorite> allFavorites;
  Favorite? favorite;

  FavoriteState({ this.allFavorites = const [], this.favorite });

  FavoriteState copyWith({List<Favorite>? allFavorites, Favorite? favorite}) {
    return FavoriteState(
        allFavorites: allFavorites ?? this.allFavorites,
        favorite: favorite ?? this.favorite);
  }
}
