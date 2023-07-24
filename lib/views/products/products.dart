import 'package:flutter/material.dart';
import 'package:mrbroaster_foodapp/constants/constants.dart';

import '../../widgets/item_card.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bColor,
        elevation: 0,
        title: Text(
          "Products".toUpperCase(),
          style: const TextStyle(color: Colors.black),
        ),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              useSafeArea: true,
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return const AddProductsPanel();
              });
        },
        backgroundColor: bColor,
        shape: const StadiumBorder(),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 10,
          controller: scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          itemBuilder: (context, index) => ItemCard(
            itemDetailsAlignment: Alignment.centerLeft,
            cardHeight: 220,
            productPrice: 'Price: 5000',
            productQuantity: 'Qunatity: 2000',
            productTitle: 'Food Name Here',
            context: context,
          ),
        ),
      ),
    );
  }
}

class AddProductsPanel extends StatefulWidget {
  const AddProductsPanel({super.key});

  @override
  State<AddProductsPanel> createState() => _AddProductsPanelState();
}

class _AddProductsPanelState extends State<AddProductsPanel> {
  final TextEditingController name = TextEditingController();

  String? selectCategory = "Select Category";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          child: Wrap(
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              SizedBox(
                width: 280,
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: name,
                  maxLength: 20,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 14),
                  decoration: const InputDecoration(
                    label: Text(
                      "Name",
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 280,
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 14),
                  decoration: const InputDecoration(
                    label: Text(
                      "Qunatity",
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 280,
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 14),
                  decoration: const InputDecoration(
                    label: Text(
                      "Price",
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 280,
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  maxLength: 120,
                  maxLines: 4,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.black87),
                  decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      label: Text(
                        "Description",
                      ),
                      isDense: true),
                ),
              ),
              SizedBox(
                width: 280,
                height: 56,
                child: DropdownButtonFormField(
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        fontSize: 14),
                    dropdownColor: Colors.white,
                    hint: Text(
                      selectCategory!,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    focusColor: Colors.transparent,
                    isDense: true,
                    items: <String>[
                      'Men',
                      'Women',
                      'Kids',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) =>
                        selectCategory = newValue! as String?),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      fixedSize: const Size(96, 36),
                      backgroundColor: Colors.red.shade800,
                      textStyle: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Clear All",
                    ),
                  ),
                  customButton(
                      fontSize: 12,
                      height: 36,
                      width: 96,
                      title: "Add",
                      onClick: () => {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
