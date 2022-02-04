abstract class BasketEvent {}

class GetAllBasketItems extends BasketEvent {
  final String custEmail;

  GetAllBasketItems({required this.custEmail});
}

class AddBasketItem extends BasketEvent {
  final int foodId;
  final String customer;

  AddBasketItem({required this.foodId, required this.customer});
}

class DeleteBasketItem extends BasketEvent {
  final int basketItemID;

  DeleteBasketItem({required this.basketItemID});
}
