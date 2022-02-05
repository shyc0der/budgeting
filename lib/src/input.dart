import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget inputField(String label, TextEditingController controller, bool error, {
  Function(String val)? onChanged, bool isNumbers = false, bool invalid = false, bool isHidden = false, int maxLines = 1,
  TextInputType? keyboardType
}) {
    return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      
    // label
     Padding(
       padding: const EdgeInsets.all(6),
       child: Text(label),
     ),
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
            Radius.circular(10.0)),
        border: Border.all(width: .8, color: error ? Colors.redAccent : Colors.black)
      ),
      child: SizedBox(
        width:  290,
        child: TextField(
          keyboardType: keyboardType,
          controller: controller,
          onChanged: onChanged,
          obscureText: isHidden,
          maxLines: maxLines,
          inputFormatters: [
            if(isNumbers) FilteringTextInputFormatter.allow(RegExp(r'\d+\.?\d*'))
          ],
          decoration: InputDecoration(
            errorText: error ? "\t\t*required!" : invalid ? "\t\t*$label invalid!" : null,
            border: const UnderlineInputBorder(borderSide: BorderSide.none)),

            
        ),
      ),
    ),
        ],
      );
  }