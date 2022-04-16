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
                 child: GridView.extent(maxCrossAxisExtent: 1,
                 padding: const EdgeInsets.all(4),
                 mainAxisSpacing: 4,
                 crossAxisSpacing: 4,
                 children:  [
                   Card(
                     child: Column(children: [
                       Text('jjjjjjjjjjjjjjjjjjj'),
                       //image
                       Image.asset('assets/images/budget.png',height: 100,
                       width: 100,)
                      
                     // Total Amount as of feb
                       //

                     ],),
                   )

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