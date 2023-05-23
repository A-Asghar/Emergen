import 'package:emergen/repository/repository.dart';
import 'package:get/get.dart';

import 'filters_controller.dart';
import 'loading_controller.dart';

class SearchController {
  static getProducts({String? title}) async {
    final FiltersController filtersController = Get.put(FiltersController());
    final LoadingController loadingController = Get.put(LoadingController());
    final Repository repository = Repository();

    loadingController.isLoading = true;
    await repository.fetchProducts(
      genre: filtersController.selectedGenre,
      tags: filtersController.selectedTag,
      platform: filtersController.selectedPlatform,
      title: title,
    );
    loadingController.isLoading = false;
  }
}
