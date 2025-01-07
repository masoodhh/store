import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/manager/cart/cart_bloc.dart';
import 'package:store/core/params/params.dart';
import 'package:store/core/params/text_styles.dart';
import 'package:store/features/product/presentation/pages/product.dart';
import 'package:store/features/search/presentation/manager/search/search_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../../../../core/params/colors.dart';
import '../../../../core/widgets/spacer.widget.dart';
import '../../../../logger.dart';
import '../../../home/domain/entities/product_entity.dart';
import '../../../home/presentation/manager/home/home_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  static const routeName = '/search';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<SearchBloc>(context).add(InicialEvent());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      height: 110,
      child: Stack(
        children: [
          const Center(
              child: Text(
            "Search",
            style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          )),
          Positioned(
              left: 0,
              child: Container(
                width: 50,
                height: 70,
                margin: const EdgeInsets.only(top: 20, bottom: 20, left: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1, color: Colors.white)),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 25),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: MyColors.primaryColor,
      child: Column(
        children: [
          _buildAppBar(context),
          _buildSearchBox(),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(10),
              child: _buildProductList(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSearchBox() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.white),
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                context.read<SearchBloc>().add(ChangeSearchTextEvent(_searchController.text));
                context.read<SearchBloc>().add(ConfirmSearchEvent());
                _searchController.clear();
              },
              icon: const Icon(
                Icons.search,
                color: Colors.black45,
                size: 30,
              )),
          Expanded(
              child: TextField(
            controller: _searchController,
            style: const TextStyle(color: Colors.black54, fontSize: 20),
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          )),
          IconButton(
              onPressed: () {
                searchFilter(context);
              },
              icon: const Icon(
                Icons.filter_alt,
                color: Colors.black45,
                size: 30,
              ))
        ],
      ),
    );
  }

  Widget _buildProductList() {
    return BlocBuilder<SearchBloc, SearchState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status == Status.SUCCESS) {
          return SingleChildScrollView(
            child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.spaceBetween,
              runAlignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 15,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "Results for your search: ${state.searchFilter.text}",
                      style: MyTextStyles.header3,
                    ),
                  ),
                ),
                for (ProductEntity product in state.products) _buildProductWidget(product),
              ],
            ),
          );
        } else if (state.status == Status.INITIAL) {
          return const Center(
            child: Text(
              "No products found",
              style: MyTextStyles.header2,
            ),
          );
        } else if (state.status == Status.LOADING) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildProductWidget(ProductEntity product) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Product(product: product)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: MyColors.primaryBackgroundColor,
        ),
        padding: const EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width / 2 - 15,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: "product${product.id}",
              child: Image.asset(
                product.image,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
            Text(
              product.title,
              style: const TextStyle(
                fontSize: 20,
                color: MyColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SpacerV(5),
            Text(
              "${product.price} Cal",
              style: const TextStyle(fontSize: 15, color: Colors.grey),
            ),
            SpacerV(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "&${product.price}",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () => BlocProvider.of<CartBloc>(context).add(addProduct(product)),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.orange,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void searchFilter(BuildContext context) {
    final List<Data> chartData = <Data>[
      Data(x: 6.0, y: 1),
      Data(x: 7.0, y: 2),
      Data(x: 8.0, y: 3),
      Data(x: 9.0, y: 4),
      Data(x: 10.0, y: 5),
      Data(x: 11.0, y: 2),
      Data(x: 12.0, y: 3.5),
      Data(x: 13.0, y: 5),
      Data(x: 14.0, y: 3),
      Data(x: 15.0, y: 4.5),
      Data(x: 16.0, y: 4),
      Data(x: 17.0, y: 3.5),
      Data(x: 18.0, y: 4),
      Data(x: 19.0, y: 1),
      Data(x: 20.0, y: 1.5),
      Data(x: 21.0, y: 2),
      Data(x: 22.0, y: 3),
      Data(x: 23.0, y: 2),
    ];
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      // isDismissible: false, // غیرفعال کردن بسته شدن دیالوگ با کلیک خارج از آن
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)), // گوشه‌های گرد در بالای دیالوگ
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16), // فاصله داخلی
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Filter",
                    style: TextStyle(color: MyColors.primaryColor, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle, // شکل دایره
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context); // بستن دیالوگ
                      },
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Text(
                "Price Range",
                style: TextStyle(color: MyColors.primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  return SfRangeSelector(
                    min: 1000,
                    max: 100000000,
                    onChangeEnd: (SfRangeValues value) => context
                        .read<SearchBloc>()
                        .add(ChangeSearchPriceEvent(minPrice: value.start, maxPrice: value.end)),
                    initialValues: SfRangeValues(
                        state.searchFilter.minPrice ?? 100, state.searchFilter.maxPrice ?? 100000000),
                    enableTooltip: true,
                    inactiveColor: Colors.transparent,
                    tooltipShape: const SfPaddleTooltipShape(),
                    child: SizedBox(
                      height: 130,
                      child: SfCartesianChart(
                        margin: const EdgeInsets.all(0),
                        primaryXAxis: const NumericAxis(
                          minimum: 0,
                          maximum: 28,
                          isVisible: false,
                        ),
                        primaryYAxis: const NumericAxis(isVisible: false),
                        series: <ColumnSeries<Data, double>>[
                          /* ColumnSeries<Data, double>(

                          selectionBehavior: SelectionBehavior(
                            selectedColor: Colors.purple,
                          ),
                          color: Colors.grey.shade300,
                          dataSource: chartData.where((data) => data.x < 5).toList(),
                          borderWidth: 1,
                          width: 1,
                          borderColor: Colors.grey,
                          xValueMapper: (Data sales, int index) => sales.x,
                          yValueMapper: (Data sales, int index) => sales.y),
                      ColumnSeries<Data, double>(
                          selectionBehavior: SelectionBehavior(
                            selectedColor: Colors.purple,
                            enable: true,
                          ),
                          dataSource: chartData
                              .where((data) =>
                                  data.x <= 15 && data.x >= 5)
                              .toList(),
                          borderWidth: 1,
                          width: 1,
                          borderColor: Colors.grey,
                          xValueMapper: (Data sales, int index) => sales.x,
                          yValueMapper: (Data sales, int index) => sales.y),
                      ColumnSeries<Data, double>(
                          color: Colors.grey.shade300,
                          dataSource: chartData.where((data) => data.x > 15).toList(),
                          borderWidth: 1,
                          width: 0.5,
                          borderColor: Colors.grey,
                          xValueMapper: (Data sales, int index) => sales.x,
                          yValueMapper: (Data sales, int index) => sales.y)
*/
                          ColumnSeries<Data, double>(
                              color: Colors.grey.shade300,
                              dataSource: chartData,
                              width: 0.5,
                              xValueMapper: (Data sales, int index) => sales.x,
                              yValueMapper: (Data sales, int index) => sales.y)
                        ],
                      ),
                    ),
                  );
                },
              ),
              _buildCategories(),
              _buildRecentlySearch(),
              Expanded(child: Container()),
              InkWell(
                onTap: () {
                  context.read<SearchBloc>().add(ChangeSearchTextEvent(_searchController.text));
                  context.read<SearchBloc>().add(ConfirmSearchEvent());
                  _searchController.clear();
                  Navigator.pop(context);
                },
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: MyColors.primaryColor,
                  ),
                  child: const Center(
                    child: Text(
                      "Confirm",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategories() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.categories.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Categories",
                style: TextStyle(color: MyColors.primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SpacerV(10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int i = 0; i < state.categories.length; i++)
                      _buildCategoryWidget(state.categories[i].id, state.categories[i].title,
                          state.categories[i].isChecked, true),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildCategoryWidget(int? id, String title, bool selected, bool isCategory) {
    return InkWell(
      onTap: () {
        if (isCategory) {
          context.read<SearchBloc>().add(ChangeSearchCategoryEvent(id!));
        } else {
          context.read<SearchBloc>().add(ChooseRecentSearchEvent(title));
          _searchController.text = title;
        }
        // BlocProvider.of<SearchBloc>(context).add(event);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: selected ? MyColors.primaryColor : MyColors.primaryBackgroundColor,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: selected ? Colors.white : MyColors.primaryColor,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildRecentlySearch() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.recentlySearches.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SpacerV(10),
              const Text(
                "Recently Search",
                style: TextStyle(color: MyColors.primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SpacerV(10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int i = 0; i < state.recentlySearches.length; i++)
                      _buildCategoryWidget(null, state.recentlySearches[i], false, false),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

/*
  Widget _buildRecentlySearch2() {
    return Column(
      children: [
        SpacerV(20),
        const Text(
          "Recently Search",
          style: TextStyle(color: MyColors.primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Wrap(
          runSpacing: 10,
          children: [
            _buildCategoryWidget(1, "title", true, ChangeCategoryEvent(0)),
            _buildCategoryWidget(2, "Big title2", false, ChangeCategoryEvent(1)),
            _buildCategoryWidget(1, "title3", false, ChangeCategoryEvent(2)),
            _buildCategoryWidget(1, "title4", false, ChangeCategoryEvent(3)),
            _buildCategoryWidget(1, "title5", false, ChangeCategoryEvent(4)),
            _buildCategoryWidget(1, "title6", false, ChangeCategoryEvent(5)),
          ],
        ),
      ],
    );
  }
*/
}

class Data {
  Data({required this.x, required this.y});

  final double x;
  final double y;
}
