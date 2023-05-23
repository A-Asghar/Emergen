import 'dart:convert';

import 'package:emergen/models/product_response.dart';
import 'package:emergen/network/network.dart';
import 'package:get/get.dart';

import '../controllers/filters_controller.dart';
import '../controllers/products_controller.dart';

class Repository {
  Network network = Network();
  final FiltersController controller = Get.put(FiltersController());

  Future<void> getGenres() async {
    var response = await network.getGenres();

    if (response != null) {
      var jsonResponse = json.decode(response);
      List<dynamic> genreList = jsonResponse['result']['data'];
      List<Genre> genres = genreList.map((e) => Genre.fromJson(e)).toList();
      controller.genres = genres;
    }
  }

  Future<void> getPlatforms() async {
    var response = await network.getPlatforms();

    if (response != null) {
      var jsonResponse = json.decode(response);
      List<dynamic> platformList = jsonResponse['result']['data'];
      List<Platform> platforms =
          platformList.map((e) => Platform.fromJson(e)).toList();
      controller.platforms = platforms;
    }
  }

  Future<void> getRegions() async {
    var response = await network.getRegions();

    if (response != null) {
      var jsonResponse = json.decode(response);
      List<dynamic> regionList = jsonResponse['result']['data'];
      List<Region> regions = regionList.map((e) => Region.fromJson(e)).toList();
      controller.regions = regions;
    }
  }

  Future<void> getTags() async {
    var response = await network.getTags();

    if (response != null) {
      var jsonResponse = json.decode(response);
      List<dynamic> tagList = jsonResponse['result']['data'];
      List<Tag> tags = tagList.map((e) => Tag.fromJson(e)).toList();
      controller.tags = tags;
    }
  }

  fetchProducts({
    String? genre,
    String? region,
    String? tags,
    String? platform,
    String? title,
    String? sortFieldName,
    int page = 1,
    int limit = 50,
  }) async {
    final queryParams = {
      if (genre != null) 'genre[in]': genre,
      if (region != null) 'region[in]': region,
      if (tags != null) 'tags[in]': tags,
      if (platform != null) 'platform[in]': platform,
      if (title != null) 'title': title,
      if (sortFieldName != null) 'sort[fieldName]': sortFieldName,
      'page': page.toString(),
      'limit': limit.toString(),
    };

    final response = await network.fetchProducts(
      genre: genre,
      region: region,
      tags: tags,
      platform: platform,
      title: title,
      sortFieldName: sortFieldName,
    );

    final responseData = jsonDecode(response);
    final searchResults = ProductResponse.fromJson(responseData);

    if (searchResults.success ?? false) {
      final ProductsController productsController =
          Get.put(ProductsController());

      final List<Product> products = searchResults.result!.data!;

      productsController.products = products;
    } else {
      print('Request failed with success: false');
    }
  }
}
