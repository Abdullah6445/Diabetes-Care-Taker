import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PopUpMenuClass {
  Widget AboutAppWidget = RichText(
    text: TextSpan(
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      children: [
        TextSpan(
          text: "About App:\n",
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.red.shade900,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        TextSpan(
          text: "Welcome to the ",
        ),
        TextSpan(
          text: "Diabetes Caretaker App",
          style: TextStyle(
            color: Color.fromARGB(151, 3, 89, 160),
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        TextSpan(
          text:
              ", your comprehensive companion for managing diabetes effectively. This app is tailored to support individuals with diabetes by providing essential tools and resources for everyday diabetes management.",
        ),
        TextSpan(
          text: "\n\nPURPOSE:",
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.red.shade900,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        TextSpan(
          text:
              "\nThe primary purpose of this application is to provide a centralized platform for individuals with diabetes to monitor their blood glucose levels, track their medication intake, manage insulin doses, and receive personalized insights and recommendations for better disease management. Additionally, the application aims to facilitate healthcare providers to analyze the insights and trends and patterns of data that patient gives in the application, enabling timely adjustments to treatment plans based on real-time data.",
        ),
        TextSpan(
          text: "\n\nFEATURES:\n",
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.red.shade900,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        TextSpan(
          text:
              "Blood Glucose Monitoring\nMedication Reminders\nHealth Insights and Trends\nInsulin Dose Calculation\nExercise Tracking\nDiabetes Education Library\nDiabetes-Related Tests Reminder System\nEmergency Alerts",
        ),
      ],
    ),
  );
  Widget ContactUsWidget = RichText(
    text: TextSpan(
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      children: [
        TextSpan(
          text: "Contact Us!\n",
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.red.shade900,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        TextSpan(
          text:
              "If you have any questions, feedback, or need support, please don't hesitate to contact us. We are here to help you on your journey to better health.",
        ),
        TextSpan(
          text: "\n\nEmail:",
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.red.shade900,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        TextSpan(
          text:
              "\nYou can reach us via email. We aim to respond to all inquiries within 24 hours.\n\nFor general inquiries, support, or feedback, email us at:",
        ),
        TextSpan(
          text: "\n\nSupport:",
        ),
        TextSpan(
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              String url =
                  'mailto:diabetescaretaker@gmail.com?subject=DiabetesCareTaker Contact-Us Support';
              launchUrl(Uri.parse(url));
            },
          text: " diabetescaretaker@gmail.com",
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.red.shade500,
            fontSize: 15,
          ),
        ),
        TextSpan(
          text: "\n\nFeedback::",
        ),
        TextSpan(
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              String url =
                  'mailto:diabetescaretaker@gmail.com?subject=DiabetesCareTaker Contact-Us FeedBack';
              launchUrl(Uri.parse(url));
            },
          text: " diabetescaretaker@gmail.com",
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.red.shade500,
            fontSize: 15,
          ),
        ),
      ],
    ),
  );

  Widget HelpWidget = RichText(
    text: TextSpan(
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      children: [
        TextSpan(
          text: "Help Center\n",
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.red.shade900,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        TextSpan(
          text:
              "Creating an Account\n1) Open the app and tap \"Sign Up\".\n2) Enter your email address and create a password.\n\nLogging In\n1) Open the app and tap \"Log In\". \n2)Enter your email and password.",
        ),
        TextSpan(
          text: "\n\nDashboard:",
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.red.shade900,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        TextSpan(
          text:
              "\nThe Dashboard gives you a quick overview of your blood glucose levels, and upcoming reminders.",
        ),
        TextSpan(
          text: "\n\nBlood Glucose Monitoring:",
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.red.shade900,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        TextSpan(
          text: "\nEnter your readings.",
        ),
        TextSpan(
          text: "\n\nHealth Insights and Trends:",
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.red.shade900,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        TextSpan(
          text:
              "\n1)Readings Display: The app displays the blood glucose readings entered by the user.\n2)Pictorial Representation: Provides graphical representations of blood glucose data.\n3)Trend Analysis: Analyzes patterns in blood glucose readings and displays them in graphs.",
        ),
        TextSpan(
          text: "\n\nMedication Reminders:",
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.red.shade900,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        TextSpan(
          text:
              "\nSetting Reminders: The app includes a feature for setting medication reminders to ensure timely intake of insulin and other medications.",
        ),
        TextSpan(
          text: "\n\nInsulin Dose Calculation:",
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.red.shade900,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        TextSpan(
          text:
              "\n1)Calculation Tools: Provides tools for calculating insulin doses based on carbohydrate intake and blood glucose levels.\n2)Formulas Used: Utilizes Insulin to Carbohydrate Ratio and Insulin Sensitivity Factors.\n3)Correction Dose: Helps calculate the insulin correction dose for high blood glucose levels.\n4)Note for Type 2: This feature is not applicable for Type 2 diabetes patients.",
        ),
        TextSpan(
          text: "\n\nDiabetes Education Library:",
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.red.shade900,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        TextSpan(
          text:
              "\nEducational Resources: Features a comprehensive library of educational resources related to diabetes management.",
        ),
        TextSpan(
          text: "\n\nLogin Problems:",
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.red.shade900,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        TextSpan(
          text:
              "\n1)Check your internet connection.\n2)Ensure you are entering the correct email and password.",
        ),
      ],
    ),
  );

  Widget DevelopersWidget = Column(
    children: [
      Card(
        elevation: 5,
        margin: EdgeInsets.all(20.0),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                  radius: 50, child: Image.asset("assets/images/person.png")),
              SizedBox(height: 10),
              Text(
                'Abdullah Iftikhar',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(
                  Icons.email,
                  color: Colors.black,
                ),
                title: Text(
                  'abdullahiftikhar6445@gmail.com',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.red.shade500,
                  ),
                ),
                // onTap: () => _launchURL('mailto:your.email@example.com'),
                onTap: () {
                  String url =
                      'mailto:abdullahiftikhar6445@gmail.com?subject=User From Diabetes CareTaker App';
                  launchUrl(Uri.parse(url));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.link,
                  color: Colors.black,
                ),
                title: Text('LinkedIn'),
                // onTap: () => _launchURL('https://www.linkedin.com/in/yourprofile'),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      Card(
        elevation: 10,
        margin: EdgeInsets.all(20.0),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                  radius: 50, child: Image.asset("assets/images/person.png")),
              SizedBox(height: 10),
              Text(
                'Zeeshan Haider',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(
                  Icons.email,
                  color: Colors.black,
                ),
                title: Text(
                  'abdullahiftikhar6445@gmail.com',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.red.shade500,
                  ),
                ),
                // onTap: () => _launchURL('mailto:your.email@example.com'),
                onTap: () {
                  String url =
                      'mailto:abdullahiftikhar6445@gmail.com?subject=User From Diabetes CareTaker App';
                  launchUrl(Uri.parse(url));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.link,
                  color: Colors.black,
                ),
                title: Text('LinkedIn'),
                // onTap: () => _launchURL('https://www.linkedin.com/in/yourprofile'),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),

      // Text("data"),
      // Text("data2"),
      // ListTile(
      //   leading: CircleAvatar(child: Image.asset("assets/images/person.png")),
      //   title: Text(
      //     "Abdullah",
      //     overflow: TextOverflow.ellipsis,
      //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      //   ),
      //   subtitle: Text(
      //     "20781556-045"!,
      //     overflow: TextOverflow.ellipsis,
      //     style: TextStyle(fontSize: 12),
      //   ),
      // ),
    ],
  );
}
