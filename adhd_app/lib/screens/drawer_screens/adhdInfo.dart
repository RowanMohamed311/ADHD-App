import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ADHD extends StatelessWidget {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ADHD information'),
          backgroundColor: Theme.of(context).buttonColor,
          leading: IconButton(
            icon:const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('wrapper');
            },
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color:const Color.fromARGB(255, 255, 255, 228),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(children: [
              const Padding(padding: EdgeInsets.all(20)),
              const Center(
                child: Image(
                  image: AssetImage('assets/images/adhd.png'),
                ),
              ),
              const Padding(padding: EdgeInsets.all(20)),
              ExpansionTile(
                title: Text(
                  ' What is ADHD ?',
                  style: GoogleFonts.aBeeZee(
                    color:const Color.fromARGB(255, 65, 79, 240),
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                children:const <Widget>[
                  ListTile(
                    title: Text(
                        '''Attention-deficit/hyperactivity disorder (ADHD) is one of the most common mental disorders affecting children. It is usually first diagnosed in childhood and often lasts into adulthood.\nChildren with ADHD may have trouble paying attention, controlling impulsive behaviors, or be overly active.\nADHD is considered a chronic and debilitating disorder and is known to impact the individual in many aspects of their life including academic and professional achievements, interpersonal relationships, and daily functioning (Harpin, 2005).'''),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(
                  ' How is ADHD diagnosed ?',
                  style: GoogleFonts.aBeeZee(
                    color:const Color.fromARGB(255, 65, 79, 240),
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                children:const <Widget>[
                  ListTile(
                    title: Text(
                        '''If you are concerned about whether a child might have ADHD, the first step is to talk with a healthcare provider to find out if the symptoms fit the diagnosis.\nThe diagnosis can be made by a mental health professional, like a psychologist or psychiatrist, or by a primary care provider, like a pediatrician.\nThe American Academy of Pediatrics (AAP) recommends that healthcare providers ask parents, teachers, and other adults who care for the child about the child’s behavior in different settings, like at home, school, or with peers.\nThe healthcare provider should also determine whether the child has another condition that can either explain the symptoms better, or that occurs at the same time as ADHD.'''),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(
                  ' Signs and Symptoms',
                  style: GoogleFonts.aBeeZee(
                    color: const Color.fromARGB(255, 65, 79, 240),
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                children: const <Widget>[
                  ListTile(
                    title: Text(
                        '''It is normal for children to have trouble focusing and behaving at one time or another. However, children with ADHD do not just grow out of these behaviors.The symptoms continue, can be severe, and can cause difficulty at school, at home,or with friends\nA child with ADHD might:\n   - daydream a lot\n   - forget or lose things a lot\n  - talk too much\n  - make careless mistakes or take unnecessary risks\n  - have trouble taking turns\n  - have difficulty getting along with others
        '''),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(
                  ' Causes of ADHD',
                  style: GoogleFonts.aBeeZee(
                    color: const Color.fromARGB(255, 65, 79, 240),
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                children: const <Widget>[
                  ListTile(
                    title: Text(
                        '''Scientists are studying cause(s) and risk factors in an effort to find better ways to manage and reduce the chances of a person having ADHD. The cause(s) and risk factors for ADHD are unknown, but current research shows that genetics plays an important role. Recent studies link genetic factors with ADHD.\nIn addition to genetics, scientists are studying other possible causes and risk factors including:\n   -Brain injury\n   -Exposure to environmental risks during pregnancy or at a young age\n   -Alcohol and tobacco use during pregnancy\n   -Premature delivery\n   -Low birth weight'''),
                  ),
                ],
              ),
            ]),
          ),
        ));
  }
}
