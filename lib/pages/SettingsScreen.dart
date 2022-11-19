import 'package:bhaktchintamani/pages/FavoriteScreen.dart';
import 'package:bhaktchintamani/pages/HomeScreen.dart';
import 'package:bhaktchintamani/pages/NaviDrawer.dart';
import 'package:bhaktchintamani/utils/Colors.dart';
import 'package:bhaktchintamani/utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SharedPreferences? shredPreferences;
  int? defaultColor;
  bool notiSwitch = false;
  int currentIndex = 3;
  bool isEnglish = false;
  int? checkedPosition;
  bool isSelected = false;
  bool? shredLoading;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
    return WillPopScope(
      onWillPop: onBackPressed,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          onEndDrawerChanged: (isOpened) {
            if (isOpened) {
              return;
            } else {
              setState(() {
                currentIndex = 3;
              });
            }
          },
          endDrawer: NaviDrawer(),
          appBar: AppBar(
            backgroundColor: const Color(0xffFAFAFA),
            elevation: 0,
            toolbarHeight: 55,
            automaticallyImplyLeading: false,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(50),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "Settings",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Gujarati-Bold",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                        );
                      } else if (index == 3) {
                      } else if (index == 4) {
                        return _scaffoldKey.currentState?.openEndDrawer();
                      }
                    });
                  },
                  items: [
                    Constants.bottomBar("Language",
                        "assets/images/language.svg", defaultColor!),
                    Constants.bottomBar("Favorites",
                        "assets/images/favorites.svg", defaultColor!),
                    Constants.bottomBar(
                        "Home", "assets/images/home.svg", defaultColor!),
                    Constants.bottomBar("Settings",
                        "assets/images/settings.svg", defaultColor!),
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
      ),
    );
  }

  mainLayout() {
    return SingleChildScrollView(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 150, left: 10, right: 10, bottom: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/images/about_us_icon.svg",
                              color: DefaultColor.dc(defaultColor!),
                              height: 24,
                              width: 24,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                "Daily Limit",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Gujarati-Bold",
                                ),
                              ),
                            )
                          ],
                        ),
                        Material(
                          color: Color(0xffE4E4E4),
                          borderRadius: BorderRadius.circular(20),
                          child: InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(20),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 3, bottom: 2, left: 15, right: 7),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Text(
                                      "10",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Icon(Icons.arrow_drop_down),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 1,
                    color: Color(0xffE6E9F0),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/font_size.svg",
                          color: DefaultColor.dc(defaultColor!),
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Text(
                            "Change Font Size",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Gujarati-Bold",
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 1,
                    color: Color(0xffE6E9F0),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/images/app_theme.svg",
                              color: DefaultColor.dc(defaultColor!),
                              height: 24,
                              width: 24,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                "App Theme",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Gujarati-Bold",
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 3.5),
                              child: SvgPicture.asset(
                                "assets/images/tick_mark.svg",
                                color: DefaultColor.dc(defaultColor!),
                                height: 15,
                                width: 15,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                "Default",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          if (checkedPosition == index) {
                            isSelected = true;
                          } else {
                            isSelected = false;
                          }
                          return Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Material(
                              color: DefaultColor.dc(index + 1),
                              borderRadius: BorderRadius.circular(50),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    checkedPosition = index;
                                    defaultColor = index + 1;
                                    shredPreferences!.setInt(
                                        Constants.defaultColor, defaultColor!);
                                  });
                                },
                                borderRadius: BorderRadius.circular(50),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14),
                                  child: isSelected == true
                                      ? SvgPicture.asset(
                                          "assets/images/tick_mark.svg",
                                          color: Colors.white,
                                          height: 17,
                                          width: 17,
                                        )
                                      : Container(
                                          width: 17,
                                        ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 1,
                    color: Color(0xffE6E9F0),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/images/notification.svg",
                              color: DefaultColor.dc(defaultColor!),
                              height: 24,
                              width: 24,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                "Notification",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Gujarati-Bold",
                                ),
                              ),
                            )
                          ],
                        ),
                        Material(
                          color: notiSwitch == true
                              ? DefaultColor.dc(defaultColor!)
                              : Color(0xffE4E4E4),
                          borderRadius: BorderRadius.circular(20),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                notiSwitch = !notiSwitch;
                              });
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: 70,
                              height: 35,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: notiSwitch == true
                                  ? Row(
                                      children: [
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 1),
                                          child: Text(
                                            "On",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Container(
                                          height: 27,
                                          width: 27,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                          height: 27,
                                          width: 27,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 2),
                                          child: Text(
                                            "Off",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            child: Container(
              height: 230,
              width: 230,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/settings_maharaj.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  languageDialog() {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
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
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 4),
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
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 4),
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
          );
        }).then((value) {
      setState(() {
        currentIndex = 3;
      });
    });
  }

  getShredPreferences() async {
    shredPreferences = await SharedPreferences.getInstance();
    setState(() {
      defaultColor = shredPreferences!.getInt(Constants.defaultColor);
      shredLoading = false;
      checkedPosition = defaultColor! - 1;
    });
  }

  Future<bool> onBackPressed() async {
    return (await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        )) ??
        false;
  }
}
