import 'package:assignment/screens/success_screen.dart';
import 'package:flutter/cupertino.dart';
import '../screens/home_screen.dart';

class SlidePageRoute extends PageRouteBuilder {
  final WidgetBuilder builder;
  final RouteSettings settings;

  SlidePageRoute({required this.builder, RouteSettings? settings})
      : settings = settings ?? const RouteSettings(),
        super(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) =>
            builder(context),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final begin = const Offset(1.0, 0.0);
          final end = Offset.zero;
          final curve = Curves.easeInOut;
          final tween =
          Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );
}

class Routes {
  static const String homeScreen = '/homeScreen';
  static const String successScreen = '/successScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return SlidePageRoute(
          builder: (context) => const HomeScreen(),
        );
      case successScreen:
        return SlidePageRoute(
          builder: (context) => const SuccessScreen(),
        );
      default:
        return SlidePageRoute(builder: (context) {
          return Container(
            child: Text('Route Not Available for ${settings.name}'),
          );
        });
    }
  }
}
