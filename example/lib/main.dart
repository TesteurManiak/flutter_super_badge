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

  final flutterSuperBadge = FlutterSuperBadge();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadingNotifier.value = true;
      Permission.notification.isDenied.then((value) async {
        if (value) {
          await Permission.notification.request();
        }
        loadingNotifier.value = false;
      });
    });
  }

  @override
  void dispose() {
    counterNotifier.dispose();
    loadingNotifier.dispose();
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
            Text(
              '${counterNotifier.value} notifications',
              style: theme.textTheme.headlineMedium,
            ),
            ElevatedButton.icon(
              onPressed: reset,
              icon: const Icon(Icons.refresh),
              label: const Text('Reset Badge'),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: incrementCounter,
        tooltip: 'Increment Notifications Count',
        child: const Icon(Icons.add),
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
}
