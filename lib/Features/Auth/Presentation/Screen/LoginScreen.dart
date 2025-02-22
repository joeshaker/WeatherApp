import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart'; // Add geolocator package
import 'package:weatherapp/Core/Component/Button.dart';
import 'package:weatherapp/Core/Utilities/Colors.dart';
import 'package:weatherapp/Core/Utilities/Strings.dart';
import 'package:weatherapp/Features/Auth/Data/Repository/repository.dart';
import 'package:weatherapp/Features/Auth/Presentation/Controller/LoginCubit/login_cubit.dart';
import 'package:weatherapp/Features/Auth/Presentation/Screen/SignUpScreen.dart';
import 'package:weatherapp/Features/Auth/Presentation/Widget/TextFormFeild.dart';
import 'package:weatherapp/Features/HomePage/Presentation/Screen/HomeScreen.dart';
import '../../../../Core/Component/LoginText.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // Function to get the user's current location
  Future<Position?> _getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      Fluttertoast.showToast(msg: "Please enable location services");
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied
        Fluttertoast.showToast(msg: "Location permissions are denied");
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied
      Fluttertoast.showToast(msg: "Location permissions are permanently denied");
      return null;
    }

    // Get the current location
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: background,
      body: BlocProvider(
        create: (context) => LoginCubit(AuthRepository()),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) async {
            if (state is LoginSuccess) {
              // Get the user's location after successful login
              Position? position = await _getUserLocation();
              if (position != null) {
                // Navigate to HomeScreen with location data
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => homeScreen(
                      latitude: position.latitude,
                      longitude: position.longitude,
                    ),
                  ),
                );
              } else {
                // Handle case where location is not available
                Fluttertoast.showToast(msg: "Unable to fetch location");
              }
            } else if (state is LoginFailure) {
              // Show error message on login failure
              Fluttertoast.showToast(
                msg: state.message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.SNACKBAR,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: LoginText(
                        text: login,
                        fontSize: 50,
                      ),
                    ),
                    Center(
                      child: LoginText(
                        text: textLogo,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 70),
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LoginText(text: email),
                          Container(
                            width: screenWidth * .8,
                            child: defaultTextFormDecorated(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              fillColor: backgroundTextForm,
                              borderRadius: 30,
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Email cannot be empty";
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: screenHeight * .03),
                          LoginText(text: password),
                          Container(
                            width: screenWidth * .8,
                            child: defaultTextFormDecorated(
                              isPassword: LoginCubit.get(context).isPassword,
                              suffixPressed: LoginCubit.get(context).ChangeVisiblity,
                              suffixicon: LoginCubit.get(context).sufixx,
                              controller: passController,
                              type: TextInputType.visiblePassword,
                              fillColor: backgroundTextForm,
                              borderRadius: 30,
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password cannot be empty";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * .09),
                    CustomButton(
                      onPressed: () {
                        if (formKey.currentState != null &&
                            formKey.currentState!.validate()) {
                          context.read<LoginCubit>().signInWithEmailAndPassword(
                            emailController.text,
                            passController.text,
                          );
                        }
                      },
                      width: 250,
                      height: 50,
                      backgroundColor: loginButton,
                      text: login,
                      isLoading: state is LoginLoading,
                    ),
                    SizedBox(height: screenHeight * .02),
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      ),
                      child: LoginText(
                        text: "Don't Have An Account?",
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}