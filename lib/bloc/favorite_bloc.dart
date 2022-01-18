import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royalkitchen/events/favorite_event.dart';
import 'package:royalkitchen/models/favorite_model.dart';
import 'package:royalkitchen/repos/favorite_repo.dart';
import 'package:royalkitchen/states/favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepository favoriteRepo;

  FavoriteBloc({required this.favoriteRepo}) : super(FavoriteState()) {
    on<GetAllFavorites>((event, emit) async {
      List<Favorite> allFavorites =
          await favoriteRepo.reqFavorites(event.custEmail);

      print(allFavorites);
      emit(state.copyWith(allFavorites: allFavorites));
    });

    on<AddFavorite>((event, emit) async {
      Favorite favorite = await favoriteRepo.addFavorite({
        'data': {'customer': event.customer, 'food': event.foodId}
      });
      state.allFavorites?.add(favorite);
    });
  }
}
