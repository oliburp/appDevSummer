import '/import/export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const MyLogin(),
          ),
          (route) => false);
      getPref();
    });
    super.initState();
  }

  Future<void> getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final loginEmail = prefs.getString('loginEmail');
    final signupEmail = prefs.getString('signupEmail');
    if (loginEmail != null && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(
            email: loginEmail,
          ),
        ),
      );
    } else if (signupEmail != null && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(
            email: signupEmail,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 28, 24),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 250,
            child: Image.asset('assets/logo/logoLabel.png'),
          ),
          const SizedBox(height: 18),
          const SizedBox(
              height: 40,
              width: 40,
              child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 5, 236, 143))),
        ],
      )),
    );
  }
}
