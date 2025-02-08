import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController(text: "");
  var senhaController = TextEditingController(text: "");
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 252, 255),
        body: SingleChildScrollView(
          // width: double.infinity,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 70,
                ),
                Row(
                  children: [
                    Expanded(child: Container()),
                    Expanded(
                      flex: 2,
                      child: Image.asset("assets/images/my-wallet-logo.png"),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Bem vindo ao",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Wallet Wise",
                  style: TextStyle(
                    fontSize: 25,
                    color: Color.fromARGB(255, 171, 46, 239),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    height: 35,
                    alignment: Alignment.center,
                    child: TextField(
                      controller: emailController,
                      onChanged: (value) {
                        debugPrint(value);
                      },
                      style:
                          TextStyle(color: Color.fromARGB(255, 171, 46, 239)),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 0),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 171, 46, 239))),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 171, 46, 239))),
                        prefixIcon: Icon(Icons.email,
                            color: Color.fromARGB(255, 171, 46, 239)),
                        hintText: "Email",
                        hintStyle:
                            TextStyle(color: Color.fromARGB(255, 171, 46, 239)),
                      ),
                    )),
                const SizedBox(
                  height: 13,
                ),
                Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    height: 35,
                    alignment: Alignment.center,
                    child: TextField(
                      obscureText: isObscureText,
                      controller: senhaController,
                      onChanged: (value) {
                        debugPrint(value);
                      },
                      style:
                          TextStyle(color: Color.fromARGB(255, 171, 46, 239)),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 0),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 171, 46, 239))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 171, 46, 239))),
                          hintText: "Senha",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 171, 46, 239)),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color.fromARGB(255, 171, 46, 239),
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                isObscureText = !isObscureText;
                              });
                            },
                            child: Icon(
                              isObscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Color.fromARGB(255, 171, 46, 239),
                            ),
                          )),
                    )),
                const SizedBox(
                  height: 30,
                ),
                Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton(
                          onPressed: () {
                            if (emailController.text.trim() ==
                                    "email@email.com" &&
                                senhaController.text.trim() == "123") {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MainPage()));
                              debugPrint("Login Efetuado com sucesso");
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Erro no login")));
                              debugPrint("Erro no login");
                            }
                          },
                          style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                            backgroundColor: WidgetStateProperty.all(
                                Color.fromARGB(255, 171, 46, 239)),
                          ),
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          )),
                    )),
                Expanded(child: Container()),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  height: 30,
                  alignment: Alignment.center,
                  child: Text(
                    "Esqueci minha senha",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  height: 30,
                  alignment: Alignment.center,
                  child: Text(
                    "Criar conta",
                    style: TextStyle(
                      color: Color.fromARGB(255, 171, 46, 239),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
