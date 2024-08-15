import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  const Product({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Color(0xFF18263E),
        child: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
              color: Colors.white),
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Hero(
                        tag: "product1",
                        child: Image.network(
                          'https://picsum.photos/200',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 300,
                        )),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(width: 1, color: Colors.black12)),
                          padding: EdgeInsets.all(10),
                          height: 60,
                          child: Icon(
                            Icons.arrow_back,
                            color: Color(0xFF18263E),
                            size: 30,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Fresh Orange",
                      style: TextStyle(
                          fontSize: 30,
                          color: Color(0xFF18263E),
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF18263E)),
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                            )),
                        SizedBox(width: 10),
                        Text("1Kg",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF18263E),
                                fontSize: 20)),
                        SizedBox(width: 10),
                        Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF18263E)),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ))
                      ],
                    )
                  ],
                ),
                Text("Adminitrated in china",
                    style: TextStyle(color: Colors.grey)),
                SizedBox(height: 10),
                Text(
                  "Product Description",
                  style: TextStyle(
                      fontSize: 30,
                      color: Color(0xFF18263E),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vel urna at nunc bibendum pulvinar. Donec iaculis, purus non tristique fermentum, tellus velit tristique tellus, in mollis dolor felis nec velit. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec vel arcu vel justo tincidunt consectetur. Pellentesque habitant morbi',
                    style: TextStyle(color: Colors.grey)),
                SizedBox(height: 10),
                Text(
                  "Product Reviews",
                  style: TextStyle(
                      fontSize: 30,
                      color: Color(0xFF18263E),
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      NetworkImage('https://picsum.photos/102'),
                                  fit: BoxFit.cover),
                              shape: BoxShape.circle,
                              color: Colors.blue),
                        ),
                        SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Victor Hogon",
                              style: TextStyle(
                                  color: Color(0xFF18263E),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 25),
                                Icon(Icons.star, color: Colors.amber, size: 25),
                                Icon(Icons.star, color: Colors.amber, size: 25),
                                Icon(Icons.star, color: Colors.amber, size: 25),
                                Icon(Icons.star, color: Colors.amber, size: 25),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    Text("16 septombr 2022",
                        style: TextStyle(color: Colors.grey, fontSize: 16))
                  ],
                ),
                SizedBox(height: 10),
                Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vel urna at nunc bibendum pulvinar.',
                    style: TextStyle(color: Colors.grey)),
                SizedBox(height: 10),
                Text(
                  "Similar Products",
                  style: TextStyle(
                      fontSize: 30,
                      color: Color(0xFF18263E),
                      fontWeight: FontWeight.bold),
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
                RichText(
                    text: TextSpan(
                        text: "\$15.35",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        children: [
                      TextSpan(
                        text: "/Kg",
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    ])),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  padding: EdgeInsets.all(10),
                  height: 40,
                  alignment: Alignment.center,
                  width: 200,
                  child: Text(
                    'Add to cart',
                    style: TextStyle(
                        color: Color(0xFF18263E),
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                )
              ],
            ),
          ))),
    );
  }
}
