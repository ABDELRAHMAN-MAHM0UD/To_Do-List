import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:to_do_list/ads/ad_unit.dart';
import 'package:to_do_list/colors.dart';
import '../drawer/drawer.dart';
import '../my_theme.dart';
import '../widgets/theme_container.dart';

///widget.onThemeChanged(MyTheme.themes[themeIndex!]);

class ThemesTab extends StatefulWidget {
  static const String routeName = "themes";
  final Function(ThemeData) onThemeChanged;

  ThemesTab({required this.onThemeChanged});

  @override
  _ThemesTabState createState() => _ThemesTabState();
}

class _ThemesTabState extends State<ThemesTab> {
  RewardedAd? _rewardedAd;
  int? themeIndex;

  bool isAdLoaded = false; // Flag to track if the ad is loaded

// Load a new rewarded ad
  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdsUtils.rewardedAdUnit,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          print('Rewarded Ad loaded.');
          _rewardedAd = ad;
          isAdLoaded = true; // Set flag to true when ad is loaded
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('Rewarded Ad failed to load: $error');
          isAdLoaded = false; // Set flag to false on failure
        },
      ),
    );
  }

// Show the rewarded ad
  void showRewardedAd(BuildContext context) {
    if (isAdLoaded) {
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (RewardedAd ad) {
          print('Rewarded Ad showed.');
        },
        onAdDismissedFullScreenContent: (RewardedAd ad) {
          print('Rewarded Ad dismissed.');
          ad.dispose();
          loadRewardedAd(); // Load a new ad for next time
        },
        onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
          print('Rewarded Ad failed to show: $error');
          ad.dispose();
          loadRewardedAd(); // Load a new ad for next time
        },
      );
      _rewardedAd!.show(
        onUserEarnedReward: (ad, reward) {
          widget.onThemeChanged(MyTheme.themes[themeIndex!]);
        },
      );
      isAdLoaded = false; // Reset the flag after showing the ad
    } else {
      print('Rewarded Ad is not ready yet.');
    }
  }

// Dispose the ad when no longer needed
  void dispose() {
    _rewardedAd?.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    loadRewardedAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          // Use Builder to get the correct context for Scaffold
          builder: (context) => IconButton(
            onPressed: () {
              // Open the endDrawer (right-side drawer)
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(Icons.list,
                color: Theme.of(context).iconTheme.color, size: 45),
          ),
        ),
        title:
            Text("Themes", style: Theme.of(context).textTheme.headlineMedium),
        toolbarHeight: 110,
      ),
      drawer: Drawer(
        //width: MediaQuery.of(context).size.width*0.55,
        child: MyDrawer(),
      ),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.08,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ThemeContainer(
                  scafoldColor: AppColors.black,
                  secondColor: AppColors.sky,
                  onTap: () {
                    themeIndex = 0;
                    widget.onThemeChanged(MyTheme.themes[themeIndex!]);

/*
                    showRewardedAd(context);
*/                  }),
              ThemeContainer(
                  scafoldColor: AppColors.T1pink2,
                  secondColor: AppColors.T1lightPurble,
                  onTap: () {
                    themeIndex = 1;
                    widget.onThemeChanged(MyTheme.themes[themeIndex!]);

/*
                    showRewardedAd(context);
*/
                  }),
            ],
          ),
          SizedBox(
            height: height * 0.08,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ThemeContainer(
                  scafoldColor: AppColors.T2darkOffwhite,
                  secondColor: AppColors.T2olive,
                  onTap: () {
                    themeIndex = 2;
                    widget.onThemeChanged(MyTheme.themes[themeIndex!]);

/*
                    showRewardedAd(context);
*/                  }),
              ThemeContainer(
                  scafoldColor: AppColors.T3black,
                  secondColor: AppColors.T3lightBlue,
                  onTap: () {
                    themeIndex = 3;
                    widget.onThemeChanged(MyTheme.themes[themeIndex!]);

/*
                    showRewardedAd(context);
*/                  }),
            ],
          ),
        ],
      ),
    );
  }
}
