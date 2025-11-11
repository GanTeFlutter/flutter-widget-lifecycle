import 'package:flutter/material.dart';
import 'package:flutter_life_cycle/product/state/theme_state.dart';
import 'package:provider/provider.dart';

class WidgetChangeDependencies extends StatefulWidget {
  const WidgetChangeDependencies({super.key});

  @override
  State<WidgetChangeDependencies> createState() =>
      _WidgetChangeDependenciesState();
}

class _WidgetChangeDependenciesState extends State<WidgetChangeDependencies> {
  late ThemeData currentTheme;
  late Brightness brightness;
  int _callCount = 0;
  @override
  void initState() {
    super.initState();
    debugPrint('--🟢 initState() çağrıldı');
    // ❌ currentTheme = Theme.of(context); // HATA! Context henüz hazır değil
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _callCount++;
    // ✅ Theme.of(context) burada güvenle kullanılır
    currentTheme = Theme.of(context);
    brightness = currentTheme.brightness;

    debugPrint(
      '--   Mevcut tema: ${brightness == Brightness.dark ? "Dark" : "Light"}',
    );
  }

  void _changeTheme() {
    context.read<ThemeNotifier>().toggleTheme();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('didChangeDependencies Örneği')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,

          children: [
            Text(
              'didChangeDependencies() çağrı sayısı: $_callCount',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Icon(
              brightness == Brightness.dark
                  ? Icons.dark_mode
                  : Icons.light_mode,
              size: 80,
              color: currentTheme.primaryColor,
            ),
            Text(
              'Mevcut Tema: ${brightness == Brightness.dark ? "Dark Mode" : "Light Mode"}',
              style: Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _changeTheme,
              icon: Icon(
                brightness == Brightness.dark
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
              label: const Text('Tema Değiştir'),
            ),
          ],
        ),
      ),
    );
  }
}
