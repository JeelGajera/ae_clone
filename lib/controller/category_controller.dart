import 'package:ae_clone/model/category_model.dart';
import 'package:get/get.dart';

import '../services/dio_service.dart';

class CategoryController extends GetxController {
  @override
  void onInit() {
    getCategoryList();
    super.onInit();
  }

  RxList categoryList = RxList();
  RxBool isLoading = true.obs;

  var url = "https://allevents.s3.amazonaws.com/tests/categories.json";

  getCategoryList() async {
    isLoading = true.obs;
    var response = await DioServices.getMethod(url);

    if (response.statusCode == 200) {
      response.data.forEach((element) {
        categoryList.add(CategoryModel.fromJson(element));
      });
      isLoading = false.obs;
    }
  }
}
