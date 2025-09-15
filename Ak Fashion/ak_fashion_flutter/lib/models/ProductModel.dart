import 'dart:convert';
/// id : 1
/// title : "Product1"
/// date : "2025-09-06"
/// image : "/media/products/cakestudio-0-900x600.jpg"
/// market_price : 10000
/// selling_price : 9500
/// description : "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
/// category : {"id":1,"title":"Test1","date":"2025-09-06"}
/// favourite : false

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));
String productModelToJson(ProductModel data) => json.encode(data.toJson());
class ProductModel {
  ProductModel({
      num? id, 
      String? title, 
      String? date, 
      String? image, 
      num? marketPrice, 
      num? sellingPrice, 
      String? description, 
      Category? category, 
      bool? favourite,}){
    _id = id;
    _title = title;
    _date = date;
    _image = image;
    _marketPrice = marketPrice;
    _sellingPrice = sellingPrice;
    _description = description;
    _category = category;
    _favourite = favourite;
}

  ProductModel.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _date = json['date'];
    _image = json['image'];
    _marketPrice = json['market_price'];
    _sellingPrice = json['selling_price'];
    _description = json['description'];
    _category = json['category'] != null ? Category.fromJson(json['category']) : null;
    _favourite = json['favourite'];
  }
  num? _id;
  String? _title;
  String? _date;
  String? _image;
  num? _marketPrice;
  num? _sellingPrice;
  String? _description;
  Category? _category;
  bool? _favourite;
ProductModel copyWith({  num? id,
  String? title,
  String? date,
  String? image,
  num? marketPrice,
  num? sellingPrice,
  String? description,
  Category? category,
  bool? favourite,
}) => ProductModel(  id: id ?? _id,
  title: title ?? _title,
  date: date ?? _date,
  image: image ?? _image,
  marketPrice: marketPrice ?? _marketPrice,
  sellingPrice: sellingPrice ?? _sellingPrice,
  description: description ?? _description,
  category: category ?? _category,
  favourite: favourite ?? _favourite,
);
  num? get id => _id;
  String? get title => _title;
  String? get date => _date;
  String? get image => _image;
  num? get marketPrice => _marketPrice;
  num? get sellingPrice => _sellingPrice;
  String? get description => _description;
  Category? get category => _category;
  bool? get favourite => _favourite;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['date'] = _date;
    map['image'] = _image;
    map['market_price'] = _marketPrice;
    map['selling_price'] = _sellingPrice;
    map['description'] = _description;
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    map['favourite'] = _favourite;
    return map;
  }

}

/// id : 1
/// title : "Test1"
/// date : "2025-09-06"

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));
String categoryToJson(Category data) => json.encode(data.toJson());
class Category {
  Category({
      num? id, 
      String? title, 
      String? date,}){
    _id = id;
    _title = title;
    _date = date;
}

  Category.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _date = json['date'];
  }
  num? _id;
  String? _title;
  String? _date;
Category copyWith({  num? id,
  String? title,
  String? date,
}) => Category(  id: id ?? _id,
  title: title ?? _title,
  date: date ?? _date,
);
  num? get id => _id;
  String? get title => _title;
  String? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['date'] = _date;
    return map;
  }

}