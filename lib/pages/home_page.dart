import 'package:flutter/material.dart';
import 'package:wrapbuilder/wrapbuilder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    List<product> productList = [
      product("laptop", 390, 4, "https://picsum.photos/250?image=9"),
      product("laptop", 256, 3, "https://picsum.photos/250?image=8"),
      product("laptop", 34, 2, "https://picsum.photos/250?image=7"),
      product("laptop", 233, 5, "https://picsum.photos/250?image=6"),
      product("laptop", 140, 4.5, "https://picsum.photos/250?image=5"),
      product("laptop", 500, 4, "https://picsum.photos/250?image=4"),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Container(
        child: WrapBuilder(
            itemCount: 5,
            reversed: false,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            itemBuilder: (context, index) => Container(
                  width: 150,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          decoration: BoxDecoration(color: Colors.red),
                          child: Image.network(
                              productList[index].imageUrl)),
                      Text(productList[index].name),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(productList[index].price.toString() + '\$'),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 15,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 15,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 15,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 15,
                              ),
                              Icon(Icons.star_border,
                                  color: Colors.yellow, size: 15),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                )),
      ),
    );
  }
}

class product {
  final String name;
  final double price;
  final double stars;
  final String imageUrl;

  product(this.name, this.price, this.stars, this.imageUrl);
}
