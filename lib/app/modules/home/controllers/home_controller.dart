import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../../config/theme/my_theme.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/dummy_helper.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/product_model.dart';

class HomeController extends GetxController {
  // to hold categories & products
  List<CategoryModel> categories = [];
  List<ProductModel> products = [];

  // for app theme
  var isLightTheme = MySharedPref.getThemeIsLight();

  // for home screen cards
  var cards = [Constants.card1, Constants.card2, Constants.card3];

  @override
  void onInit() {
    getProductsFromFirestore().then((value) {
      getProducts();
      update(['products']);
      print(DummyHelper.vegetables.toList());
    });
    getCategories();

    super.onInit();
  }

  Future<void> getProductsFromFirestore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot querySnapshot =
          await firestore.collection('vegetables').get();

      // Clear the existing products in the list
      DummyHelper.vegetables.clear();

      // Map the Firebase documents to ProductModel objects and add them to the 'prod' list
      querySnapshot.docs.forEach((doc) {
        DummyHelper.vegetables.add(ProductModel.fromFirestore(doc));
        print(ProductModel.fromFirestore(doc).price);
      });
    } catch (e) {
      print('Error retrieving products: $e');
    } finally {
      // Set loading to false once data fetching is complete
      // isLoading.value = false;
    }
  }

  /// get categories from dummy helper
  getCategories() {
    categories = DummyHelper.categories;
  }

  /// get products from dummy helper
  getProducts() {
    products = DummyHelper.vegetables;
  }

  /// when the user press on change theme icon
  onChangeThemePressed() {
    MyTheme.changeTheme();
    isLightTheme = MySharedPref.getThemeIsLight();
    update(['Theme']);
  }
}
