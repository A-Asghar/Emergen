class ProductResponse {
  bool? success;
  Result? result;

  ProductResponse({
    required this.success,
    required this.result,
  });

  factory ProductResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw FormatException("Invalid JSON");
    }

    return ProductResponse(
      success: json['success'] as bool?,
      result: json['result'] != null ? Result.fromJson(json['result']) : null,
    );
  }
}

class Result {
  int? totalPages;
  List<Product>? data;
  int? limit;
  int? currentPage;

  Result({
    required this.totalPages,
    required this.data,
    required this.limit,
    required this.currentPage,
  });

  factory Result.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw FormatException("Invalid JSON");
    }

    return Result(
      totalPages: json['totalPages'] as int?,
      data: (json['data'] as List<dynamic>?)?.map((x) => Product.fromJson(x)).toList(),
      limit: json['limit'] as int?,
      currentPage: json['currentPage'] as int?,
    );
  }
}

class Product {
  String? id;
  String? title;
  String? image;
  List<Genre>? genre;
  Region? region;
  List<Tag>? tags;
  Platform? platform;
  int? sellingPrice;
  bool? isKid;
  String? description;
  String? type;
  bool? show;
  int? rents;
  int? averageRentTime;
  String? code;
  int? level;
  int? quantity;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? inStock;
  int? allStocks;

  Product({
    required this.id,
    required this.title,
    required this.image,
    required this.genre,
    required this.region,
    required this.tags,
    required this.platform,
    required this.sellingPrice,
    required this.isKid,
    required this.description,
    required this.type,
    required this.show,
    required this.rents,
    required this.averageRentTime,
    required this.code,
    required this.level,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
    required this.inStock,
    required this.allStocks,
  });

  factory Product.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw FormatException("Invalid JSON");
    }

    return Product(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      image: json['image'] as String?,
      genre: (json['genre'] as List<dynamic>?)
          ?.map((x) => Genre.fromJson(x))
          .toList(),
      region: json['region'] != null ? Region.fromJson(json['region']) : null,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((x) => Tag.fromJson(x))
          .toList(),
      platform: json['platform'] != null ? Platform.fromJson(json['platform']) : null,
      sellingPrice: json['sellingPrice'] as int?,
      isKid: json['isKid'] as bool?,
      description: json['description'] as String?,
      type: json['type'] as String?,
      show: json['show'] as bool?,
      rents: json['rents'] as int?,
      averageRentTime: json['averageRentTime'] as int?,
      code: json['code'] as String?,
      level: json['level'] as int?,
      quantity: json['quantity'] as int?,
      createdAt: json['createdAt'] == null ? null : DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt']),
      inStock: json['inStock'] as int?,
      allStocks: json['allStocks'] as int?,
    );
  }
}

class Genre {
  String? id;
  String? title;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Genre({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Genre.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw FormatException("Invalid JSON");
    }

    return Genre(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      createdAt: json['createdAt'] == null ? null : DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt']),
      v: json['__v'] as int?,
    );
  }
}

class Region {
  String? id;
  String? title;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Region({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Region.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw FormatException("Invalid JSON");
    }

    return Region(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      createdAt: json['createdAt'] == null ? null : DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt']),
      v: json['__v'] as int?,
    );
  }
}

class Tag {
  String? id;
  String? title;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Tag({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Tag.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw FormatException("Invalid JSON");
    }

    return Tag(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      createdAt: json['createdAt'] == null ? null : DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt']),
      v: json['__v'] as int?,
    );
  }
}

class Platform {
  String? id;
  String? title;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Platform({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Platform.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw FormatException("Invalid JSON");
    }

    return Platform(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      createdAt: json['createdAt'] == null ? null : DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt']),
      v: json['__v'] as int?,
    );
  }
}
