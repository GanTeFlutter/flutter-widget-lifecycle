import 'package:flutter/material.dart';

import 'package:flutter_life_cycle/future/widget_lifecycle/widget_change_dependencies.dart';
import 'package:flutter_life_cycle/product/state/theme_state.dart';
import 'package:flutter_life_cycle/product/theme/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    // ThemeNotifier sağlayıcısını burada tanımlıyoruz
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme().lightTheme.themeData,
      darkTheme: AppTheme().darkTheme.themeData,
      // Uygulamanın tema modunu ThemeNotifier üzerinden kontrol et
      themeMode: context.watch<ThemeNotifier>().isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,
      home: WidgetChangeDependencies(),
    );
  }
}

///
/// ┌─────────────────────────────────────────────────────────────────┐
/// │                        AppLifeCycle                             │
/// ├─────────────────────────────────────────────────────────────────┤
/// │  • AppLifecycleDisplay                                          │
/// │    - onInactive, onHide, onResume, onPause                      │
/// │    - onDetach, onShow, onRestart, onStateChange                 │
/// └─────────────────────────────────────────────────────────────────┘
///
/// ┌─────────────────────────────────────────────────────────────────┐
/// │                      WidgetLifecycle                            │
/// ├─────────────────────────────────────────────────────────────────┤
/// │  • ParentWidget                                                 │
/// │    - didUpdateWidget, deactivate, dispose                       │
/// │                                                                 │
/// │  • WidgetLifecycleView                                          │
/// │    - Hepsinin sıralı bir şekilde çalıştığı örnek                │
/// │                                                                 │
/// │  • WidgetChangeDependencies                                     │
/// │    - didChangeDependencies, tema ile tetikleme                  │
/// └─────────────────────────────────────────────────────────────────┘
