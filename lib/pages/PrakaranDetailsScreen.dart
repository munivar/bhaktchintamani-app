import 'package:bhaktchintamani/pages/FavoriteScreen.dart';
import 'package:bhaktchintamani/pages/HomeScreen.dart';
import 'package:bhaktchintamani/pages/NavigationDrawer.dart';
import 'package:bhaktchintamani/pages/SettingsScreen.dart';
import 'package:bhaktchintamani/utils/Colors.dart';
import 'package:bhaktchintamani/utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class PrakaranDetailsScreen extends StatefulWidget {
  PrakaranDetailsScreen({super.key});

  @override
  State<PrakaranDetailsScreen> createState() => _PrakaranDetailsScreenState();
}

class _PrakaranDetailsScreenState extends State<PrakaranDetailsScreen> {
  SharedPreferences? shredPreferences;
  int? defaultColor;
  int currentIndex = 2;
  bool isEnglish = false;
  bool? isLoading;
  bool? shredLoading;
  bool enabled = true;

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
    return WillPopScope(
      onWillPop: onBackPressed,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
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
                      "Vedras (વેદરસ)",
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
    if (isLoading == false) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * (0.27),
              decoration: BoxDecoration(
                color: DefaultColor.dc(defaultColor!).withOpacity(0.04),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1.5,
                  color: Color(0xffE6E9F0),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Author Name : ",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Gujarati-Bold",
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "Bhagwan Swaminarayan",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: Text(
                "ભક્તચિંતામણી ગ્રંથનો મહિમા નામ પ્રમાણે જ ગુણ ધરાવતો ગ્રંથ એટલે ભક્તચિંતામણી . ભગવાનના ભક્તોને ચિંતવા લાયક જો કોઈ હોય તો એ ભગવાનનાં ચત્રિ છે . આ ગ્રંથની અંદર સદગુરુ શ્રી નિષ્કુળાનંદ સ્વામીએ ભગવાન શ્રી સ્વામિનારાયણના જન્મથી લઇ અને ભગવાનની તિરોધાન લીલા સુધીના ચત્રિનું ભાવવાહી શૈલીમાં કાવ્યાત્મક વર્ણન કરેલું છે . સંપ્રદાયમાં ખૂબ ઓછા એવા ગ્રંથો છે કે જેને ભગવાન શ્રી સ્વામિનારાયણે સ્વંયમે વાંચન કર્યું છે . સત્સંગિજીવન , ભક્તચિંતામણી આ બન્ને ગ્રંથો એવા છે કે જેને ભગવાન સ્વામિનારાયણ એકેક અક્ષર વાંચી અને આ ગ્રંથને પ્રમાણિત કર્યો છે . ગઢપુરમાં લક્ષ્મીબાગમાં એક નાની ઓરડીમાં સ.ગુ.નિષ્કુળાનંદ સ્વામી આ ગ્રંથની રચના કરતા જાય અને મેડી ( મકાન ઉપરનો માળ ) પર બેઠેલા ભગવાન શ્રી સ્વામિનારાયણને પ્રકરણ આપતાં અને ભગવાન સ્વામિનારાયણ એક એક પ્રકરણ તેને વાંચીને પ્રસાદીભૂત કરી આપતા . આ ગ્રંથના વાંચનથી આ ગ્રંથની કથા સાંભળવાથી આધિ વ્યાધિ અને ઉપાધિ ત્રણેય તાપ નાશ પામે છે અને ભગવાનની મૂર્તિમાં રસ તરબોળ થવાય એવો સુંદર મજાનો ગ્રંથ એટલે ભક્તચિંતામણી . આ ગ્રંથમાં કુલ ૧૬૪ પ્રકરણ છે તથા દોહા અને ચોપાઇ મળીને કુલ 8727 છે . જેમાં શ્રી હરિના ચરિત્રો , મહિમા , સર્વોપરીપણું , પંચવર્તમાનની વાત , સત્સંગી હરિભક્તોની નામાવલી , 6 પ્રકારના ધામનું વર્ણન , અને શ્રી હરિએ આપેલા દિવ્ય પરચાઓનું પરચાપ્રકરણ અને ગ્રંથ મહિમા વગેરે વિષયોનો સમાવેશ થાય છે .",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(0.40),
        highlightColor: Colors.grey.withOpacity(0.10),
        enabled: enabled,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * (0.27),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 15,
              margin: EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 15,
              margin: EdgeInsets.only(left: 25, right: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 15,
              margin: EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 15,
              margin: EdgeInsets.only(left: 25, right: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 15,
              margin: EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      );
    }
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
