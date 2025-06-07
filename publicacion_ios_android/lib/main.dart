import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(const PlatformSwitcherApp());

class PlatformSwitcherApp extends StatefulWidget {
  const PlatformSwitcherApp({super.key});
  @override
  State<PlatformSwitcherApp> createState() => _PlatformSwitcherAppState();
}

class _PlatformSwitcherAppState extends State<PlatformSwitcherApp> {
  bool _simulateIOS = false;

  @override
  Widget build(BuildContext context) {
    final isIOS = _simulateIOS;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      home: Scaffold(
        backgroundColor: isIOS ? Colors.black : null,
        appBar: AppBar(
          title: Text(isIOS ? 'Contacto (iOS)' : 'Contacto (Android)'),
          actions: [
            Row(
              children: [
                const Text('iOS'),
                Switch(
                  value: _simulateIOS,
                  onChanged: (v) => setState(() => _simulateIOS = v),
                ),
              ],
            ),
          ],
        ),
        body: Center(child: isIOS ? const IosCard() : const AndroidCard()),
      ),
    );
  }
}

// Interfaz de android
class AndroidCard extends StatelessWidget {
  const AndroidCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ContactContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundColor: Colors.green,
            child: Icon(Icons.android, size: 40, color: Colors.white),
          ),
          const SizedBox(height: 12),

          const Text(
            'Edison Verdesoto',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),

          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('099 862 1890'),
            subtitle: const Text('Móvil'),
          ),
          const Divider(),

          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.chat),
                label: const Text('Mensaje'),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.share),
                label: const Text('Compartir'),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.star_border),
                label: const Text('Favorito'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Interfaz de iOS
class IosCard extends StatelessWidget {
  const IosCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: const CupertinoThemeData(brightness: Brightness.dark),
      child: ContactContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 32,
              backgroundColor: CupertinoColors.systemGrey,
              child: Text('C', style: TextStyle(fontSize: 30)),
            ),
            const SizedBox(height: 10),
            const Text(
              'Contacto Contacto',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),

            CupertinoButton(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              color: CupertinoColors.systemGrey5,
              borderRadius: BorderRadius.circular(10),
              onPressed: () {},
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '665 666 666',
                  style: TextStyle(color: CupertinoColors.white),
                ),
              ),
            ),
            const SizedBox(height: 14),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _CupertinoAction(CupertinoIcons.chat_bubble_text, 'Mensaje'),
                _CupertinoAction(CupertinoIcons.share, 'Compartir'),
                _CupertinoAction(CupertinoIcons.star, 'Favorito'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CupertinoAction extends StatelessWidget {
  const _CupertinoAction(this.icon, this.label);
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoButton(
          padding: EdgeInsets.zero,
          color: CupertinoColors.systemGrey5,
          minSize: 50,
          borderRadius: BorderRadius.circular(16),
          onPressed: () {},
          child: Icon(icon, size: 22, color: CupertinoColors.white),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

class ContactContainer extends StatelessWidget {
  const ContactContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(24),
      ),
      child: child,
    );
  }
}
