import '/import/export.dart';

class MySignup extends StatefulWidget {
  const MySignup({super.key});

  @override
  State<MySignup> createState() => _MySignupState();
}

class _MySignupState extends State<MySignup> {
  bool loading = false;
  final formkey = GlobalKey<FormState>();
  final TextEditingController signupEmailController = TextEditingController();
  final TextEditingController signupPasswordController =
      TextEditingController();
  final TextEditingController signupConfirmPasswordController =
      TextEditingController();
  final FirebaseAuthService _auth = FirebaseAuthService();

  @override
  void dispose() {
    signupEmailController.dispose();
    signupPasswordController.dispose();
    signupConfirmPasswordController.dispose();
    super.dispose();
  }

  void submit() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        loading = true;
      });

      String email = signupEmailController.text;
      String password = signupPasswordController.text;

      User? user = await _auth.signUpEmailPassword(email, password);

      setState(() {
        loading = false;
      });

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(
              email: signupEmailController.text,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 28, 24),
      appBar: AppBar(
        title: const Text(
          'Patogtog',
          style: TextStyle(
              fontSize: 24,
              color: Color.fromARGB(255, 5, 236, 143),
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'Sign Up',
                  style: TextStyle(
                      fontSize: 32,
                      color: Color.fromARGB(255, 5, 236, 143),
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  'We wish to have a lot of togtogan with you!',
                  style: TextStyle(color: Color.fromARGB(255, 5, 236, 143)),
                ),
                const SizedBox(height: 20),
                MyEmail(
                  labelText: 'Email',
                  preIcon: Icons.email,
                  controller: signupEmailController,
                ),
                const SizedBox(height: 20),
                MyPassword(
                    labelText: 'Password',
                    controller: signupPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (!RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,16}$')
                          .hasMatch(value)) {
                        return 'The password must have a 8-16 characters, a-z, A-Z, 0-9 and a special character';
                      }
                      return null;
                    }),
                const SizedBox(height: 20),
                MyPassword(
                    labelText: 'Confirm Password',
                    controller: signupConfirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (signupPasswordController.text !=
                          signupConfirmPasswordController.text) {
                        return 'The password didn\'t match';
                      }
                      return null;
                    }),
                const SizedBox(height: 20),
                Center(
                  child: loading
                      ? const CircularProgressIndicator(
                          color: Color.fromARGB(255, 5, 236, 143))
                      : MyButton(
                          text: 'Register',
                          height: 50,
                          onTap: submit,
                        ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyLogin(),
                          ),
                        );
                      },
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                            color: Color.fromARGB(255, 5, 236, 143),
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
