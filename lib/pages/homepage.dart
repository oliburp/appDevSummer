import '/import/export.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.email});
  final String email;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patogtog'),
      ),
    );
  }
}