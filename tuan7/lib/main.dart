import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Product{
  String sreach_image;
  int styleid;
  String brands_filter_facet;
  int price;
  String product_additional_info;
  Product({
    required this.sreach_image,
    required this.styleid,
    required this.brands_filter_facet,
    required this.price,
    required this.product_additional_info
  });
}
class ProductListScreen extends StatefulWidget{
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}
class _ProductListScreenState extends State<ProductListScreen>{
  late List<Product> products;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    products=[];
    fetchProducts();
  }
  // doi du lieu tu map sang list
  List<Product> convertMapToList(Map<String,dynamic> data){
    List<Product> productList =[];
    for(int i=0;i<data['products'].length;i++){
      dynamic value = data['products'][i];
      print(value);
      Product product =Product(
          sreach_image: value['search_image'] ?? '',
          styleid: value['styleid'] ?? '',
          brands_filter_facet: value['brands_filter_facet'] ?? '',
          price: value['price'] ?? '',
          product_additional_info: value['product_additional_info'] ?? '');
      productList.add(product);
    }
    print(data.length);
    return productList;
  }
  Future<void>fetchProducts() async{
    final response =await http.get(Uri.parse("https://hungnttg.github.io/shopgiay.json"));
    if(response.statusCode==200){
      final Map<String ,dynamic> data = json.decode(response.body);
      setState(() {
        products=convertMapToList(data);
      });
    }
    else{
      throw Exception("khong co du lieu");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Product List"),
        ),
        body: products != null ?//neu co du liue thi tra ve list view
        ListView.builder(
            itemCount: products.length,
            itemBuilder: (context,index){
              return ListTile(
                title: Text(products[index].brands_filter_facet),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Price: ${products[index].price}'),
                  ],
                ),
                leading: Image.network(
                  products[index].sreach_image,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),

              );
            }
        ): Center(
          child: CircularProgressIndicator(),
        )
    );
  }
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Danh sách sản phẩm",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        // Sử dụng Material 3
        useMaterial3: true,
      ),
      home: ProductListScreen(),
    );
  }
}
void main(){
  runApp(const MyApp());
}