import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';



/// Uygulama yaşam döngüsünü dinlemek için kullanılan yardımcı sınıf.
/// Debug çıktıları ile uygulamanın yaşam döngüsü durumlarını takip etmeyi sağlar.Debug konsolda  Crtl+f ile (--) ekleyin ve tüm çıktıları rahatça görün.
class AppLifecycleDisplay extends StatefulWidget {
  const AppLifecycleDisplay({super.key});

  @override
  State<AppLifecycleDisplay> createState() => _AppLifecycleDisplayState();
}

class _AppLifecycleDisplayState extends State<AppLifecycleDisplay> {
  late final AppLifecycleListener _listener;
  final List<String> _states = <String>[];
  late AppLifecycleState? _state;

  @override
  void initState() {
    super.initState();
    // Uygulama yaşam döngüsü dinleyicisini başlat
    applifecycle();
  }

  void applifecycle() {
    // _state = SchedulerBinding.instance.lifecycleState;
    _state = SchedulerBinding.instance.lifecycleState;

    // Uygulama durum değişikliklerini dinleyen bir listener oluşturur.
    // Her durum için özel bir callback tetiklenir:
    _listener = AppLifecycleListener(
      onInactive: () {
        debugPrint('--🔵 [EVENT] onInactive tetiklendi');
        _handleTransition('inactive');
      },

      onHide: () {
        debugPrint('--🔵 [EVENT] onHide tetiklendi');
        _handleTransition('hidden');
      },

      onResume: () {
        debugPrint('--🟢 [EVENT] onResume tetiklendi');
        _handleTransition('resume');
      },

      onPause: () {
        debugPrint('--🔵 [EVENT] onPause tetiklendi');
        _handleTransition('pause');
      },

      onDetach: () {
        debugPrint('--🔴 [EVENT] onDetach tetiklendi');
        _handleTransition('detach');
      },

      onShow: () {
        debugPrint('--🟢 [EVENT] onShow tetiklendi');
        _handleTransition('show');
      },

      onRestart: () {
        debugPrint('--🟡 [EVENT] onRestart tetiklendi');
        _handleTransition('restart');
      },

      onStateChange: (state) {
        debugPrint('--⚪ [STATE] Yeni durum: $state');
        setState(() {
          _state = state;
        });
      },
    );
    if (_state != null) {
      _states.add(_state!.name);
    }
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  void _handleTransition(String name) {
    setState(() {
      _states.add(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Geçmişi temizle
                  ElevatedButton(
                    onPressed: () => setState(() => _states.clear()),
                    child: const Text('Clear History'),
                  ),

                  // debug kısmından tekibi kolaylaştırmak için
                  ElevatedButton(
                    onPressed: () {
                      debugPrint('------------------------');
                    },
                    child: const Text('---'),
                  ),
                ],
              ),
              Text('Mevcut Durum: ${_state ?? 'Henüz başlatılmadı'}'),
              Text(
                'Durum Geçmişi:\n  ${_states.join('\n  ')}',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}



/*
Sayfayı çalıştırırsanız debug konsolunda aşağıdaki gibi çıktılar göreceksiniz:

Uygulama arka plana alınıp tekrar ön plana getirildiğinde:

 --🔵 [EVENT] onInactive tetiklendi
 --⚪ [STATE] Yeni durum: AppLifecycleState.inactive
 --🔵 [EVENT] onHide tetiklendi
 --⚪ [STATE] Yeni durum: AppLifecycleState.hidden
 --🔵 [EVENT] onPause tetiklendi
 --⚪ [STATE] Yeni durum: AppLifecycleState.paused
 --🟡 [EVENT] onRestart tetiklendi
 --⚪ [STATE] Yeni durum: AppLifecycleState.hidden
 --🟢 [EVENT] onShow tetiklendi
 --⚪ [STATE] Yeni durum: AppLifecycleState.inactive
 --🟢 [EVENT] onResume tetiklendi
 --⚪ [STATE] Yeni durum: AppLifecycleState.resumed

 bu kısmı  app_lifecycle.png görseli ile takip edin daha basit bir şekilde anlaşılır.



Bildirim tepsisi(paneli) açıldı ve kapandı:

 --🔵 [EVENT] onInactive tetiklendi
 --⚪ [STATE] Yeni durum: AppLifecycleState.inactive
 --🟢 [EVENT] onResume tetiklendi
 --⚪ [STATE] Yeni durum: AppLifecycleState.resumed



 
Inactive ve hidden iki kez geliyor çünkü:

 Gidiş yolunda: Aktiften pasife geçiş için kullanılıyor
 Dönüş yolunda: Pasiften aktife geçiş için kullanılıyor

 Bu durumlar köprü görevi görür. İşletim sistemi uygulamanızı ani şekilde durdurmak yerine, yumuşak geçişler sağlar. Bu sayede:

 Animasyonlar düzgün çalışır
 Kaynak yönetimi kontrollü olur

 app_lifecycle.png görselininde de gözüktüğü gibi tek bir yönde işlem gerçekleşmiyor,resume den pause, pause dan resume a çift yönlü o yüzden aradakiler 2 kez çalışıyor !!

*/ 