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

  Widget elevatedButton(String label ,double size,Alignment align,double height){
        return   Align(
                  alignment: align,
                   child: Container(
                   width: size,
                   height: 40,
                   decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8),               
                   ),
                   color: Colors.orange
                   ),
                   margin: const EdgeInsets.symmetric(horizontal: 3), 
                   child: ElevatedButton(onPressed: (){

                   },
                   style: ElevatedButton.styleFrom(
                     primary: Colors.orange,
                     
                   ),
                    child: Container(
                     child: Row( 
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                              Text(label,style:TextStyle(fontWeight: FontWeight.normal,fontSize: height)),
                              const Icon(Icons.arrow_forward),
                              
                              ]),
                   )),
                 ),
           );


  }

  class CustomElavtedButton extends StatelessWidget {
    const CustomElavtedButton({required this.label, this.fontSize, this.iconData, this.onTap, Key? key }) : super(key: key);
    final String label;
    final double? fontSize;
    final IconData? iconData;
    final void Function()? onTap;
  
    @override
    Widget build(BuildContext context) {
      return InkWell(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 27),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(
              stops: const [0.3, 0.8, 1],
              colors: [
                Colors.orangeAccent,
                Colors.orange,
                Colors.orange[800]!,
              ]
            )
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
         children: [
              // label
              Text(
                label,
                style:TextStyle(fontSize: fontSize, fontWeight: FontWeight.normal, color: Colors.white)
              ),

              const SizedBox(width: 10,),

              // icon
              Icon(iconData, color: Colors.white)
            ],
             ),
        ),
      );
    }
  }
