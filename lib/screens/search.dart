import 'package:emergen/models/product_response.dart';
import 'package:emergen/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/filters_controller.dart';
import '../controllers/loading_controller.dart';
import '../controllers/products_controller.dart';
import '../controllers/search_controller.dart';
import 'bottom_nav_bar.dart';
import 'filter.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final ProductsController productsController;
  late final FiltersController filtersController;
  late final LoadingController loadingController;
  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    productsController = Get.put(ProductsController());
    filtersController = Get.put(FiltersController());
    loadingController = Get.put(LoadingController());

    if (filtersController.tags.isEmpty ||
        filtersController.platforms.isEmpty ||
        filtersController.genres.isEmpty ||
        filtersController.regions.isEmpty) {
      getFilters();
    }
  }

  Future<void> getFilters() async {
    Repository repository = Repository();

    List<Future> futures = [
      repository.getGenres(),
      repository.getPlatforms(),
      repository.getRegions(),
      repository.getTags(),
    ];

    await Future.wait<dynamic>(futures);

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0x00152245),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              width: 150,
              child: Image.asset(
                'lib/assets/tr.png', // Path to your top right image
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              width: 150,
              child: Image.asset(
                'lib/assets/bl.png', // Path to your bottom left image
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: FrostedGlassBox(),
            ),
            Obx(
              () => loadingController.isLoading
                  ? _buildLoading()
                  : _buildSearch(),
            ),
          ],
        ),
      ),
    );
  }

  Center _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.orange,
      ),
    );
  }

  _buildSearch() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          SearchFilterRow(),
          _SearchBar(searchController: searchController),
          _SearchResultsWidget(
            products: productsController.products,
          ),
        ],
      ),
    );
  }

  Widget SearchFilterRow() {
    return Row(
      children: [
        const Text(
          "Search",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 28,
          ),
        ),
        const Spacer(),
        InkWell(
          child: const Text(
            "Filter",
            style: TextStyle(color: Colors.orange, fontSize: 16),
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FilterScreen()),
          ),
        )
      ],
    );
  }
}

class _SearchResultsWidget extends StatelessWidget {
  const _SearchResultsWidget({
    Key? key,
    required this.products,
  }) : super(key: key);

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () => GridView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return _ItemWidget(
              product: products[index],
            );
          },
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({
    Key? key,
    required this.searchController,
  }) : super(key: key);
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          width: 1.0,
          color: Colors.white,
        ),
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 18,
            child: VerticalDivider(
              color: Colors.white,
              thickness: 2,
            ),
          ),
          Expanded(
            child: TextField(
              style: const TextStyle(color: Colors.white),
              controller: searchController,
              decoration: const InputDecoration(
                hintText: "Search your favorite game here...",
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.white),
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: (_) {
                SearchController.getProducts(
                  title: searchController.text != ""
                      ? searchController.text
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  const _ItemWidget({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
      height: 224,
      width: 150,
      child: Stack(
        children: [
          _buildItemBottomContainer(),
          _buildItemTopContainer(),
        ],
      ),
    );
  }

  _buildItemBottomContainer() {
    return Positioned(
      bottom: 0,
      child: Container(
        height: 110,
        width: 150,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              const Color(0x00152245),
              Colors.grey.withOpacity(0.6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: _buildItemDescription(),
      ),
    );
  }

  _buildItemDescription() {
    return Container(
      width: 145,
      height: 105,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.black,
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.title ?? "",
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
          ),
          Text(
            product.type ?? "",
            style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 10,
                fontWeight: FontWeight.w500),
          ),
          _buildGenreTags(),
        ],
      ),
    );
  }

  _buildGenreTags() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 14, // Adjust the height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: product.genre?.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(right: 8.0),
            decoration: BoxDecoration(
              color: Color(0xFF316BFF),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
            child: Text(
              product.genre?[index].title ?? "",
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 10),
            ),
          );
        },
      ),
    );
  }

  _buildItemTopContainer() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(
        product.image ?? "",
        height: 120,
        width: 145,
        fit: BoxFit.fill,
      ),
    );
  }
}

class RelatedSearchWidget extends StatelessWidget {
  const RelatedSearchWidget({
    Key? key,
    required this.products,
  }) : super(key: key);

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Related to your search',
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        Expanded(
          child: Obx(
            () => GridView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return _ItemWidget(
                  product: products[index],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
