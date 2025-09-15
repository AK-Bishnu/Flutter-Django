import 'dart:convert';
/// id : 1
/// total : 2
/// isComplete : false
/// Date : "2025-09-06"
/// user : 1
/// cartproducts : [{"id":1,"price":9000,"quantity":1,"subtotal":1,"cart":{"id":1,"total":2,"isComplete":false,"Date":"2025-09-06","user":1},"product":{"id":1,"title":"Product1","date":"2025-09-06","image":"/media/products/cakestudio-0-900x600.jpg","market_price":10000,"selling_price":9500,"description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.","category":1}}]

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));
String cartModelToJson(CartModel data) => json.encode(data.toJson());
class CartModel {
  CartModel({
      num? id, 
      num? total, 
      bool? isComplete, 
      String? date, 
      num? user, 
      List<Cartproducts>? cartproducts,}){
    _id = id;
    _total = total;
    _isComplete = isComplete;
    _date = date;
    _user = user;
    _cartproducts = cartproducts;
}

  CartModel.fromJson(dynamic json) {
    _id = json['id'];
    _total = json['total'];
    _isComplete = json['isComplete'];
    _date = json['Date'];
    _user = json['user'];
    if (json['cartproducts'] != null) {
      _cartproducts = [];
      json['cartproducts'].forEach((v) {
        _cartproducts?.add(Cartproducts.fromJson(v));
      });
    }
  }
  num? _id;
  num? _total;
  bool? _isComplete;
  String? _date;
  num? _user;
  List<Cartproducts>? _cartproducts;
CartModel copyWith({  num? id,
  num? total,
  bool? isComplete,
  String? date,
  num? user,
  List<Cartproducts>? cartproducts,
}) => CartModel(  id: id ?? _id,
  total: total ?? _total,
  isComplete: isComplete ?? _isComplete,
  date: date ?? _date,
  user: user ?? _user,
  cartproducts: cartproducts ?? _cartproducts,
);
  num? get id => _id;
  num? get total => _total;
  bool? get isComplete => _isComplete;
  String? get date => _date;
  num? get user => _user;
  List<Cartproducts>? get cartproducts => _cartproducts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['total'] = _total;
    map['isComplete'] = _isComplete;
    map['Date'] = _date;
    map['user'] = _user;
    if (_cartproducts != null) {
      map['cartproducts'] = _cartproducts?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// price : 9000
/// quantity : 1
/// subtotal : 1
/// cart : {"id":1,"total":2,"isComplete":false,"Date":"2025-09-06","user":1}
/// product : {"id":1,"title":"Product1","date":"2025-09-06","image":"/media/products/cakestudio-0-900x600.jpg","market_price":10000,"selling_price":9500,"description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.","category":1}

Cartproducts cartproductsFromJson(String str) => Cartproducts.fromJson(json.decode(str));
String cartproductsToJson(Cartproducts data) => json.encode(data.toJson());
class Cartproducts {
  Cartproducts({
      num? id, 
      num? price, 
      num? quantity, 
      num? subtotal, 
      Cart? cart, 
      Product? product,}){
    _id = id;
    _price = price;
    _quantity = quantity;
    _subtotal = subtotal;
    _cart = cart;
    _product = product;
}

  Cartproducts.fromJson(dynamic json) {
    _id = json['id'];
    _price = json['price'];
    _quantity = json['quantity'];
    _subtotal = json['subtotal'];
    _cart = json['cart'] != null ? Cart.fromJson(json['cart']) : null;
    _product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }
  num? _id;
  num? _price;
  num? _quantity;
  num? _subtotal;
  Cart? _cart;
  Product? _product;
Cartproducts copyWith({  num? id,
  num? price,
  num? quantity,
  num? subtotal,
  Cart? cart,
  Product? product,
}) => Cartproducts(  id: id ?? _id,
  price: price ?? _price,
  quantity: quantity ?? _quantity,
  subtotal: subtotal ?? _subtotal,
  cart: cart ?? _cart,
  product: product ?? _product,
);
  num? get id => _id;
  num? get price => _price;
  num? get quantity => _quantity;
  num? get subtotal => _subtotal;
  Cart? get cart => _cart;
  Product? get product => _product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['price'] = _price;
    map['quantity'] = _quantity;
    map['subtotal'] = _subtotal;
    if (_cart != null) {
      map['cart'] = _cart?.toJson();
    }
    if (_product != null) {
      map['product'] = _product?.toJson();
    }
    return map;
  }

}

/// id : 1
/// title : "Product1"
/// date : "2025-09-06"
/// image : "/media/products/cakestudio-0-900x600.jpg"
/// market_price : 10000
/// selling_price : 9500
/// description : "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
/// category : 1

Product productFromJson(String str) => Product.fromJson(json.decode(str));
String productToJson(Product data) => json.encode(data.toJson());
class Product {
  Product({
      num? id, 
      String? title, 
      String? date, 
      String? image, 
      num? marketPrice, 
      num? sellingPrice, 
      String? description, 
      num? category,}){
    _id = id;
    _title = title;
    _date = date;
    _image = image;
    _marketPrice = marketPrice;
    _sellingPrice = sellingPrice;
    _description = description;
    _category = category;
}

