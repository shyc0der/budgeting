import 'package:flutter/material.dart';

Widget ImageText(String text, String path, {Function() ? onTap}) {
  return Padding(
 padding: const EdgeInsets.only(bottom: 10),
    child: InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            path,
            width: 150,
          ),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 20,
            height: 40,
          ),
        ],
      ),
    ),
  );
}
