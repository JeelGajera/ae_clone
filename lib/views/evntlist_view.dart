import 'package:getwidget/getwidget.dart';
import 'package:ae_clone/controller/eventlist_controller.dart';
import 'package:ae_clone/views/webview_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../utils/colors.dart';

// ignore: must_be_immutable
class EventList extends StatelessWidget {
  late String link;
  late String type;

  EventList(
      {required this.type,
      required this.link,
      Key? key,
      required Transition transition})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    type = type[0].toUpperCase() + type.substring(1);

    EventListController eventListController =
        Get.put(EventListController(url: link));

    return Scaffold(
      backgroundColor: MyColors.bgColor,
      appBar: AppBar(
        title: Text("$type Events"),
        backgroundColor: MyColors.prColor,
      ),
      body: _buildBody(eventListController),
    );
  }

  //loading
  Widget _buildLoading() {
    return Center(
      // child: CircularProgressIndicator(),
      child: Lottie.asset('assets/a.json'),
    );
  }

  Widget _buildBody(EventListController eventListController) {
    return Obx(() => eventListController.isEventLoading.value
        ? _buildLoading()
        : _buildList(eventListController));
  }

  Widget _buildList(EventListController eventListController) {
    return ListView.builder(
        itemCount: eventListController.eventList.length,
        itemBuilder: (context, index) {
          return GFCard(
            boxFit: BoxFit.cover,
            title: GFListTile(
              avatar: GFAvatar(
                backgroundImage: NetworkImage(
                    eventListController.eventList[index].thumb_url.toString()),
                shape: GFAvatarShape.standard,
                maxRadius: 80,
              ),
              title: Text(
                  eventListController.eventList[index].eventname.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16)),
              subTitle: Text(eventListController
                  .eventList[index].start_time_display
                  .toString()),
            ),
            content:
                Text(eventListController.eventList[index].location.toString()),
            buttonBar: GFButtonBar(
              children: [
                GFButton(
                  onPressed: () {
                    Get.to(() => WebViewPage(
                        url: eventListController.eventList[index].event_url
                            .toString(),
                        title: eventListController.eventList[index].eventname
                            .toString()));
                    // print('Ticket Button Clicked');
                  },
                  text: 'Get Tickets',
                  textColor: MyColors.scColor,
                  color: MyColors.prColor,
                  blockButton: true,
                  size: GFSize.LARGE,
                ),
              ],
            ),
          );
        });
  }
}