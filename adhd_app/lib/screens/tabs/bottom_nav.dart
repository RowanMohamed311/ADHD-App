import 'package:adhd_app/screens/tabs/feed/home.dart';
import 'package:adhd_app/screens/tabs/Notifications.dart';
import 'package:adhd_app/screens/tabs/add_post.dart';
import 'package:adhd_app/screens/tabs/search.dart';
import 'package:adhd_app/screens/tabs/profileposts.dart';
import 'package:adhd_app/widgets/drawer.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentTab = 0;
  int? _pass;
  final List<Color> colors = [
    Color.fromARGB(255, 118, 130, 160),
    Color.fromARGB(255, 65, 79, 240),
  ];
  final List<Widget> screens = [
    Home(),
    Notifications(),
    searchPosts(),
    ProfilePosts()
  ];
  final PageStorageBucket _bucket = PageStorageBucket();
  Widget currentScreen = Home();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: PageStorage(
        bucket: _bucket,
        child: currentScreen,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).buttonColor,
        heroTag: 'expand_save',
        elevation: 12,
        highlightElevation: 50,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddPost(),
            ),
          );
          // refreshNotes();
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 50,
                    onPressed: () {
                      setState(() {
                        currentScreen = Home();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.feed,
                          color: currentTab == 0 ? colors[1] : colors[0],
                        ),
                        Text(
                          'Feed',
                          style: TextStyle(
                            color: currentTab == 0 ? colors[1] : colors[0],
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 50,
                    onPressed: () {
                      setState(() {
                        currentScreen = Notifications();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications_active,
                          color: currentTab == 1 ? colors[1] : colors[0],
                        ),
                        Text(
                          'Notifications',
                          style: TextStyle(
                            color: currentTab == 1 ? colors[1] : colors[0],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 50,
                    onPressed: () {
                      setState(() {
                        currentScreen = searchPosts();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          color: currentTab == 2 ? colors[1] : colors[0],
                        ),
                        Text(
                          'Search',
                          style: TextStyle(
                            color: currentTab == 2 ? colors[1] : colors[0],
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 50,
                    onPressed: () {
                      setState(() {
                        currentScreen = ProfilePosts();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.supervised_user_circle,
                          color: currentTab == 3 ? colors[1] : colors[0],
                        ),
                        Text(
                          'Posts',
                          style: TextStyle(
                            color: currentTab == 3 ? colors[1] : colors[0],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
