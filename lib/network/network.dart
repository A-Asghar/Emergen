import 'package:http/http.dart' as http;

class Network {
  getGenres() async {
    var url = Uri.parse('https://api.gamestack.com.pk/genres');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  getPlatforms() async {
    var url = Uri.parse('https://api.gamestack.com.pk/platforms');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return [];
    }
  }

  getRegions() async {
    var url = Uri.parse('https://api.gamestack.com.pk/regions');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return [];
    }
  }

  getTags() async {
    var url = Uri.parse('https://api.gamestack.com.pk/tags');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return [];
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
    final url =
        Uri.parse('https://api.gamestack.com.pk/products/subscribed-products');

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

    final response = await http.get(url.replace(queryParameters: queryParams));

    print("queryParams: $queryParams");
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }
}
