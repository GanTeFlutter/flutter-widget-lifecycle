import 'package:flutter/material.dart';

class ParentWidget extends StatefulWidget {
  const ParentWidget({super.key});

  @override
  State<ParentWidget> createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  int counter = 0;

  bool showChild = true;
  @override
  void initState() {
    super.initState();
    debugPrint('ParentWidget ----🟢 ParentWidget initState() çağrıldı');
      }

  @override
  Widget build(BuildContext context) {
    debugPrint('ParentWidget ----🔷 ParentWidget build() çağrıldı');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Parent Widget'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              debugPrint(
                ' ------------------------------------------------------------------',
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            Text(
              'Parent counter: $counter',
              style: const TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  counter++;
                });
              },
              child: const Text('Parent counter artır'),
            ),

            //  Counter’ı alt widget’a parametre olarak geçiyoruz      ----
            if (showChild) Didupdatewidgettext(text: 'Sayaç değeri: $counter'),

            // dispose() görebilmek icin child widgeti kaldiriyoruz
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showChild = !showChild;
                });
              },
              child: const Text('Child widgeti kaldır'),
            ),
          ],
        ),
      ),
    );
  }
}

class Didupdatewidgettext extends StatefulWidget {
  final String text;
  const Didupdatewidgettext({super.key, required this.text});

  @override
  State<Didupdatewidgettext> createState() => _DidupdatewidgettextState();
}

class _DidupdatewidgettextState extends State<Didupdatewidgettext> {
  @override
  void initState() {
    super.initState();
    debugPrint('--🟢Didupdatewidgettext initState() çağrıldı → ${widget.text}');
  }

  @override
  void didUpdateWidget(covariant Didupdatewidgettext oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint('--🟠Didupdatewidgettext didUpdateWidget() çağrıldı');
    debugPrint('--🧩Didupdatewidgettext Eski: ${oldWidget.text}');
    debugPrint('--🧩Didupdatewidgettext Yeni: ${widget.text}');
  }

  @override
  void deactivate() {
    super.deactivate();
    debugPrint('--⚫🧩Didupdatewidgettext deactivate() çağrıldı');

    /*
    Ne oluyor: Widget geçici olarak widget tree’den çıkarılıyor.
    State hâlâ bellekte duruyor, yani eğer widget tekrar tree’e eklenirse, aynı state ile build() tekrar çalıştırılabilir.
    Bu yüzden deactivate → dispose’den önce gelir.
    */
  }

  @override
  void dispose() {
    debugPrint('--🔴 Didupdatewidgettext dispose() çağrıldı');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('--⚪ Didupdatewidgettext build() çağrıldı → ${widget.text}');
    return Column(
      children: [
        Text(widget.text, style: const TextStyle(fontSize: 18)),
        ElevatedButton(
          onPressed: () {
            setState(() {});
          },
          child: const Text('Child setState çağır'),
        ),
      ],
    );
  }
}