  Product.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _date = json['date'];
    _image = json['image'];
    _marketPrice = json['market_price'];
    _sellingPrice = json['selling_price'];
    _description = json['description'];
    _category = json['category'];
  }
  num? _id;
  String? _title;
  String? _date;
  String? _image;
  num? _marketPrice;
  num? _sellingPrice;
  String? _description;
  num? _category;
Product copyWith({  num? id,
  String? title,
  String? date,
  String? image,
  num? marketPrice,
  num? sellingPrice,
  String? description,
  num? category,
}) => Product(  id: id ?? _id,
  title: title ?? _title,
  date: date ?? _date,
  image: image ?? _image,
  marketPrice: marketPrice ?? _marketPrice,
  sellingPrice: sellingPrice ?? _sellingPrice,
  description: description ?? _description,
  category: category ?? _category,
);
  num? get id => _id;
  String? get title => _title;
  String? get date => _date;
  String? get image => _image;
  num? get marketPrice => _marketPrice;
  num? get sellingPrice => _sellingPrice;
  String? get description => _description;
  num? get category => _category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['date'] = _date;
    map['image'] = _image;
    map['market_price'] = _marketPrice;
    map['selling_price'] = _sellingPrice;
    map['description'] = _description;
    map['category'] = _category;
    return map;
  }

}

/// id : 1
/// total : 2
/// isComplete : false
/// Date : "2025-09-06"
/// user : 1

Cart cartFromJson(String str) => Cart.fromJson(json.decode(str));
String cartToJson(Cart data) => json.encode(data.toJson());
class Cart {
  Cart({
      num? id, 
      num? total, 
      bool? isComplete, 
      String? date, 
      num? user,}){
    _id = id;
    _total = total;
    _isComplete = isComplete;
    _date = date;
    _user = user;
}

  Cart.fromJson(dynamic json) {
    _id = json['id'];
    _total = json['total'];
    _isComplete = json['isComplete'];
    _date = json['Date'];
    _user = json['user'];
  }
  num? _id;
  num? _total;
  bool? _isComplete;
  String? _date;
  num? _user;
Cart copyWith({  num? id,
  num? total,
  bool? isComplete,
  String? date,
  num? user,
}) => Cart(  id: id ?? _id,
  total: total ?? _total,
  isComplete: isComplete ?? _isComplete,
  date: date ?? _date,
  user: user ?? _user,
);
  num? get id => _id;
  num? get total => _total;
  bool? get isComplete => _isComplete;
  String? get date => _date;
  num? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['total'] = _total;
    map['isComplete'] = _isComplete;
    map['Date'] = _date;
    map['user'] = _user;
    return map;
  }

}