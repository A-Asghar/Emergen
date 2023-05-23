import 'package:get/get.dart';

class LoadingController extends GetxController {
  RxBool _isLoading = false.obs;

  set isLoading(value) {
    _isLoading.value = value;
  }

  bool get isLoading => _isLoading.value;
}
