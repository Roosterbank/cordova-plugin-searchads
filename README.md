# Cordova/Ionic Search Ads App Attribution API Plugin

## TL;DR
Cordova plugin for reading Search Ads App Attribution on **iOS 10.0+ only**.

## What is Search Ads App Attribution?
From [Apple's documentation](https://searchads.apple.com/help/pdf/attribution-api.pdf):

> Search Ads App Attribution enables developers to track and attribute app downloads that originate from Search Ads campaigns. With Search Ads App Attribution, iOS developers have the ability to accurately measure the lifetime value of newly acquired users and the effectiveness of their advertising campaigns.

## How to use the plugin
```
if (typeof window.SearchAds === 'undefined') {
  return;
}
const data = await window.SearchAds.fetchAttributionData();
// use data or catch error
});
```
