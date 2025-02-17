import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:rider/pages/map_view_page.dart';
import 'package:rider/services/firebase_analytics.dart';
import 'package:rider/utils/colors.dart';
import 'package:rider/utils/text_styles.dart';
import 'package:rider/utils/ui_helpers.dart';
import 'package:rider/widgets/sexy_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyOnboardingPage extends StatefulWidget {
  final SharedPreferences helper;
  final bool flag;
  final String identity;
  MyOnboardingPage(
      {Key key,
      @required this.helper,
      @required this.flag,
      @required this.identity})
      : super(key: key);
  @override
  _MyOnboardingPageState createState() => _MyOnboardingPageState();
}

class _MyOnboardingPageState extends State<MyOnboardingPage> {
  Color dynamicColor = MyColors.black;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.8;
    final pages = [
      Container(
        color: MyColors.primary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 170.0,
                  height: 54.0,
                  child: Image.asset(
                    'assets/logo/text-black.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Container(
                  width: 150.0,
                  height: 150.0,
                  child: Image.asset(
                    'assets/other/rickshaw.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Text(
                  'Welcome to Fliver!',
                  style: HeadingStyles.black,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Swipe left to get started.',
                  style: SubHeadingStyles.black,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        color: MyColors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 60.0,
                  ),
                  Container(
                    width: 295.0,
                    height: 140.0,
                    child: Image.asset(
                      'assets/other/howto.gif',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 36.0,
                            height: 36.0,
                            child: Image.asset(
                              'assets/other/swipe_button.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Looking for a Rickshaw?',
                              style: SubHeadingStyles.black,
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'Swipe the button to let Drivers know about your location.',
                              style: BodyStyles.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 32.0,
                            height: 38.0,
                            child: Image.asset(
                              'assets/other/notification.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'How do Drivers know?',
                              style: SubHeadingStyles.black,
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'When many Riders in an area mark their location, a hotspot is created for Drivers to see.',
                              style: BodyStyles.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 32.0,
                            height: 38.0,
                            child: Image.asset(
                              'assets/other/rickshaw-mini.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'What\'s next?',
                              style: SubHeadingStyles.black,
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'Drivers will see the high demand and come to pick you up!',
                              style: BodyStyles.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  RaisedButton(
                    child: Text('FAQ'),
                    color: MyColors.black,
                    textColor: MyColors.white,
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    onPressed: () async {
                      launchUrl('https://fliverdev.github.io/faq/');
                      logAnalyticsEvent('url_click_faq');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Container(
        color: MyColors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 60.0,
                  ),
                  Container(
                    width: 300.0,
                    height: 140.0,
                    child: FlareActor(
                      'assets/flare/messages-light.flr',
                      animation: 'animation',
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 36.0,
                            height: 36.0,
                            child: Image.asset(
                              'assets/other/messages.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Chatroom',
                              style: SubHeadingStyles.black,
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'You can use the new chat feature to talk to other Fliver users.',
                              style: BodyStyles.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 36.0,
                            height: 38.0,
                            child: Image.asset(
                              'assets/other/people.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Hotspot Chat',
                              style: SubHeadingStyles.black,
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'Privately talk to Riders within your hotspot to discuss carpooling with them.',
                              style: BodyStyles.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 38.0,
                            height: 36.0,
                            child: Image.asset(
                              'assets/other/rickshaws.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Global Chat',
                              style: SubHeadingStyles.black,
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'Talk to all Fliver Riders and Drivers!',
                              style: BodyStyles.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  RaisedButton(
                    child: Text('FAQ'),
                    color: MyColors.black,
                    textColor: MyColors.white,
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    onPressed: () async {
                      launchUrl('https://fliverdev.github.io/faq/');
                      logAnalyticsEvent('url_click_faq');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Container(
        color: dynamicColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 60.0,
                  ),
                  Text(
                    'Select a Theme',
                    style: isColorCurrentlyDark(dynamicColor)
                        ? HeadingStyles.white
                        : HeadingStyles.black,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SexyTile(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(
                            'assets/other/light.png',
                            fit: BoxFit.cover,
                            width: 250.0,
                            height: 180.0,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            dynamicColor = MyColors.white;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      SexyTile(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(
                            'assets/other/dark.png',
                            fit: BoxFit.cover,
                            width: 250.0,
                            height: 180.0,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            dynamicColor = MyColors.black;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  ButtonTheme(
                    height: 50.0,
                    minWidth: 180.0,
                    child: RaisedButton(
                      child: Text(
                        'Let\'s Go!',
                        style: isColorCurrentlyDark(dynamicColor)
                            ? BodyStyles.black
                            : BodyStyles.white,
                      ),
                      color: isColorCurrentlyDark(dynamicColor)
                          ? MyColors.primary
                          : MyColors.black,
                      splashColor: isColorCurrentlyDark(dynamicColor)
                          ? MyColors.black
                          : MyColors.primary,
                      elevation: 3.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      onPressed: () async {
                        widget.helper.setBool('isFirstLaunchChat', false);
                        widget.helper.setString('uuid', widget.identity);

                        DynamicTheme.of(context).setBrightness(
                            isColorCurrentlyDark(dynamicColor)
                                ? Brightness.dark
                                : Brightness.light);

                        isThemeCurrentlyDark(context)
                            ? logAnalyticsEvent('dark_mode')
                            : logAnalyticsEvent('light_mode');

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyMapViewPage(
                                    helper: widget.helper,
                                    identity: widget.identity)),
                            (Route<dynamic> route) => false);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ];

    return LiquidSwipe(
      pages: pages,
      fullTransitionValue: 350.0,
      enableLoop: false,
      enableSlideIcon: true,
      slideIconWidget: Icon(
        Icons.arrow_back_ios,
        color: dynamicColor,
      ),
    );
  }
}
