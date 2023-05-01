import 'package:adhd_app/home.dart';
import 'package:adhd_app/model/onboarding_data.dart';
import 'package:adhd_app/size_configs.dart';
import 'package:flutter/material.dart';
import '../app_styles.dart';
import '../widgets/onboard_widgets.dart';
import './pages.dart';
import 'package:adhd_app/services/auth.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatefulWidget {
  // String email;
  // OnBoardingPage({required this.email});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int currentPage = 0;

  PageController _pageController = PageController(initialPage: 0);

  AnimatedContainer dotIndicator(index) {
    return AnimatedContainer(
      margin: EdgeInsets.only(right: 5),
      duration: Duration(milliseconds: 400),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : kSecondaryColor,
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // initialize size config
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;
    return Scaffold(
      //backgroundColor: Colors.white,
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            flex: 9,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              itemCount: onboardingContents.length,
              itemBuilder: (context, index) => Column(
                children: [
                  SizedBox(
                    height: sizeV * 5,
                  ),
                  Text(
                    onboardingContents[index].title,
                    style: kTitle,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: sizeV * 5,
                  ),
                  Container(
                    height: sizeV * 50,
                    child: Image.asset(
                      onboardingContents[index].image,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: sizeV * 5,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: kBodyText1,
                      children: [
                        TextSpan(text: 'WE CAN '),
                        TextSpan(
                            text: 'HELP YOU',
                            style: TextStyle(
                              //color: Color.fromARGB(255, 199, 88, 100),
                              color: kPrimaryColor,
                            )),
                        TextSpan(text: ' TO BE A BETTER'),
                        TextSpan(text: ' VERSION OF'),
                        TextSpan(
                          text: ' YOURSELF',
                          style: TextStyle(
                            color: kPrimaryColor,
                            //color: Color.fromARGB(255, 199, 88, 100),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: sizeV * 5,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                currentPage == onboardingContents.length - 1
                    ? MyTextButton(
                        buttonName: 'Get Started',
                        textcolor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                // builder: (context) => CommunityPage(),
                                builder: (context) => CommunityPage(),
                              ));
                        },
                        // bgColor: kPrimaryColor,
                        bgColor: Color.fromARGB(255, 65, 79, 240),
                        // textcolor: Colors.white,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OnBoardNavBtn(
                            name: 'Skip',
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    // builder: (context) => CommunityPage(),
                                    builder: (context) => CommunityPage(),
                                  ));
                            },
                          ),
                          Row(
                            children: List.generate(
                              onboardingContents.length,
                              (index) => dotIndicator(index),
                            ),
                          ),
                          OnBoardNavBtn(
                            name: 'Next',
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );
                            },
                          )
                        ],
                      ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
