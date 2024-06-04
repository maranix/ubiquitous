import 'package:clipboard_service/clipboard_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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

class _MyHomePageState extends State<MyHomePage> with ClipboardListener {
  String? clipboardText;
  late final ClipboardService _clipboardService;

  @override
  void initState() {
    _clipboardService = ClipboardService();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _clipboardService.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          children: [
            StreamBuilder<ClipboardData>(
              stream: _clipboardService.changes,
              initialData: const ClipboardData(text: "initialData"),
              builder: (BuildContext context, snapshot) {
                return switch (snapshot.connectionState) {
                  ConnectionState.waiting =>
                    const CircularProgressIndicator.adaptive(),
                  ConnectionState.done => Text(snapshot.requireData.text ?? ""),
                  _ => const Text("Listening"),
                };
              },
            ),
          ],
        ),
      ),
    );
  }
}
