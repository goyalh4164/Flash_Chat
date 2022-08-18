import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  // so that we can access it without creating the object
  //declaring it constant too so that we can not change its value by mistake
  static const String id = 'welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

//we are using the  SingleTickerProviderStateMixin because we want to animate only the one thing
class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),

      //now we have updated the upper bound from 1 to 100 seconds
      //here this is used to refrence the type of ticker this class contains
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    //we are saying the container to move forward line 0,0.01,0.02,01,  it usually takes 60 steps
    // controller.forward();
    // if you want reverse efffect then you can do controller.reverse
    //this function available below is used to detect the current value of the ticker
    // now in this case animation size decreases from 100 to 0
    controller.reverse();
    //we can use this value according to our requirements

    controller.addListener(() {
      //we are calling the setstate again and again untill the value is changing hence we are now rebuilting our built methods and able to see the changes
      setState(() {});
      print(controller.value);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Hero(
                  //tag must be same on both the screens
                  tag: 'logo',
                  child: Container(
                    child: Image.network(
                        'https://raw.githubusercontent.com/londonappbrewery/flash-chat-flutter/master/images/logo.png'),
                    //lets play with the height of the img contained in the container
                    //since animation can only take value from[0,1] so we can multiply it with something for example 100 to see the bigger effects
                    height: animation.value * 100,
                  ),
                ),
                Text(
                  'Flash Chat',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text('Log In'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text('Register'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
