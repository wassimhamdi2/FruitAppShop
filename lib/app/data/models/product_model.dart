import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  int id;
  String image;
  String name;
  String description;
  int quantity;
  double price;
  ProductModel(
      {required this.id,
      required this.image,
      required this.name,
      required this.quantity,
      required this.price,
      required this.description});
  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return ProductModel(
      id: data['id'],
      image: data['image'],
      name: data['name'],
      quantity: data['quantity'],
      price: data['price'],
      description: data['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      'image': image,
      'name': name,
      'quantity': quantity,
      'price': price,
      'description': description,
    };
  }
}
