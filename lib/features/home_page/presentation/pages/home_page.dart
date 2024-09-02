import 'package:flutter/material.dart';
import 'package:store/pages/food/product.dart';
import 'package:bloc/bloc.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Color(0xFF18263E),
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
              color: Colors.white),
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Daily \nGrocery Food",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1e1f22),
                        fontSize: 40,
                      ),
                      softWrap: true,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 1, color: Colors.black12)),
                      padding: EdgeInsets.all(10),
                      height: 80,
                      child: Icon(
                        Icons.search,
                        color: Color(0xFF18263E),
                        size: 40,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CategoryWidget(true, "Fruits"),
                      CategoryWidget(false, "Fast-food"),
                      CategoryWidget(false, "Wegtebales"),
                      CategoryWidget(false, "Fast-food"),
                      CategoryWidget(false, "Fast-food"),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Popular Fruits",
                      style: TextStyle(
                          color: Color(0xFF18263E),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(
                      "See All",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.spaceBetween,
                    runAlignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runSpacing: 15,
                    children: [
                      for (int i = 0; i < 8; i++)
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Product()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey[100],
                            ),
                            padding: EdgeInsets.all(15),
                            width: MediaQuery.of(context).size.width / 2 - 15,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Hero(
                                    tag: "product$i",
                                    child: Image.network(
                                      'https://picsum.photos/20$i',
                                      fit: BoxFit.cover,
                                    )),
                                Text(
                                  "Fruit $i",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFF18263E),
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "100 Cal",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.grey),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "\&75.68",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          color: Colors.orange,
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 25,
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
          height: 70,
          color: Color(0xFF18263E),
          child: Container(
              child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buttomNavItem(true, Icons.home, "home"),
                buttomNavItem(false, Icons.shop, "shop"),
                buttomNavItem(false, Icons.person, "profile"),
                buttomNavItem(false, Icons.gif_box, "gift"),
              ],
            ),
          ))),
    );
  }

  Widget buttomNavItem(bool selected, IconData icon, String title) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: selected ? Colors.white : Colors.grey,
          ),
          Text(
            title,
            style: TextStyle(
              color: selected ? Colors.white : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget CategoryWidget(bool selected, String title) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: selected ? Color(0xFF18263E) : Colors.grey[100]),
      child: Text(
        title,
        style: TextStyle(
            color: selected ? Colors.white : Color(0xFF18263E), fontSize: 15),
      ),
    );
  }
}
