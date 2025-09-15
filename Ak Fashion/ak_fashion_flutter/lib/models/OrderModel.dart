import 'dart:convert';
OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));
String orderModelToJson(OrderModel data) => json.encode(data.toJson());
class OrderModel {
  OrderModel({
      num? id, 
      String? email, 
      String? phone, 
      String? address, 
      Cart? cart,}){
    _id = id;
    _email = email;
    _phone = phone;
    _address = address;
    _cart = cart;
}

  OrderModel.fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _phone = json['phone'];
    _address = json['address'];
    _cart = json['cart'] != null ? Cart.fromJson(json['cart']) : null;
  }
  num? _id;
  String? _email;
  String? _phone;
  String? _address;
  Cart? _cart;
OrderModel copyWith({  num? id,
  String? email,
  String? phone,
  String? address,
  Cart? cart,
}) => OrderModel(  id: id ?? _id,
  email: email ?? _email,
  phone: phone ?? _phone,
  address: address ?? _address,
  cart: cart ?? _cart,
);
  num? get id => _id;
  String? get email => _email;
  String? get phone => _phone;
  String? get address => _address;
  Cart? get cart => _cart;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['phone'] = _phone;
    map['address'] = _address;
    if (_cart != null) {
      map['cart'] = _cart?.toJson();
    }
    return map;
  }

}

/// id : 2
/// total : 1
/// isComplete : true
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