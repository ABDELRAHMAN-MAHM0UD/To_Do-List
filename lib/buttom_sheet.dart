import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:to_do_release/ads/ad_unit.dart';
import 'package:to_do_release/task_widget/task_widget.dart';
import 'package:to_do_release/view_model.dart';
import 'package:to_do_release/colors.dart';
import 'package:provider/provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final ViewModel viewModel = ViewModel();
  BannerAd? bannerAd;
  bool _isAdLoaded = false;
  InterstitialAd? _interstitialAd;
  bool _InterstitialAdIsAdLoaded = false;

  void _loadBannerAd() {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AdsUtils.banenr1,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          print('Ad failed to load: $error');
        },
      ),
      request: AdRequest(),
    );
    bannerAd?.load();
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdsUtils.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _InterstitialAdIsAdLoaded = true;
        },
        onAdFailedToLoad: (error) => _InterstitialAdIsAdLoaded = false,
      ),
    );
  }
  void _showInterstitialAd() {
    if (_isAdLoaded && _interstitialAd != null) _interstitialAd!.show();
  }



  @override
  void initState() {
    super.initState();
    _loadBannerAd();
    _loadInterstitialAd();
  }

  @override
  void dispose() {
    bannerAd?.dispose();  // Dispose the ad to free up resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      color: AppColors.darkblue,
      height: double.infinity,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: viewModel.formKey,
                child: TextFormField(
                  onChanged: (text) {
                    viewModel.taskTitle.text = text;
                  },
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Please, enter the task you want to do';
                    }
                    return null;
                  },
                  controller: viewModel
                      .taskTitle, // Use the ViewModel's TextEditingController
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(color: AppColors.sky, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(color: AppColors.grey, width: 2),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.05),
              Text(
                "What are you up to?",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              SizedBox(height: height * 0.12),
              Container(
                margin: EdgeInsets.only(bottom: 40, top: 50),
                width: width * 0.7,
                child: ElevatedButton(
                  onPressed: () {
                    // Use Provider to add the task
                    viewModel.enterTask(context);
                    _showInterstitialAd();
                  },
                  child: Text("Enter"),
                  style: ButtonStyle(),
                ),
              ),
            _isAdLoaded?
              Container(

                width: bannerAd!.size.width.toDouble(),
                height: bannerAd!.size.height.toDouble(),
                  child: AdWidget(
                    ad: bannerAd!
                  )):
                Container()
            ],
          ),
        ),
      ),
    );
  }
}
