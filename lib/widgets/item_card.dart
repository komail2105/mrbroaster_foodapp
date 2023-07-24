import 'package:flutter/material.dart';

class ItemCard extends StatefulWidget {
  final BuildContext? context;
  final Color? color;
  final double? cardHeight;
  final String? colorName;
  final String? productPrice;
  final String? productQuantity;
  final String? productTitle;
  final IconData? trailingIcon;
  final bool? isExpandable;
  final Alignment? itemDetailsAlignment;
  final double titleFontSize;
  const ItemCard(
      {super.key,
      this.context,
      this.itemDetailsAlignment = Alignment.center,
      this.color = Colors.white,
      this.isExpandable = true,
      this.trailingIcon = Icons.edit,
      this.cardHeight = 100,
      this.productTitle = 'Title',
      this.colorName = 'Color',
      this.productPrice = 'Price',
      this.productQuantity = "Quantity",
      this.titleFontSize = 18});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  IconData arrowIcon = Icons.keyboard_arrow_down_rounded;
  bool changeIcon = false;
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.cardHeight,
      width: MediaQuery.of(context).size.width,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.only(bottom: 8),
        elevation: 2,
        child: InkWell(
            hoverColor: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            onLongPress: () => {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Center(
                          child: SizedBox(
                        height: 64,
                        width: 64,
                        child: Icon(Icons.image),
                      )),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.productTitle!,
                                style: TextStyle(
                                    fontSize: widget.titleFontSize,
                                    fontWeight: FontWeight.w600),
                              ),
                              const Text(
                                "Category Name",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: IconButton(
                            splashRadius: 20,
                            onPressed: () => {},
                            icon: Icon(widget.trailingIcon!)),
                      )
                    ],
                  ),
                ),
                Scrollbar(
                  controller: scrollController,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    alignment: widget.itemDetailsAlignment,
                    height: 44,
                    margin: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        border: Border.symmetric(
                            horizontal: BorderSide(color: Colors.black87))),
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      physics:
                          const ScrollPhysics(parent: BouncingScrollPhysics()),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      controller: scrollController,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.productPrice!,
                              style: const TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const VerticalDivider(
                              thickness: .25,
                              color: Colors.black,
                              endIndent: 4,
                              indent: 4,
                              width: 48,
                            ),
                            Text(
                              widget.productQuantity!,
                              style: const TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const VerticalDivider(
                              thickness: .25,
                              color: Colors.black,
                              endIndent: 4,
                              indent: 4,
                              width: 48,
                            ),
                            const Center(
                              child: Text(
                                "Active",
                                style: TextStyle(fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 4.0),
                  child: Text(
                    "Description: Here write the description about your product upto 120 words.",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
