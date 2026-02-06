import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
// import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopping Delivery',
        theme: ThemeData(
          primaryColor: const Color(0xFF1c2e4a),
          scaffoldBackgroundColor: const Color(0xFFF5F6FA),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF1c2e4a),
            foregroundColor: Colors.white,
            elevation: 0,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_localization/flutter_localization.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await FlutterLocalization.instance.ensureInitialized();
//   runApp(const MyApp());
// }

// mixin AppLocale {
//   static const String title = 'title';
//   static const String thisIs = 'thisIs';

//   static const Map<String, dynamic> EN = {
//     title: 'Localization',
//     thisIs: 'This is %a package, version %a.',
//   };
//   static const Map<String, dynamic> HI = {
//     // Changed from 'hi' to 'HI'
//     title: 'कार्यक्रम',
//     thisIs: 'नमस्ते दुनिया.',
//   };
//   static const Map<String, dynamic> GU = {
//     title: 'સ્થાનિકરણ',
//     thisIs: 'પેકેજ, સંસ્કરણ %a છે.',
//   };
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   final FlutterLocalization _localization = FlutterLocalization.instance;

//   @override
//   void initState() {
//     _localization.init(
//       mapLocales: [
//         const MapLocale(
//           'en',
//           AppLocale.EN,
//           countryCode: 'US',
//           fontFamily: 'Font EN',
//         ),
//         const MapLocale(
//           'hi',
//           AppLocale.HI, // Changed from AppLocale.hi to AppLocale.HI
//           countryCode: 'IN',
//           fontFamily: 'Font HI',
//         ),
//         const MapLocale(
//           'gu',
//           AppLocale.GU,
//           countryCode: 'IN',
//           fontFamily: 'Font GU',
//         ),
//       ],
//       initLanguageCode: 'en',
//     );
//     _localization.onTranslatedLanguage = _onTranslatedLanguage;
//     super.initState();
//   }

//   void _onTranslatedLanguage(Locale? locale) {
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       supportedLocales: _localization.supportedLocales,
//       localizationsDelegates: _localization.localizationsDelegates,
//       home: const SettingsScreen(),
//       theme: ThemeData(fontFamily: _localization.fontFamily),
//     );
//   }
// }

// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({super.key});

//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }

// class _SettingsScreenState extends State<SettingsScreen> {
//   final FlutterLocalization _localization = FlutterLocalization.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(AppLocale.title.getString(context))),
//       body: Container(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     child: const Text('English'),
//                     onPressed: () {
//                       _localization.translate('en');
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 16.0),
//                 Expanded(
//                   child: ElevatedButton(
//                     child: const Text('Hindi'),
//                     onPressed: () {
//                       _localization.translate(
//                         'hi',
//                       ); // Changed from 'HI' to 'hi'
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 16.0),
//                 Expanded(
//                   child: ElevatedButton(
//                     child: const Text('Gujarati'),
//                     onPressed: () {
//                       _localization.translate(
//                         'gu',
//                       ); // Removed 'save: false' for consistency
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16.0),
//             ItemWidget(
//               title: 'Current Language',
//               content: _localization.getLanguageName(),
//             ),
//             ItemWidget(title: 'Font Family', content: _localization.fontFamily),
//             ItemWidget(
//               title: 'Locale Identifier',
//               content: _localization.currentLocale.localeIdentifier,
//             ),
//             ItemWidget(
//               title: 'String Format',
//               content: Strings.format('Hello %a, this is me %a.', [
//                 'Dara',
//                 'Sopheak',
//               ]),
//             ),
//             ItemWidget(
//               title: 'Context Format String',
//               content: context.formatString(AppLocale.thisIs, [
//                 AppLocale.title,
//                 'LATEST',
//               ]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ItemWidget extends StatelessWidget {
//   const ItemWidget({super.key, required this.title, required this.content});

//   final String? title;
//   final String? content;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(child: Text(title ?? '')),
//           const Text(' : '),
//           Expanded(child: Text(content ?? '')),
//         ],
//       ),
//     );
//   }
// }
