import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Widget? prefixWidget;
  final VoidCallback? onTap;
  const CustomButton({
    super.key,
    required this.label,
    this.prefixWidget,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Builder(
                builder: (context) {
                  if (prefixWidget != null) {
                    return prefixWidget!;
                  } else {
                    return Icon(
                      Icons.account_balance,
                      color: Colors.transparent,
                    );
                  }
                },
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(
                Icons.account_balance,
                color: Colors.transparent,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomOutlineButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  const CustomOutlineButton({
    super.key,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          // color: Colors.black,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSmallButton extends StatelessWidget {
  final bool isSelected;
  final String label;
  final IconData icon;
  final VoidCallback? onTap;
  const CustomSmallButton({
    super.key,
    required this.isSelected,
    required this.label,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            // height: 50,
            decoration: BoxDecoration(
              color: isSelected ? Colors.black : Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: isSelected ? Colors.white : Color(0xFF2A3256),
                  ),
                  SizedBox(width: 10),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected ? Colors.white : Color(0xFF2A3256),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
