// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';

class WidgetLifecycleView extends StatefulWidget {
  WidgetLifecycleView({super.key}) {
    debugPrint('--🧩 WidgetLifecycleView constructor çağrıldı');
  }

  @override
  State<WidgetLifecycleView> createState() {
    debugPrint('--🔵 WidgetLifecycleView.createState() çağrıldı');
    return _WidgetLifecycleViewState();
  }
}

class _WidgetLifecycleViewState extends State<WidgetLifecycleView> {
  @override
  /// StatefulWidget Widget'ın yaşam döngüsünde ilk çağrılan metot.
  /// WidgetLifecycleView nesnesi oluşturulduğunda bir kez çalışır.
  /// Controller'lar, listener'lar ve başlangıç değerleri burada tanımlanır.
  void initState() {
    super.initState();
    debugPrint('--🟢 initState() çağrıldı');
  }

  /// Widget'ın bağımlılıkları (InheritedWidget, Theme vb.) değiştiğinde çağrılır.
  /// initState()'den sonra ve build()'den önce çalışır.
  /// Provider, Theme gibi üst widget'lardan gelen değişiklikleri yakalamak için kullanılır.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint('--🟡 didChangeDependencies() çağrıldı');
  }

  /// Parent widget yeniden build olup bu widget'a yeni parametreler gönderdiğinde çağrılır.
  /// Eski widget ile yeni widget arasındaki farkları kontrol etmek için kullanılır.
  /// oldWidget parametresi üzerinden önceki değerlere erişilebilir.
  @override
  void didUpdateWidget(covariant WidgetLifecycleView oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint('--🟠 didUpdateWidget() çağrıldı');
  }

  /// Widget, widget ağacından geçici olarak kaldırıldığında çağrılır.
  /// Widget başka bir yere taşınıyor veya kaldırılıyor olabilir.
  /// dispose()'dan önce çalışır ve widget tekrar eklenebilir.
  @override
  void deactivate() {
    super.deactivate();
    debugPrint('--⚫ deactivate() çağrıldı');
  }

  /// Widget kalıcı olarak widget ağacından kaldırıldığında çağrılır.
  /// Controller'lar, listener'lar ve kaynaklar burada temizlenir (clean-up).
  /// Bu metot çağrıldıktan sonra State nesnesi bir daha kullanılamaz.
  @override
  void dispose() {
    debugPrint('--🔴 dispose() çağrıldı');
    super.dispose();
  }

  int counter = 0;

  @override
  Widget build(BuildContext context) {
    debugPrint('--⚪ build() çağrıldı');
    return Scaffold(
      appBar: AppBar(title: const Text('Widget Lifecycle View')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Text('Counter: $counter'),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  counter++;
                });
              },
              child: const Text('setState çağır'),
            ),
          ],
        ),
      ),
    );
  }
}
