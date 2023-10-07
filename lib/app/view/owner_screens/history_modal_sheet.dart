import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoryModalSheet extends StatelessWidget {
  const HistoryModalSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        // color: Colors.amber,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Reset",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(context);
                },
                child: Icon(CupertinoIcons.xmark),
              )
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Last 90 days",
                style: TextStyle(
                  fontSize: 18,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(context);
                },
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.green,
                  child: CircleAvatar(
                    radius: 13,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 11,
                      backgroundColor: Colors.green,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Choose date",
                style: TextStyle(
                  fontSize: 18,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(context);
                },
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.green,
                  child: CircleAvatar(
                    radius: 13,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 11,
                      backgroundColor: Colors.green,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Starting from",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  Container(
                    height: 50,
                    // width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: Color(0xFF000000).withOpacity(0.05),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "21 June 2020",
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          CupertinoIcons.chevron_down,
                          color: Colors.white,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "To",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  Container(
                    height: 50,
                    // width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: Color(0xFF000000).withOpacity(0.05),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "21 June 2020",
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          CupertinoIcons.chevron_down,
                          color: Colors.white,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Center(
              child: Text(
                "Filter",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
