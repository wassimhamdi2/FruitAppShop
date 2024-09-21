import 'package:get/get.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../../../utils/dummy_helper.dart';

class BaseController extends GetxController {
  // current screen index
  int currentIndex = 0;

  // to count the number of products in the cart
  int cartItemsCount = 0;

  @override
  void onInit() {
    getCartItemsCount();
    super.onInit();
  }

  /// change the selected screen index
  void changeScreen(int selectedIndex) {
    currentIndex = selectedIndex;
    update();
  }

  /// calculate the number of products in the cart
  void getCartItemsCount() {
    var products = DummyHelper.vegetables;
    cartItemsCount = products.fold<int>(0, (p, c) => p + c.quantity);
    update(['CartBadge']);
  }

  /// when the user press on add + icon
  void onIncreasePressed(int productId) {
    DummyHelper.vegetables.firstWhere((p) => p.id == productId).quantity++;
    getCartItemsCount();
    update(['ProductQuantity']);
    if (Get.isRegistered<CartController>()) {
      Get.find<CartController>().getTotal();
    }
    update();
  }

  /// when the user press on remove - icon
  void onDecreasePressed(int productId) {
    var product = DummyHelper.vegetables.firstWhere((p) => p.id == productId);
    if (product.quantity > 0) {
      product.quantity--;
      getCartItemsCount();
      if (Get.isRegistered<CartController>()) {
        Get.find<CartController>().getCartProducts();
        Get.find<CartController>().getTotal();
      }
      update(['ProductQuantity']);
    }
  }
}
