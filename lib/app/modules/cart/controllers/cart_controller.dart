import 'package:get/get.dart';

import '../../../../utils/dummy_helper.dart';
import '../../../components/custom_snackbar.dart';
import '../../../data/models/product_model.dart';
import '../../base/controllers/base_controller.dart';

class CartController extends GetxController {
  // to hold the products in cart
  List<ProductModel> products = [];
  var total = 0.0;

  @override
  void onInit() {
    getCartProducts();
    getTotal(); // Fetch cart products asynchronously.
    super.onInit();
  }

  /// when the user press on purchase now button
  void onPurchaseNowPressed() {
    clearCart();
    Get.back();
    CustomSnackBar.showCustomSnackBar(
        title: 'Purchased', message: 'Order placed with success');
  }

  /// get the cart products from the product list
  void getCartProducts() {
    products = DummyHelper.vegetables.where((p) => p.quantity > 0).toList();
    update(); // Notify the UI that products have been updated
  }

  /// clear products in cart and reset cart items count
  void clearCart() {
    DummyHelper.vegetables.forEach((p) => p.quantity = 0); // Reset quantities
    Get.find<BaseController>().getCartItemsCount(); // Update cart items count
  }

  void getTotal() {
    List productss =
        DummyHelper.vegetables.where((p) => p.quantity > 0).toList();
    total = productss.fold(
        0.0, (sum, product) => sum + (product.quantity * product.price));
    update();
    // Update the UI whenever the total changes
  }
}
