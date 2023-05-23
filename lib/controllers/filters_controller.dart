import 'package:emergen/models/product_response.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class FiltersController extends GetxController {
  List<Platform> _platforms = [];
  List<Region> _regions = [];
  List<Tag> _tags = [];
  List<Genre> _genres = [];

  String? _selectedPlatform;
  String? _selectedTag;
  String? _selectedGenre;

  set selectedPlatform(value) {
    _selectedPlatform = value;
    update();
  }

  set selectedTag(value) {
    _selectedTag = value;
    update();
  }

  set selectedGenre(value) {
    _selectedGenre = value;
    update();
  }

  set platforms(value) {
    _platforms = value;
    update();
  }

  set regions(value) {
    _regions = value;
    update();
  }

  set tags(value) {
    _tags = value;
    update();
  }

  set genres(value) {
    _genres = value;
    update();
  }

  String? get selectedGenre => _selectedGenre;

  String? get selectedTag => _selectedTag;

  String? get selectedPlatform => _selectedPlatform;

  List<Platform> get platforms => _platforms;

  List<Region> get regions => _regions;

  List<Tag> get tags => _tags;

  List<Genre> get genres => _genres;

  clearFilters() {
    _selectedGenre = null;
    _selectedPlatform = null;
    _selectedTag = null;
  }
}
