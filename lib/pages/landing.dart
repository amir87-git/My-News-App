import 'package:flutter/material.dart';
import 'package:my_news/pages/home.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 60,),
        child: Column(children: [
        Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              "asset/image/P.jpg",
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.height/1.7,
              fit: BoxFit.cover),
          ),
        ),


        const SizedBox(height: 60,),
        const Text("News around the world FOR YOU!", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),

        const SizedBox(height: 5,),
        const Text("Best time to read, explore the world", style: TextStyle(color: Color.fromARGB(185, 66, 66, 66), fontSize: 12, fontWeight: FontWeight.w500),),


        const SizedBox(height: 60,),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()),);
          },
          child: Container(
            width: MediaQuery.of(context).size.width/1.4,
            child: Material(
              borderRadius: BorderRadius.circular(30),
              elevation: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(30)),
                child: const Center(child: 
                Text("Get Started", 
                style: TextStyle(
                  color: Colors.white, 
                  fontSize: 16, 
                  fontWeight: FontWeight.normal),)),
              ),
            ),
          ),
        )

      ],),),
    );
  }
}