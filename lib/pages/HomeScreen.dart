import 'dart:ui';

import 'package:bhaktchintamani/pages/FavoriteScreen.dart';
import 'package:bhaktchintamani/pages/NavigationDrawer.dart';
import 'package:bhaktchintamani/pages/PrakaranDetailsScreen.dart';
import 'package:bhaktchintamani/pages/SettingsScreen.dart';
import 'package:bhaktchintamani/utils/Colors.dart';
import 'package:bhaktchintamani/utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences? shredPreferences;
  bool isEnglish = false;
  int? defaultColor;
  bool enabled = true;
  bool? isLoading;
  bool? shredLoading;
  int currentIndex = 2;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      shredLoading = true;
      getShredPreferences();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (shredLoading == true) {
      return Container();
    } else {
      return layoutMain();
    }
  }

  layoutMain() {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        onEndDrawerChanged: (isOpened) {
          if (isOpened) {
            return;
          } else {
            setState(() {
              currentIndex = 2;
            });
          }
        },
        endDrawer: NavigationDrawer(),
        floatingActionButton: Container(
          height: 60,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SalomonBottomBar(
                currentIndex: currentIndex,
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                    if (index == 0) {
                      languageDialog();
                    } else if (index == 1) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FavoriteScreen(),
                        ),
                      );
                    } else if (index == 2) {
                    } else if (index == 3) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingsScreen(),
                        ),
                      );
                    } else if (index == 4) {
                      return _scaffoldKey.currentState?.openEndDrawer();
                    }
                  });
                },
                items: [
                  Constants.bottomBar(
                      "Language", "assets/images/language.svg", defaultColor!),
                  Constants.bottomBar("Favorites",
                      "assets/images/favorites.svg", defaultColor!),
                  Constants.bottomBar(
                      "Home", "assets/images/home.svg", defaultColor!),
                  Constants.bottomBar(
                      "Settings", "assets/images/settings.svg", defaultColor!),
                  Constants.bottomBar(
                      "Menu", "assets/images/menu.svg", defaultColor!),
                ],
              ),
            ],
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        body: mainLayout(),
      ),
    );
  }

  mainLayout() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 5, bottom: 10),
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(left: 12, top: 8),
                  child: Text(
                    "ભક્તચિંતામણિ",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                      color: DefaultColor.dc(defaultColor!),
                      fontWeight: FontWeight.w600,
                      fontFamily: "Gujarati-Bold",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, right: 10),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(50),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        "assets/images/search.svg",
                        height: 18,
                        width: 18,
                        color: DefaultColor.dc(defaultColor!),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 10),
          decoration: BoxDecoration(
            color: DefaultColor.dc(defaultColor!),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 45,
                    width: 50,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 20,
                        child: Text(
                          "LAST PLAYED",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Gujarati-Bold",
                          ),
                        ),
                      ),
                      Text(
                        "Prakaran : 10",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: SvgPicture.asset(
                    "assets/images/music.svg",
                    height: 20,
                    width: 20,
                    color: DefaultColor.dc(defaultColor!),
                  ),
                ),
              ),
            ],
          ),
        ),
        isLoading == false
            ? Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PrakaranDetailsScreen(),
                              ),
                            );
                          },
                          splashColor:
                              DefaultColor.dc(defaultColor!).withOpacity(0.04),
                          highlightColor:
                              DefaultColor.dc(defaultColor!).withOpacity(0.04),
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Color(0xffB4B4B4),
                                  width: 1,
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: DefaultColor.dc(defaultColor!)
                                            .withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 45,
                                      width: 50,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 20,
                                          child: Text(
                                            "Prakaran : 10",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 22,
                                          child: Text(
                                            "Vedras (વેદરસ)",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontFamily: "Gujarati",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        threeDotDialog();
                                      },
                                      borderRadius: BorderRadius.circular(5),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 3,
                                            right: 3,
                                            top: 10,
                                            bottom: 10),
                                        child: SvgPicture.asset(
                                          "assets/images/three_dot.svg",
                                          height: 17,
                                          width: 17,
                                          color: Color(0xffB4B4B4),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              )
            : Expanded(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.withOpacity(0.40),
                  highlightColor: Colors.grey.withOpacity(0.10),
                  enabled: enabled,
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 12),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              width: 50,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width *
                                      (0.40),
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                Container(
                                  width: 100,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                Container(
                                  width: 40.0,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
      ],
    );
  }

  threeDotDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3),
                      child: Material(
                        color: DefaultColor.dc(defaultColor!),
                        borderRadius: BorderRadius.circular(30),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Material(
                            color: DefaultColor.dc(defaultColor!),
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: SvgPicture.asset(
                                  "assets/images/download_option.svg",
                                  color: Colors.white,
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            "Download",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Gujarati",
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Material(
                            color: DefaultColor.dc(defaultColor!),
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: SvgPicture.asset(
                                  "assets/images/favorite_option.svg",
                                  color: Colors.white,
                                  height: 28,
                                  width: 28,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            "Favorite",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Gujarati",
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Material(
                            color: DefaultColor.dc(defaultColor!),
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: SvgPicture.asset(
                                  "assets/images/share_option.svg",
                                  color: Colors.white,
                                  height: 28,
                                  width: 28,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            "Share",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Gujarati",
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  languageDialog() {
    return showDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.white.withAlpha(10),
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3),
                          child: Material(
                            color: DefaultColor.dc(defaultColor!),
                            borderRadius: BorderRadius.circular(30),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              borderRadius: BorderRadius.circular(30),
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/images/language.svg",
                            color: DefaultColor.dc(defaultColor!),
                            height: 24,
                            width: 24,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Language",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Gujarati-Bold",
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: DefaultColor.dc(defaultColor!),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Material(
                              color: isEnglish == true
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isEnglish = true;
                                  });
                                  Navigator.pop(context);
                                },
                                borderRadius: BorderRadius.circular(20),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 4),
                                    child: Text(
                                      "English",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: isEnglish == true
                                            ? DefaultColor.dc(defaultColor!)
                                            : Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Gujarati-Bold",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Material(
                              color: isEnglish == false
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isEnglish = false;
                                  });
                                  Navigator.pop(context);
                                },
                                borderRadius: BorderRadius.circular(20),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 4),
                                    child: Text(
                                      "ગુજરાતી",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: isEnglish == false
                                            ? DefaultColor.dc(defaultColor!)
                                            : Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Gujarati-Bold",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).then((value) {
      setState(() {
        currentIndex = 2;
      });
    });
  }

  getShredPreferences() async {
    shredPreferences = await SharedPreferences.getInstance();
    setState(() {
      defaultColor = shredPreferences!.getInt(Constants.defaultColor);
      shredLoading = false;
      isLoading = true;
    });
    await Future.delayed(Duration(milliseconds: 1000), () {});
    setState(() {
      isLoading = false;
    });
  }
}
