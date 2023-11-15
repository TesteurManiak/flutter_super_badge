import 'package:flutter/material.dart';
import 'package:flutter_super_badge/flutter_super_badge.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super Badge Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final counterNotifier = ValueNotifier<int>(0);
  final loadingNotifier = ValueNotifier<bool>(false);
  final enabledNotifier = ValueNotifier<bool>(false);
  final badgeSupportedNotifier = ValueNotifier<bool?>(null);

  final flutterSuperBadge = FlutterSuperBadge();

  @override
  void initState() {
    super.initState();

    loadingNotifier.addListener(enabledListener);
    badgeSupportedNotifier.addListener(enabledListener);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loadingNotifier.value = true;

      await Permission.notification.isDenied.then((value) async {
        if (value) await Permission.notification.request();
      });

      loadingNotifier.value = false;
    });
  }

  @override
  void dispose() {
    counterNotifier.dispose();
    loadingNotifier.dispose();
    enabledNotifier.dispose();
    badgeSupportedNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.inversePrimary,
        title: const Text('Super Badge Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ValueListenableBuilder<bool?>(
              valueListenable: badgeSupportedNotifier,
              builder: (context, isSupported, _) {
                return Text('Badge supported: ${isSupported ?? 'unknown'}');
              },
            ),
            ValueListenableBuilder<int>(
                valueListenable: counterNotifier,
                builder: (context, count, _) {
                  return Text(
                    '$count notifications',
                    style: theme.textTheme.headlineMedium,
                  );
                }),
            ValueListenableBuilder<bool>(
              valueListenable: enabledNotifier,
              builder: (context, isEnabled, _) {
                return ElevatedButton.icon(
                  onPressed: isEnabled ? reset : null,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset Badge'),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: enabledNotifier,
        builder: (context, isEnabled, _) {
          return FloatingActionButton(
            disabledElevation: 0,
            backgroundColor: isEnabled ? null : Colors.grey[200],
            foregroundColor: isEnabled ? null : Colors.grey[400],
            onPressed: isEnabled ? incrementCounter : null,
            tooltip: 'Increment Notifications Count',
            child: const Icon(Icons.add),
          );
        },
      ),
    );
  }

  Future<void> incrementCounter() async {
    counterNotifier.value++;
    loadingNotifier.value = true;

    await flutterSuperBadge.updateBadgeCount(counterNotifier.value);

    loadingNotifier.value = false;
  }

  Future<void> reset() async {
    loadingNotifier.value = true;

    await flutterSuperBadge.removeBadge();

    counterNotifier.value = 0;
    loadingNotifier.value = false;
  }

  void enabledListener() {
    enabledNotifier.value =
        !loadingNotifier.value && (badgeSupportedNotifier.value ?? false);
  }
}
