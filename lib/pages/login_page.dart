import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_project/pages/home_page.dart';
import 'package:simple_project/pages/register_page.dart';
import 'package:simple_project/service/login_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final loginVerif = BlocProvider.of<LoginService>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: const Text('Login'),
          automaticallyImplyLeading: false,
          /*actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const RegisterPage()));
                },
                icon: const Icon(Icons.login_outlined)),
          ],*/
        ),
        body: BlocListener<LoginService, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomePage()));
            } else if (state is Failure) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Email ou Senha incorretos'),
                backgroundColor: Colors.black,
              ));
            }
          },
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Icon(
                      Icons.account_circle,
                      size: 150,
                    ),
                    SizedBox(
                      width: 300,
                      height: 50,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Colors.black),
                            hintText: 'Email',
                          ),
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 300,
                      height: 50,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: TextField(
                          controller: passwordController,
                          style: const TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.black),
                            hintText: 'Senha',
                            suffixIcon: IconButton(
                              icon: Icon(obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  obscurePassword = !obscurePassword;
                                });
                              },
                            ),
                          ),
                          obscureText: obscurePassword,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          try {
                            loginVerif.login(
                                email: emailController.text,
                                password: passwordController.text);
                            emailController.clear();
                            passwordController.clear();
                          } catch (e) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Email ou Senha incorretos'),
                              backgroundColor: Colors.black,
                            ));
                          }
                        },
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.blue)),
                        child: const Text(
                          'Let me in',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const RegisterPage()));
                        },
                        child: const Text(
                          'Fazer Cadastro',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
