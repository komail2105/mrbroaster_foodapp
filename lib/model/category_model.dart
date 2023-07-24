import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryNameModel {
  final String categoryId;
  final String categoryName;
  final String categoryImage;
  CategoryNameModel({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImage,
  });

  factory CategoryNameModel.fromDocument(DocumentSnapshot doc) {
    return CategoryNameModel(
      categoryId: doc['CategoryId'],
      categoryName: doc['CategoryName'],
      categoryImage: doc['CategoryImage'],
    );
  }
}
