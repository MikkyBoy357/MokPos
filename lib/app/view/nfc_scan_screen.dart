import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mokpos/app/view_model/shop/shop_view_model.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';
import 'package:provider/provider.dart';

import '../../base/constant.dart';
import '../../widgets/back_button_black.dart';
import '../view_model/customer/customer_view_model.dart';
import 'nfc_common/nfc_session.dart';

class TagReadModel with ChangeNotifier {
  NfcTag? tag;

  Map<String, dynamic>? additionalData;

  Future<String?> handleTag(
    String actionType,
    NfcTag tag,
    BuildContext context,
    Future<void> Function(BuildContext context, NfcTag tag,
            {required String actionType})
        afterFunction,
  ) async {
    this.tag = tag;
    additionalData = {};

    Object? tech;

    print("===MyTAG===> ${tag.data}");
    await afterFunction(context, tag, actionType: actionType);
    // Provider.of<CustomerViewModel>(context, listen: false).setTag(context, tag);

    // todo: more additional data
    if (Platform.isIOS) {
      tech = FeliCa.from(tag);
      if (tech is FeliCa) {
        final polling = await tech.polling(
          systemCode: tech.currentSystemCode,
          requestCode: FeliCaPollingRequestCode.noRequest,
          timeSlot: FeliCaPollingTimeSlot.max1,
        );
        additionalData!['manufacturerParameter'] =
            polling.manufacturerParameter;
      }
    }

    notifyListeners();
    return '[Tag - Read] is completed.';
  }
}

class NfcScanScreen extends StatelessWidget {
  const NfcScanScreen({super.key});

  static Widget withDependency() => ChangeNotifierProvider<TagReadModel>(
        create: (context) => TagReadModel(),
        child: NfcScanScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return Consumer2<ShopViewModel, CustomerViewModel>(
      builder: (context, shopViewModel, customerViewModel, _) {
        return Scaffold(
          // backgroundColor: Colors.green,
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Spacer(),
                Container(
                  // height: 250,
                  child: Builder(builder: (context) {
                    if (customerViewModel.customerData == null) {
                      return SizedBox();
                    } else {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("ID:"),
                              SizedBox(height: 10),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 120,
                                child: Text(
                                  "${customerViewModel.customerData!.id}",
                                  softWrap: true,
                                ),
                              ),
                              // Text("${customerViewModel.customerData!.id}"),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text("Name:"),
                              SizedBox(height: 10),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 120,
                                child: Text(
                                  "${customerViewModel.customerData!.name}",
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          // Row(
                          //   children: [
                          //     Text("email:"),
                          //     MyTextButton(
                          //       backgroundColor: Color(0xFF2A3256),
                          //       label:
                          //           "${customerViewModel.customerData!.email}",
                          //     ),
                          //   ],
                          // ),
                        ],
                      );
                    }
                  }),
                ),
                SizedBox(height: 20),
                Center(
                  child: InkWell(
                    onTap: () => startSession(
                      context: context,
                      handleTag: (tag) =>
                          Provider.of<TagReadModel>(context, listen: false)
                              .handleTag(
                        "payment",
                        tag,
                        context,
                        customerViewModel.checkTagForId,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.black.withOpacity(0.05),
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.black.withOpacity(0.47),
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          radius: 60,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.wifi_tethering_sharp,
                                size: 50,
                              ),
                              Text(
                                "NFC",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  "Payer",
                  style: TextStyle(
                    // color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "\$${shopViewModel.totalPrice}",
                  style: TextStyle(
                    // color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  "Press and get an NFC closer to your device",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    // color: Colors.white,
                    // fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // MyTextButton(
                //   onTap: () async {
                //     await customerViewModel.makePayment(
                //       context,
                //       amount: shopViewModel.totalPrice,
                //     );
                //   },
                //   margin: EdgeInsets.symmetric(horizontal: 20),
                //   label: "Simulate Card Scan",
                // )
                // Spacer(),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Builder(builder: (context) {
            if (customerViewModel.customerData == null) {
              return MyTextButton(
                onTap: () {
                  Constant.backToPrev(context);
                },
                margin: EdgeInsets.symmetric(horizontal: 20),
                label: "BACK",
              );
            } else {
              return MyTextButton(
                onTap: () {
                  customerViewModel.makePayment(context,
                      amount: shopViewModel.totalPrice);
                  // Constant.navigatePush(context, NfcScanScreen());
                },
                backgroundColor: Colors.green,
                margin: EdgeInsets.symmetric(horizontal: 20),
                label: "Confirm User and Pay",
              );
            }
          }),
        );
      },
    );
  }
}
