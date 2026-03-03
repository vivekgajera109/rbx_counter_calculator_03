import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rbx_counter/Provider/ads_provider.dart';
import 'package:rbx_counter/Provider/calculator_provider.dart';
import 'package:rbx_counter/Provider/home_provider.dart';
import 'package:rbx_counter/Provider/quiz_provider.dart';
import 'package:rbx_counter/Provider/splash_provider.dart';
import 'package:rbx_counter/constants/app_colors.dart';
import 'package:rbx_counter/firebase_options.dart';
import 'package:rbx_counter/helper/remote_config_service.dart';
import 'package:rbx_counter/screen/splash_screen.dart';
import 'Provider/onboarding_provider.dart';
import 'Provider/spin_wheel_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => QuizProvider()),
        ChangeNotifierProvider(create: (_) => SpinWheelProvider()),
        ChangeNotifierProvider(create: (_) => CalculatorProvider()),
        ChangeNotifierProvider(create: (_) => AdsProvider()),
        ChangeNotifierProvider(create: (_) => OnboardingProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => RemoteConfigService.initialize(context));
    // 🔥 Remote Config NOW working
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RBX Counter Robox Counter',
      theme: AppTheme.theme,
      home: const SplashScreen(),
    );
  }
}
