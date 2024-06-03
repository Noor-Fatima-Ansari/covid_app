import 'dart:async';
import 'dart:math' as math ;
import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:covid_app/totalData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 10), (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> TotalData()));
    },
    );
  }

  late final AnimationController controller= AnimationController(
    vsync: this,
  duration: Duration(seconds: 10),)..repeat();

   @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
          animation:  controller,
          builder: (BuildContext context, Widget? child ){
            return Transform.rotate(angle: controller.value * 2.0 * math.pi,
            child: child,);
          },
            child: Center(
              child: Container(
                height: 200,
                width: 200,
                child: const Center(
                  child: Image(
                    image: AssetImage('images/virus.png'),
                  ),
                ),
              ),
            ),
          ),

         SizedBox(height: 20,),

          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * .09,

              child: AnimatedTextKit(
                  animatedTexts: [
                    ScaleAnimatedText('Covid 19 App', textStyle: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 30)),

                  ],
                ),
            ),
          ),



        ],

      ),
    );
  }
}



