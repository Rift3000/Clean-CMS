import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:clean_cms/Views/addArticle.dart';
import 'package:clean_cms/Views/addYoutube.dart';
import 'package:flutter/material.dart';

class Switcheroo extends StatefulWidget {
  @override
  _SwitcherooState createState() => _SwitcherooState();
}

class _SwitcherooState extends State<Switcheroo> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color secondaryColor = Color(0xff232c51);
    Color primaryColor = Color(0xff18203d);
    Color thirdColor = Color(0xff58439A);
    Color logoGreen = Color(0xff2AB96B);

    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            AddYoutubeScreen(),
            AddArticleScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        backgroundColor: secondaryColor,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text('Youtube'),
              icon: Icon(Icons.tv_sharp),
              textAlign: TextAlign.center),
          BottomNavyBarItem(
              title: Text('Articles'),
              icon: Icon(Icons.article_sharp),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}




/*
import 'package:clean_cms/Views/addArticle.dart';
import 'package:clean_cms/Views/addYoutube.dart';
import 'package:clean_cms/popUp/dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class Switcher extends StatelessWidget {
  const Switcher({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color secondaryColor = Color(0xff232c51);
    Color primaryColor = Color(0xff18203d);
    Color thirdColor = Color(0xff58439A);
    Color logoGreen = Color(0xff2AB96B);

    List<Widget> _buildScreens() {
      return [
        AddYoutubeScreen(),
        AddArticleScreen(),
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.home),
          title: ("Youtube"),
          activeColorPrimary: Colors.lightBlueAccent,
          inactiveColorPrimary: Colors.lightBlue,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.article_sharp),
          title: ("Articles"),
          activeColorPrimary: Colors.lightBlueAccent,
          inactiveColorPrimary: Colors.lightBlue,
        ),
      ];
    }

    return PersistentTabView(
      context,
      controller: PersistentTabController(),
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: secondaryColor, // Default is Colors.white.
      handleAndroidBackButtonPress: false, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.

      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}

*/