import 'package:cphi/core/extension/content_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../theme/app_colors.dart';
import 'boldTextView.dart';

class CustomSearchView extends StatelessWidget {
  String title;
  bool? hideFilter;
  final Function press;
  final Function(String) onSubmit;
  final Function(String) onClear;
  Rx<TextEditingController> textController;
  CustomSearchView(
      {Key? key,
      required this.title,
      this.hideFilter,
      required this.press,
      required this.onSubmit,
      required this.onClear,
      required this.textController})
      : super(key: key);
  var inputData = "".obs;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      width: double.infinity,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 9,
              child: Container(
                width: context.width,
                padding: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    border: Border.all(color: indicatorColor, width: 0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        autocorrect: false,
                        style: const TextStyle(fontSize: 12),
                        controller: textController?.value,
                        decoration: const InputDecoration(
                            hintText: ' Search here', border: InputBorder.none),
                        onSubmitted: (data) {
                          inputData(data);
                          if (data.isNotEmpty) {
                            Future.delayed(Duration.zero, () async {
                              onSubmit(data);
                            });
                          }
                        },
                        onChanged: (data) {
                          inputData(data);
                        },
                      ),
                    ),
                    Obx(() => textController.value.text.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Future.delayed(Duration.zero, () async {
                                  textController!.value.clear();
                                  onClear("");
                                });
                              },
                              child: const Icon(
                                Icons.clear,
                                size: 15,
                              ),
                            ),
                          )
                        : const SizedBox()),
                    InkWell(
                      onTap: () {
                        Future.delayed(Duration.zero, () async {
                          onSubmit(textController!.value.text);
                        });
                      },
                      child: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                              color: homeColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6))),
                          child: const Icon(Icons.search)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            hideFilter == null
                ? Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        Future.delayed(Duration.zero, () async {
                          press();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset(
                          "assets/icons/filter_icon.png",
                          color: primaryColor1,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class SearchView extends StatelessWidget {
  String title;
  final Function press;
  final Function(String) onSubmit;
  Rx<TextEditingController> textController;
  SearchView(
      {Key? key,
      required this.title,
      required this.press,
      required this.onSubmit,
      required this.textController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0),
      width: context.width,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: indicatorColor,
          border: Border.all(color: indicatorColor, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(40))),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        leading: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(6))),
          child: const Icon(
            Icons.search_rounded,
            size: 25,
          ),
        ),
        title: TextField(
          style: const TextStyle(fontSize: 16),
          controller: textController?.value,
          decoration: InputDecoration(
              hintText: title,
              border: InputBorder.none,
              hintStyle: TextStyle(color: address_color)),
          onChanged: (data) {
            Future.delayed(Duration.zero, () async {
              onSubmit(data);
            });
          },
          onSubmitted: (data) {
            Future.delayed(Duration.zero, () async {
              onSubmit(data);
            });
          },
        ),
        trailing: InkWell(
          onTap: () {
            Future.delayed(const Duration(seconds: 1), () async {
              textController!.value.clear();
              onSubmit("");
            });
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(6))),
            child: Obx(() => textController!.value.text.isNotEmpty
                ? const Icon(Icons.clear)
                : const Icon(Icons.clear)),
          ),
        ),
      ),
    );
  }
}
