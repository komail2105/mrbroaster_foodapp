import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mrbroaster_foodapp/constants/constants.dart';
import 'package:mrbroaster_foodapp/routes/routing_page.dart';
import 'package:mrbroaster_foodapp/views/details/details.dart';
import 'package:mrbroaster_foodapp/widgets/singleproduct.dart';

class GridViewWidget extends StatefulWidget {
  final String id;
  final String collection;
  final String subCollection;

  const GridViewWidget({
    Key? key,
    required this.subCollection,
    required this.id,
    required this.collection,
  }) : super(key: key);

  @override
  GridViewWidgetState createState() => GridViewWidgetState();
}

class GridViewWidgetState extends State<GridViewWidget> {
  String query = "";
  // ignore: prefer_typing_uninitialized_variables
  var result;
  searchFunction(query, searchList) {
    result = searchList.where((element) {
      return element["productName"].toUpperCase().contains(query) ||
          element["productName"].toLowerCase().contains(query) ||
          element["productName"].toUpperCase().contains(query) &&
              element["productName"].toLowerCase().contains(query);
    }).toList();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    print(widget.id);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bColor,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(widget.collection)
            .doc(widget.id)
            .collection(widget.subCollection)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshort) {
          if (!snapshort.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var varData = searchFunction(query, snapshort.data!.docs);
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  shadowColor: Colors.grey[300],
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        query = value;
                      });
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      fillColor: wColor,
                      hintText: "Search Your Product",
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              result.isEmpty
                  ? const Text("Not Found")
                  : GridView.builder(
                      shrinkWrap: true,
                      itemCount: result.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                        childAspectRatio: 0.6,
                      ),
                      itemBuilder: (ctx, index) {
                        var data = varData[index];
                        return SingleProduct(
                          onTap: () {
                            RoutingPage.goTonext(
                              context: context,
                              navigateTo: DetailsPage(
                                productCategory: data["productCategory"],
                                productId: data["productId"],
                                productImage: data["productImage"],
                                productName: data["productName"],
                                productPrice: data["productPrice"],
                                productRate: data["productRate"],
                                productDescription: data["productDescription"],
                              ),
                            );
                          },
                          productId: data["productId"],
                          productCategory: data["productCategory"],
                          productRate: data["productRate"],
                          productPrice: data["productPrice"],
                          productImage: data["productImage"],
                          productName: data["productName"],
                          productDescription: data["productDescription"],
                        );
                      },
                    ),
            ],
          );
        },
      ),
    );
  }
}
