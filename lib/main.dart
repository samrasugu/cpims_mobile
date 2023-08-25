import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cpims_mobile/providers/auth_provider.dart';
import 'package:cpims_mobile/providers/connection_provider.dart';
import 'package:cpims_mobile/providers/ui_provider.dart';
import 'package:cpims_mobile/screens/auth/login_screen.dart';
import 'package:cpims_mobile/screens/initial_loader.dart';
import 'package:cpims_mobile/screens/splash_screen.dart';
import 'package:cpims_mobile/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UIProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ConnectivityProvider(),
        ),
      ],
      child: const CPIMS(),
    ),
  );
}

class CPIMS extends StatefulWidget {
  const CPIMS({Key? key}) : super(key: key);

  @override
  State<CPIMS> createState() => _CPIMSState();
}

class _CPIMSState extends State<CPIMS> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392, 781),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'CPIMS',
          debugShowCheckedModeBanner: false,
          theme: appTheme(),
          home: Builder(
            builder: (context) {
              return FutureBuilder(
                future: intialSetup(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SplashScreen();
                  }
                  return snapshot.data!['hasConnection'] == false ||
                          snapshot.data!['isAuthenticated']
                      ? const InitialLoadingScreen()
                      : const LoginScreen();
                },
              );
            },
          ),
        );
      },
    );
  }
}

Future<Map<String, dynamic>> intialSetup(BuildContext context) async {
  final hasConnection =
      await Provider.of<ConnectivityProvider>(context, listen: false)
          .checkInternetConnection();
  if (hasConnection == false) {
    return {'hasConnection': hasConnection, 'isAuthenticated': false};
  }
  final isAuthenticated =
      await Provider.of<AuthProvider>(context, listen: false)
          .verifyToken(context: context);

  return {'hasConnection': hasConnection, 'isAuthenticated': isAuthenticated};
}
