import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../model/onboard.dart';
import '../widget/custom_btn.dart';
import 'home.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PageController();

    final list = [
      //onboarding 1
      Onboard(
          title: 'Ask me Anything',
          subtitle:
          'I can be your Best Friend & You can ask me anything & I will help you!',
          lottie: '1'),

      //onboarding 2
      Onboard(
        title: 'Imagination to Reality',
        lottie: '2',
        subtitle:
        'Just Imagine anything & let me know, I will create something wonderful for you!',
      ),

      //onboarding 3
      Onboard(
        title: 'Chat with Education Assistant',
        lottie: '3',
        subtitle:
        'Chat with me an Educational Chat bot Assistant, I will love to be of help to you.',
      ),

    ];

    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          controller: c,
          itemCount: list.length,
          itemBuilder: (ctx, ind) {
            final isLast = ind == list.length - 1;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //lottie
                  Lottie.asset('assets/boarding/${list[ind].lottie}.json',
                      height: 200,
                      width: 200),
                  const SizedBox(height: 30),
                  Text(
                    list[ind].title,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: .5),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: Text(
                      list[ind].subtitle,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      style: const TextStyle(
                          fontSize: 13.5,
                          letterSpacing: .5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  //dots
                  Wrap(
                    spacing: 10,
                    children: List.generate(
                        list.length,
                            (i) => Container(
                          width: i == ind ? 15 : 10,
                          height: 8,
                          decoration: BoxDecoration(
                              color: i == ind ? Colors.blue : Colors.grey,
                              borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                        )),
                  ),
                  const SizedBox(height: 50,),
                  //button
                  CustomBtn(
                      onTap: () {
                        if (isLast) {
                          Get.off(() => const Home());
                        } else {
                          c.nextPage(
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.ease);
                        }
                      },
                      text: isLast ? 'Finish' : 'Next'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
