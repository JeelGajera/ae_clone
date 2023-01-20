import 'package:ae_clone/model/event_model.dart';
import 'package:ae_clone/services/dio_service.dart';
import 'package:get/get.dart';

class EventListController extends GetxController {
  // ignore: prefer_typing_uninitialized_variables
  var url;

  @override
  void onInit() {
    getEventList();
    super.onInit();
  }

  EventListController({required this.url});

  RxList eventList = RxList();
  RxBool isEventLoading = true.obs;

  getEventList() async {
    isEventLoading = true.obs;
    var response = await DioServices.getMethod(url);

    if (response.statusCode == 200) {
      response.data['item'].forEach((element) {
        eventList.add(EventModel.fromJson(element));
      });
      isEventLoading = false.obs;
    }
  }
}
