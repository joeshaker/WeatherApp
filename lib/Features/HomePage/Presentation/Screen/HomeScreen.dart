import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/Core/Network/dio_helper.dart';
import 'package:weatherapp/Core/Utilities/Strings.dart';
import 'package:weatherapp/Features/HomePage/Data/data_source/data_source.dart';
import 'package:weatherapp/Features/HomePage/Data/repository/weather_rep_imp.dart';
import 'package:weatherapp/Features/HomePage/Domain/use_case/get_weather.dart';
import 'package:weatherapp/Features/HomePage/Presentation/Controller/Cubit/home_cubit.dart';
import 'package:weatherapp/Features/HomePage/Presentation/Widget/Container.dart';
import 'package:weatherapp/Features/HomePage/Presentation/Widget/RowItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weatherapp/Core/Component/defaultText.dart';
import 'package:weatherapp/Core/Component/getDate.dart';
import 'package:weatherapp/Core/Utilities/Colors.dart';
import 'package:weatherapp/Features/Auth/Presentation/Controller/auth.dart';
// update the homeScreen class to include the following:

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  bool _isLoading = false;
  String Name = FirebaseAuth.instance.currentUser!.email.toString();
  int atIndex = FirebaseAuth.instance.currentUser!.email.toString().indexOf('@');

  Future<void> _signOut(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    await Auth().signout(context: context);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HomePage
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    DioHelper.init();

    final weatherRemoteDataSource = WeatherRemoteDataSourceImpl(
      dioHelper: DioHelper(),
      apiKey: api_key,
    );
    final weatherRepository = WeatherRepositoryImpl(
      remoteDataSource: weatherRemoteDataSource,
    );
    final getWeather = GetWeather(weatherRepository);

    return BlocProvider(
      create: (context) => HomeCubit(getWeather: getWeather)..getWeatherData("Tanta", 3, 24, api_key),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final response = HomeCubit.get(context);
          if (state is HomeLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HomeSuccess) {
            final weatherData = [
              {"title": "UV Index", "value": "${response.response?.uvIndex}"},
              {"title": "Humidity", "value": "${response.response?.humidity}%"},
              {"title": "Wind Speed", "value": "${response.response?.windKph}Kph"},
              {"title": "Pressure", "value": "${response.response?.pressureMb}hPa"},
            ];

            return Scaffold(
              appBar: AppBar(
                backgroundColor: background,
                title: Center(child: defaultText(text: "Weather App", color: Colors.white)),
                automaticallyImplyLeading: false,
=======
    return Scaffold(
      body: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLoading)
              CircularProgressIndicator() // Show loading indicator
            else
              CustomButton(
                backgroundColor: signOutButton,
                text: "SignOut",
                onPressed: () async {
                  await _signOut(context); // Trigger sign-out
                },
>>>>>>> master
              ),
              backgroundColor: background,
              body: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                // top: height * .08,
                                right: width * .05,
                                left: width * .05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    defaultText(
                                      text: "Hello",
                                      color: TextColor,
                                      fontSize: width * 0.08,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    defaultText(
                                      text: Name.substring(0, atIndex),
                                      color: Colors.white,
                                      fontSize: width * 0.04,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ],
                                ),
                                Spacer(),
                                _isLoading
                                    ? CircularProgressIndicator()
                                    : IconButton(
                                  icon: Icon(Icons.logout, color: Colors.white),
                                  onPressed: () async {
                                    await _signOut(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: height * .02),
                            child: Column(
                              children: [
                                Center(
                                  child: defaultText(
                                    text: "${response.response?.locationName}",
                                    fontSize: width * 0.12,
                                    fontWeight: FontWeight.bold,
                                    color: TextColor,
                                  ),
                                ),
                                Center(
                                  child: defaultText(
                                    text: "${response.response?.region}",
                                    fontSize: width * 0.04,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   height: height * 0.01,
                          // ),
                          Image.network(
                            "https:${response.response?.conditionIcon}",
                            fit: BoxFit.fill,
                            width: width * 0.5,
                          ),
                          // SizedBox(
                          //   height: height * 0.01,
                          // ),
                          defaultText(
                            text: "${response.response?.temperatureC}°C",
                            fontSize: width * 0.08,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: EdgeInsets.all(width * .04),
                            child: GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: width * 0.05,
                                mainAxisSpacing: height * 0.02,
                                childAspectRatio: 1.9,
                              ),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: weatherData.length,
                              itemBuilder: (context, index) {
                                return defaultCard(
                                  color: backgroundCard,
                                  width: width * 0.4,
                                  height: height * 0.1,
                                  title: weatherData[index]["title"]!,
                                  value: weatherData[index]["value"]!,
                                );
                              },
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              defaultText(
                                text: "Next 3 Days",
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Container(
                                width: width * .92,
                                height: height * .235,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: backgroundCard,
                                ),
                                child: ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:  EdgeInsets.all(width*0.01),
                                      child: RowItem(
                                        todayText: "${getDayName(response.response!.forecastDays[index].date)}",
                                        humidityText: "${response.response!.forecastDays[index].chanceOfRain}%",
                                        maxTemp: "${response.response!.forecastDays[index].maxTempC}°C",
                                        minTemp: "${response.response!.forecastDays[index].minTempC}°C",
                                      ),
                                    );
                                  },
                                  itemCount: response.response!.forecastDays.length,
                                  separatorBuilder: (BuildContext context, int index) {
                                    return SizedBox(
                                      height: height * 0.02,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is HomeError) {
            return Center(child: Text("Error: ${state.error_message}"));
          } else {
            return Center(child: Text("Unknown state"));
          }
        },
      ),
    );
  }
}