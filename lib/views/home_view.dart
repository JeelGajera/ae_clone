import 'package:ae_clone/controller/category_controller.dart';
import 'package:ae_clone/views/evntlist_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import '../utils/colors.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Category"),
        backgroundColor: MyColors.prColor,
      ),
      backgroundColor: MyColors.bgColor,
      body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Obx(() => categoryController.isLoading.value
              ? _buildLoading()
              : _buildbody())),
    );
  }

  // body
  Widget _buildbody() {
    final List<String> imageList = [
      "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
      "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
      "https://cdn.pixabay.com/photo/2019/12/19/10/55/christmas-market-4705877_960_720.jpg",
      "https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg",
      "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg"
    ];
    return RefreshIndicator(
        color: MyColors.scColor,
        onRefresh: () {
          return categoryController.getCategoryList();
        },
        child: Column(
          children: [
            Center(
              child: Caurousel(
                  imageList: imageList, categoryController: categoryController),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 100.0, bottom: 50.0),
                // padding: const EdgeInsets.all(0.0),
                child: Image.asset(
                  'assets/bg.png',
                  fit: BoxFit.cover,
                )),
            Center(
              child: Image.asset(
                'assets/logo.png',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ));
  }

  //loading
  Widget _buildLoading() {
    return Center(
      // child: CircularProgressIndicator(),
      child: Lottie.asset('assets/a.json'),
    );
  }
}

//Carousel
class Caurousel extends StatefulWidget {
  const Caurousel({
    Key? key,
    required this.imageList,
    required this.categoryController,
  }) : super(key: key);

  final List<String> imageList;
  final CategoryController categoryController;
  @override
  State<StatefulWidget> createState() => _CaurouselState();
}

class _CaurouselState extends State<Caurousel> {
  late List<String> imageList;
  late CategoryController categoryController;

  @override
  void initState() {
    super.initState();
    imageList = widget.imageList;
    categoryController = widget.categoryController;
  }

  @override
  Widget build(BuildContext context) {
    return GFItemsCarousel(
      rowCount: 3,
      children: imageList.map(
        (url) {
          int index = imageList.indexOf(url);
          return InkWell(
              onTap: () {
                Get.to(EventList(
                    type: categoryController.categoryList[index].category,
                    link: categoryController.categoryList[index].data,
                    transition: Transition.cupertino));
                // print(categoryController.categoryList[index].category);
              },
              child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        child: Image.network(url,
                            fit: BoxFit.cover, width: 800.0, height: 1000.0),
                      ),
                      Container(
                        width: 800.0,
                        height: 1000.0,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black,
                              Colors.black12,
                            ],
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          categoryController.categoryList[index].category
                              .toString()
                              .capitalizeFirst!,
                          style: const TextStyle(
                            color: MyColors.scColor,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )));
        },
      ).toList(),
    );
  }
}
