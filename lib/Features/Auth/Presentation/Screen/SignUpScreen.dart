import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weatherapp/Core/Utilities/Colors.dart';
import 'package:weatherapp/Core/Utilities/Strings.dart';
import 'package:weatherapp/Features/Auth/Data/Repository/repository.dart';
import 'package:weatherapp/Features/Auth/Presentation/Controller/SignupCubit/signup_cubit.dart';
import 'package:weatherapp/Features/Auth/Presentation/Screen/LoginScreen.dart';
import 'package:weatherapp/Features/Auth/Presentation/Widget/TextFormFeild.dart';
import '../../../../Core/Component/Button.dart';
import '../../../../Core/Component/LoginText.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final fullNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => SignupCubit(AuthRepository()),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SignupSuccess) {
            String successEmail="Email is Created Successfully";
            Fluttertoast.showToast(
                msg: successEmail,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.SNACKBAR,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          } else if (state is SignupFailure) {
            Fluttertoast.showToast(
                msg: state.message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.SNACKBAR,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Scaffold(
              backgroundColor: background,
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: LoginText(text: signup, fontSize: 50)),
                      Center(
                          child:
                          LoginText(text: textLogo, fontWeight: FontWeight.w300)),
                      const SizedBox(height: 70),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: screenHeight * .03),
                          LoginText(text: email),
                          SizedBox(
                            width: screenWidth * .8,
                            child: defaultTextFormDecorated(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              fillColor: backgroundTextForm,
                              borderRadius: 30,
                            ),
                          ),
                          SizedBox(height: screenHeight * .03),
                          LoginText(text: password),
                          SizedBox(
                            width: screenWidth * .8,
                            child: defaultTextFormDecorated(
                              isPassword: SignupCubit.get(context).isPassword,
                              controller: passController,
                              type: TextInputType.visiblePassword,
                              fillColor: backgroundTextForm,
                              borderRadius: 30,
                              suffixicon: SignupCubit.get(context).sufixx,
                              suffixPressed: SignupCubit.get(context).ChangeVisiblity
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * .09),
                      CustomButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<SignupCubit>().signUpWithEmailAndPassword(
                              emailController.text,
                              passController.text,
                            );
                          }
                        },
                        width: 250,
                        height: 50,
                        backgroundColor: loginButton,
                        text: signup,
                        isLoading: state is SignupLoading,
                      ),
                      SizedBox(height: screenHeight * .02),
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        ),
                        child: LoginText(
                          text: "Have An Account?",
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
