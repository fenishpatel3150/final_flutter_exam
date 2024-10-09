
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/ProductController.dart';
import '../../model/ProductModel.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    TextEditingController txtId = TextEditingController();
    TextEditingController txtProductName = TextEditingController();
    TextEditingController txtProductPrice = TextEditingController();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffec2313),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Add Your Details'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: txtId,
                      decoration: InputDecoration(hintText: 'Enter your Id'),
                    ),
                    TextField(
                      controller: txtProductName,
                      decoration: InputDecoration(hintText: 'Enter your product name'),
                    ),
                    TextField(
                      controller: txtProductPrice,
                      decoration: InputDecoration(hintText: 'Enter product price'),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      final product = Product(
                        id: txtId.text,
                        name: txtProductName.text,
                        price: txtProductPrice.text,
                      );
                      productController.addProduct(product);
                      txtId.clear();
                      txtProductName.clear();
                      txtProductPrice.clear();
                      Get.back(); // Close the dialog
                    },
                    child: Text('Submit'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xffec2313),
        title: Text('Home Page', style: TextStyle(color: Colors.white)),
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: productController.productList.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Image.asset(image[index % image.length]),
              title: Text('${productController.productList[index].name}'),
              subtitle: Text('Price: \$${productController.productList[index].price}'),
              trailing: IconButton(
                onPressed: () {
                  productController.deleteProduct(productController.productList[index].id);
                },
                icon: Icon(Icons.delete),
              ),
            );
          },
        );
      }),
    );
  }
}

List<String> image = [
  'assets/image.png',
  'assets/image2.png',
  'assets/image3.png',
  'assets/image4.png',
];