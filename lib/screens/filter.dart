import 'package:emergen/controllers/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/filters_controller.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0x00152245),
        appBar: _buildAppBar(context),
        body: _buildBody(),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leadingWidth: 250,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Row(
        children: [
          const SizedBox(width: 5),
          InkWell(
            child: Image.network(
              'https://shorturl.at/ckwY7',
              height: 30,
            ),
            onTap: () => Navigator.pop(context),
          ),
          const SizedBox(width: 10),
          const Text(
            "Filters",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 28,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    final controller = Get.find<FiltersController>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          GetBuilder<FiltersController>(
            builder: (controller) => FilterItem(
              filterName: "Platforms",
              filterList: controller.platforms,
              image: 'https://shorturl.at/hkJR2',
            ),
          ),
          const SizedBox(height: 20),
          GetBuilder<FiltersController>(
            builder: (controller) => FilterItem(
              filterName: "Features",
              filterList: controller.tags,
              image: 'https://shorturl.at/hIJL6',
            ),
          ),
          const SizedBox(height: 20),
          GetBuilder<FiltersController>(
            builder: (controller) => FilterItem(
              filterName: "Genres",
              filterList: controller.genres,
              image: 'https://shorturl.at/evW27',
            ),
          ),
        ],
      ),
    );
  }
}

class FilterItem extends StatefulWidget {
  const FilterItem({
    Key? key,
    required this.filterName,
    required this.filterList,
    required this.image,
  }) : super(key: key);

  final String filterName;
  final List filterList;
  final String image;

  @override
  _FilterItemState createState() => _FilterItemState();
}

class _FilterItemState extends State<FilterItem> {
  bool _isExpanded = false;
  late final FiltersController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<FiltersController>();
  }

  @override
  Widget build(BuildContext context) {
    double boxWidth = MediaQuery.of(context).size.width - 20;

    return GestureDetector(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 70,
              width: boxWidth,
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: [
                    const Color(0x00152245),
                    Colors.grey.withOpacity(0.6)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Container(
                width: boxWidth - 2,
                height: 70,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.black,
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 50,
                      child: Image.network(
                        widget.image,
                        height: 30,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      widget.filterName,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    const Spacer(),
                    Icon(
                      _isExpanded
                          ? Icons.arrow_drop_up_outlined
                          : Icons.arrow_drop_down_outlined,
                      color: Colors.orange,
                      size: 25,
                    )
                  ],
                ),
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: Container(),
            secondChild: Center(
              child: Container(
                width: boxWidth,
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      const Color(0x00152245),
                      Colors.grey.withOpacity(0.6)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Container(
                  width: boxWidth - 2,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.black,
                  ),
                  alignment: Alignment.center,
                  child: ListView.builder(
                    itemCount: widget.filterList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          if (widget.filterName == "Platforms") {
                            controller.selectedPlatform =
                                widget.filterList[index].id;
                          } else if (widget.filterName == "Features") {
                            controller.selectedTag =
                                widget.filterList[index].id;
                          } else if (widget.filterName == "Genres") {
                            controller.selectedGenre =
                                widget.filterList[index].id;
                          }
                          Navigator.pop(context);
                          await SearchController.getProducts();
                        },
                        child: FilterTitle(widget.filterList[index].title),
                      );
                    },
                  ),
                ),
              ),
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}

Widget GradientDivider() {
  return Container(
    height: 1.0,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Colors.white, Colors.black],
      ),
    ),
  );
}

Widget FilterTitle(String heading) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GradientDivider(),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            heading,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        )
      ],
    ),
  );
}
