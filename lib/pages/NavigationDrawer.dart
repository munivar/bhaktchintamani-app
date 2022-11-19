import 'package:bhaktchintamani/pages/HomeScreen.dart';
import 'package:bhaktchintamani/pages/SettingsScreen.dart';
import 'package:bhaktchintamani/utils/Colors.dart';
import 'package:bhaktchintamani/utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationDrawer extends StatefulWidget {
  NavigationDrawer({super.key});

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  SharedPreferences? shredPreferences;
  int? defaultColor;
  bool? shredLoading;

  List<String> drawerItemNameList = [
    "Home",
    "About Us",
    "Donation",
    "Rate Application",
    "Favorites",
    "Share Application",
    "More Application",
    "Settings",
    "Contact Us"
  ];

  List<String> drawerItemLogoList = [
    "assets/images/home_icon.svg",
    "assets/images/about_us_icon.svg",
    "assets/images/donation_icon.svg",
    "assets/images/rate_icon.svg",
    "assets/images/favorite_option.svg",
    "assets/images/share_option.svg",
    "assets/images/more_icon.svg",
    "assets/images/settings_icon.svg",
    "assets/images/contact_us_icon.svg"
  ];

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
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "ભક્તચિંતામણિ",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              fontFamily: "Gujarati-Bold",
              color: DefaultColor.dc(defaultColor!),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: drawerItemNameList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    if (drawerItemNameList[index] == "Home") {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    }
                    if (drawerItemNameList[index] == "Favorites") {}
                    if (drawerItemNameList[index] == "Settings") {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingsScreen(),
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 25, top: 8, bottom: 8, right: 10),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          drawerItemLogoList[index],
                          height: 22,
                          width: 22,
                          color: DefaultColor.dc(defaultColor!),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 1, left: 15),
                          child: Text(
                            drawerItemNameList[index],
                            style: TextStyle(
                              color: DefaultColor.dc(defaultColor!),
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(
                height: 5,
                color: Colors.transparent,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              "assets/images/menu_maharaj.png",
              height: MediaQuery.of(context).size.height * (0.25),
              width: MediaQuery.of(context).size.width * (0.60),
              alignment: Alignment.bottomRight,
            ),
          ),
        ],
      ),
    );
  }

  getShredPreferences() async {
    shredPreferences = await SharedPreferences.getInstance();
    setState(() {
      defaultColor = shredPreferences!.getInt(Constants.defaultColor);
      shredLoading = false;
    });
  }
}
