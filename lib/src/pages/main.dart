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
               const SizedBox(
                height: 100,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black87,
                    size: 27,
                  )),
                  const SizedBox(
                height: 50,
              ),
               Expanded(
                 child: Wrap(
                           children: [
                        Column(
                          children: [
                            Image.asset('assets/images/budget.png',width: 200,),
                            Text('Budget',style: TextStyle(fontWeight: FontWeight.bold),)
                          ],
                        ),
                         Image.asset('assets/images/budget.png', width: 200,),
                         Image.asset('assets/images/budget.png',width: 200,)
                     ],
                     ),
                 ),

                
             ],
           ),
         )
        ]
      ),
      
    );
  }
}