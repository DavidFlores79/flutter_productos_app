import 'package:flutter/material.dart';
import 'package:productos_app/providers/providers.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static const String routerName = 'Login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CardContainer(
                child: Column(
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700]),
                    ),
                    // _LoginForm(),
                    ChangeNotifierProvider(
                        create: (context) => LoginFormProvider(),
                        child: const _LoginForm()),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width80 = (size.width * 0.15);
    final loginForm = Provider.of<LoginFormProvider>(context);
    final Color myColor = Color.fromARGB(255, 17, 92, 153);

    return Container(
      child: Form(
          key: loginForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                    color: myColor,
                    hintText: 'john.doe@mail.com',
                    labelText: 'Email',
                    prefixIcon: Icons.alternate_email_outlined),
                onChanged: (value) => loginForm.email = value,
                validator: (value) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp = RegExp(pattern);
                  return regExp.hasMatch(value ?? '')
                      ? null
                      : 'Correo inv??lido.';
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecorations.authInputDecoration(
                    color: myColor,
                    hintText: 'M??nimo 8 caracteres',
                    labelText: 'Contrase??a',
                    prefixIcon: Icons.lock_outlined),
                onChanged: (value) => loginForm.password = value,
                validator: (value) {
                  return (value != null && value.length >= 8)
                      ? null
                      : 'Contrase??a inv??lida.';
                },
              ),
              const SizedBox(
                height: 15,
              ),
              MaterialButton(
                onPressed: loginForm.isLoading
                    ? null
                    : () async {
                        if (!loginForm.isValidForm()) return;
                        loginForm.isLoading = true;
                        FocusScope.of(context).unfocus();
                        await Future.delayed(const Duration(seconds: 2));

                        loginForm.isLoading = false;

                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacementNamed(
                            context, HomeScreen.routerName);
                      },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: myColor,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: width80, vertical: 15),
                  child: Text(
                    loginForm.isLoading ? 'Espere' : 'Iniciar Sesi??n',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
