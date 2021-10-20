class User {
  late int id;
  late String name;
  late String username;
  late String email;
  late Address address;
  late String phone;
  late String website;
  late Company company;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    name = json['name'] as String;
    username = json['username'] as String;
    email = json['email'] as String;
    address = Address.fromJson(json['address'] as Map<String, dynamic>);
    phone = json['phone'] as String;
    website = json['website'] as String;
    company = Company.fromJson(json['company'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['address'] = address.toJson();
    data['phone'] = phone;
    data['website'] = website;
    data['company'] = company.toJson();
    return data;
  }
}

class Address {
  late String street;
  late String suite;
  late String city;
  late String zipcode;
  late Geo geo;

  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'] as String;
    suite = json['suite'] as String;
    city = json['city'] as String;
    zipcode = json['zipcode'] as String;
    geo = Geo.fromJson(json['geo'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['street'] = street;
    data['suite'] = suite;
    data['city'] = city;
    data['zipcode'] = zipcode;
    data['geo'] = geo.toJson();
    return data;
  }
}

class Geo {
  late String lat;
  late String lng;

  Geo({required this.lat, required this.lng});

  Geo.fromJson(Map<String, dynamic> json) {
    lat = json['lat'] as String;
    lng = json['lng'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class Company {
  late String name;
  late String catchPhrase;
  late String bs;

  Company({required this.name, required this.catchPhrase, required this.bs});

  Company.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String;
    catchPhrase = json['catchPhrase'] as String;
    bs = json['bs'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['catchPhrase'] = catchPhrase;
    data['bs'] = bs;
    return data;
  }
}
