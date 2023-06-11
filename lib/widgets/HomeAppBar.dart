import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              "Seven Store",
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
          ),
          Spacer(),
          Image.asset(
            "images/logo.jpeg",
            height: 50,
            width: 50,
          )
        ],
      ),
    );
    
  }
}
