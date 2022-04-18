import 'package:flutter/material.dart';

import 'background_page.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({ Key? key }) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children :[
         const BackgroundPage(), 
         Padding(
           padding: const EdgeInsets.all(10.0),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Expanded(
                 child: GridView(
                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                   children: [
                      Image.asset('assets/images/budget.png',height: 30,
                       width: 30,),
                       Image.asset('assets/images/budget.png',height: 30,
                       width: 30,),
                       Image.asset('assets/images/budget.png',height: 30,
                       width: 30,)
                   ],
                   ),

                )
             ],
           ),
         )
        ]
      ),
      
    );
  }
}