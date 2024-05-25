import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Driver/config/colors.dart';

class FloorSelector extends StatelessWidget {
  const FloorSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        focusColor: Colors.white,
        items: const [
          DropdownMenuItem(
            child: const Text("1st Car park"),
            value: "1st Car park",
          ),
          DropdownMenuItem(
            child: const Text("2nd Car park"),
            value: "2nd Car park",
          ),
          DropdownMenuItem(
            child: const Text("3rd Car park"),
            value: "3rd Car park",
          )
        ],
        onChanged: (value) {
        },
        hint: Text(
            "1 Car park",
            style: TextStyle(
              color: blueColor,
              fontSize: 15,
            ),
          ),);
  }
}
