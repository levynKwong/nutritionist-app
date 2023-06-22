// import 'package:flutter/services.dart';
// import 'package:purchases_flutter/models/offering_wrapper.dart';
// import 'package:purchases_flutter/purchases_flutter.dart';
// // goog_JOqwYSmDCvNhYRFmMfOVybysoDu


// class Coins{
// static const idCoin1 = 'coin_1';
// static const idCoin2 = 'coin_2';
// static const idCoin3 = 'coin_3';
// static const allIds = [idCoin1,idCoin2,idCoin3];
// }

// class PurchaseApi {
//   static const _apiKey = 'goog_JOqwYSmDCvNhYRFmMfOVybysoDu';

//   static Future<void> init() async {
//     await Purchases.setDebugLogsEnabled(true);
//     await Purchases.setup(_apiKey);
//   }

//   static Future<List<Offering>> fetchOffersByIds(List<String> ids) async {
//     try {
//       final offerings = await Purchases.getOfferings();
//       return offerings.all.values
//           .where((offer) => ids.contains(offer.identifier))
//           .toList();
//     } on PlatformException catch (e) {
//       print(e);
//       return [];
//     }
//   }

//   static Future<List<Offering>> fetchOffers({bool all = true}) async {
//     try {
//       final offerings = await Purchases.getOfferings();
//       if (!all) {
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

//   static Future purchaseCoins(String coinId) async {
//     try {
      
//       final offerings = await fetchOffersByIds([coinId]);
//       if (offerings.isNotEmpty) {
//         final offering = offerings.first;
//         final purchasePackage = offering.availablePackages.first;
//         final purchaserInfo = await Purchases.purchasePackage(purchasePackage);
//         return purchaserInfo;
//       } else {
//         print('No available offerings for coinId: $coinId');
//         return null;
//       }
//     } on PlatformException catch (e) {
//       print(e);
//       return null;
//     }
//   }

//   static Future<bool> purchasePackage(Package package) async {
//     try {
//       await Purchases.purchasePackage(package);
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }
// }