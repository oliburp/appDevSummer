import '/import/export.dart';
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    timeInSecForIosWeb: 2,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: const Color.fromARGB(255, 5, 236, 143),
    textColor: Colors.black,
    fontSize: 16.0,
  );
}

class MyEmail extends StatelessWidget {
  const MyEmail({
    super.key,
    required this.labelText,
    required this.preIcon,
    required this.controller,
  });

  final String labelText;
  final IconData preIcon;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 5, 236, 143),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 5, 236, 143), width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Icon(preIcon, color: Colors.white),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      style: const TextStyle(color: Colors.white),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }
}

class MyPassword extends StatefulWidget {
  MyPassword({
    super.key,
    required this.labelText,
    this.preIcon = Icons.lock,
    required this.controller,
    required this.validator,
  });

  final FormFieldValidator<String>? validator;
  final String labelText;
  bool isObscure = true;
  final IconData preIcon;
  IconData suffIcon = Icons.visibility_off;
  final TextEditingController controller;

  @override
  State<MyPassword> createState() => _MyPasswordState();
}

class _MyPasswordState extends State<MyPassword> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 5, 236, 143),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 5, 236, 143), width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(Icons.lock, color: Colors.white),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              widget.isObscure = !widget.isObscure;
              widget.suffIcon =
                  widget.isObscure ? Icons.visibility_off : Icons.visibility;
            });
          },
          icon: Icon(
            widget.suffIcon,
            color: Colors.white,
          ),
        ),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        errorMaxLines: 3,
      ),
      style: const TextStyle(color: Colors.white),
      obscureText: widget.isObscure,
      validator: widget.validator,
    );
  }
}

class MyButton extends StatelessWidget {
  MyButton(
      {super.key,
      required this.text,
      required this.onTap,
      required this.height,
      this.fontSize = 16});

  final String text;
  final VoidCallback onTap;
  final double height;
  double fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 5, 236, 143),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize),
        ),
      ),
    );
  }
}

class MyPlayerButtons extends StatefulWidget {
  MyPlayerButtons({super.key, this.width = 70, required this.icon});

  double width;
  IconData icon;

  @override
  State<MyPlayerButtons> createState() => _MyPlayerButtonsState();
}

class _MyPlayerButtonsState extends State<MyPlayerButtons> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          alignment: Alignment.center,
          height: 70,
          width: widget.width,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 24, 28, 24),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(100, 2, 126, 76),
                blurRadius: 4,
                offset: Offset(0, 1),
              ),
              BoxShadow(
                color: Color.fromARGB(150, 5, 236, 143),
                blurRadius: 4,
                offset: Offset(0, -1),
              ),
            ],
          ),
          child: Icon(
            widget.icon,
            size: 45,color: Color.fromARGB(255, 5, 236, 143),
          )),
    );
  }
}

class SharedPrefs {
  static Future<void> saveFavorites(List<String> favorites) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final loginEmail = prefs.getString('loginEmail');
    prefs.setStringList('favorites_$loginEmail', favorites);
  }

  static Future<List<String>> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final loginEmail = prefs.getString('loginEmail');
    return prefs.getStringList('favorites_$loginEmail') ?? [];
  }
}
