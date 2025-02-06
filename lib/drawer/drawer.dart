import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:to_do_list/home_screen.dart';
import 'package:to_do_list/tabs/calendar.dart';
import 'package:to_do_list/tabs/themes.dart';

import '../ads/ad_unit.dart';
import '../colors.dart';
import '../tabs/today_tab.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  BannerAd? bannerAd;
  bool isBannerLoaded = false;
  bool _isIntersLoaded = false;
  InterstitialAd? _interstitialAd;

  void loadBannerAd() {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: AdsUtils.banenr1,
        listener: BannerAdListener(onAdLoaded: (ad) {
          isBannerLoaded = true;
        }, onAdFailedToLoad: (Ad, LoadAdError) {
          Ad.dispose();
          print("error loading the app >>> $LoadAdError");
        }),
        request: AdRequest())
      ..load();
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdsUtils.interstitialAdUnitId, // Use testAdUnitId for testing
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {});
          _interstitialAd = ad;
          _isIntersLoaded = true; // Update this when the ad is loaded
        },
        onAdFailedToLoad: (error) {
          _isIntersLoaded = false; // Update this on failure
          print(
              'InterstitialAd failed to load: $error'); // Log error for debugging
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_isIntersLoaded && _interstitialAd != null) {
      _interstitialAd!.show();
      _isIntersLoaded = false; // Set to false after showing
      _loadInterstitialAd(); // Load a new ad after showing
    }
  }

  @override
  void initState() {
    super.initState();
    loadBannerAd();
    _loadInterstitialAd();
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    if (isBannerLoaded) {
      bannerAd!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.tertiary,
            Theme.of(context).colorScheme.onTertiary,
            Theme.of(context).colorScheme.onTertiaryFixed
          ], // Specify your gradient colors here
          begin: Alignment.topCenter, // Gradient start point
          end: Alignment.bottomCenter, // Gradient end point
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, TodayTab.routName);
              _showInterstitialAd();
            },
            child: Row(
              children: [
                Icon(
                  Icons.sunny,
                  color: Colors.yellow,
                ),
                Text(
                  " Today Tasks",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, HomeScreen.routName);
                _showInterstitialAd();
              },
              child: Row(
                children: [
                  Icon(
                    Icons.home,
                    color: Colors.green,
                  ),
                  Text(" All Tasks",
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              )),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, Calendar.routName);
                _showInterstitialAd();
              },
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: Colors.blueAccent,
                  ),
                  Text(" Calendar",
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              )),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, ThemesTab.routeName);
                _showInterstitialAd();
              },
              child: Row(
                children: [
                  Icon(
                    Icons.color_lens_outlined,
                    color: Colors.pink,
                  ),
                  Text(" Themes", style: Theme.of(context).textTheme.bodyLarge),
                ],
              )),
          Spacer(),
          isBannerLoaded
              ? SizedBox(
                  width: bannerAd!.size.width.toDouble(),
                  height: bannerAd!.size.height.toDouble(),
                  child: AdWidget(ad: bannerAd!),
                )
              : Container()
        ],
      ),
    );
  }
}
