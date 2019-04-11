# Cordova/Ionic Search Ads App Attribution API Plugin

## TL;DR
Cordova plugin for reading Search Ads App Attribution on **iOS 10.0+ only**.

The Search Ads API plugin for Cordova/Ionic didn't exist, so I created it. You can [check out the plugin code on Github](https://github.com/Hitman666/cordova-plugin-searchads), view the [Ionic demo app code on Github](https://github.com/Hitman666/ionicDemoCordovaPluginSearchAds) or read onward for an example on how to use it.

> You can also check out the step by step tutorial about [How to create a **native iOS app** that can read Search Ads Attribution API information](http://www.nikola-breznjak.com/blog/ios/create-native-ios-app-can-read-search-ads-attribution-api-information/) if you're not into hybrid solutions 😯.

## What is Search Ads App Attribution?
From [Apple's documentation](https://searchads.apple.com/help/pdf/attribution-api.pdf):

> Search Ads App Attribution enables developers to track and attribute app downloads that originate from Search Ads campaigns. With Search Ads App Attribution, iOS developers have the ability to accurately measure the lifetime value of newly acquired users and the effectiveness of their advertising campaigns.

## How to use the plugin
```
if (typeof window.SearchAds === 'undefined') {
  return;
}
window.SearchAds.initialize(function(attribution) {
    console.dir(attribution); // do something with this attribution (send to your server for further processing)
    $scope.data = JSON.stringify(attribution);
}, function (err) {
    console.dir(err);
});
```