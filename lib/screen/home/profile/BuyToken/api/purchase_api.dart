import 'package:flutter/services.dart';
import 'package:purchases_flutter/models/offering_wrapper.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
// goog_JOqwYSmDCvNhYRFmMfOVybysoDu


// class PurchaseApi {
//   static const _apiKey = '';

//   static Future<void> init() async {
//     await Purchases.setDebugLogsEnabled(true);
//     await Purchases.setup(_apiKey);
//   }

//   static Future<List<Offering>> fetchOffersByIds(List<String> ids) async {
//     final offers = await fetchOffers();
//     return offers.where((offer) => ids.contains(offer.identifier)).toList();
//   }

//   static Future<List<Offering>> fetchOffers({bool all = true}) async {
//     try {
//       final offerings = await Purchases.getOfferings();
//       if (all) {
//         final current = offerings.current;
//         return current == null ? [] : [current];
//       } else {
//         return offerings.all.values.toList();
//       }
//     } on PlatformException catch (e) {
//       print(e);
//       return [];
//     }
//   }

//   static purchaseCoins(String coinId) async {
//     try {
//       print('coinId: $coinId');
//       final offering = (await fetchOffersByIds([coinId])).first;
//       final purchasePackage = offering.availablePackages.first;

//       final purchaserInfo = await Purchases.purchasePackage(purchasePackage);
//       return purchaserInfo;
//     } on PlatformException catch (e) {
//       print(e);
//       return null;
//     }
//   }
// }
