import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PopUpMenuClass {
  Widget AboutAppWidget = RichText(
    text: TextSpan(
      style: const TextStyle(
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
        const TextSpan(
          text: "Welcome to the ",
        ),
        const TextSpan(
          text: "Diabetes Caretaker App",
          style: TextStyle(
            color: Color.fromARGB(151, 3, 89, 160),
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        const TextSpan(
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
        const TextSpan(
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
        const TextSpan(
          text:
              "Blood Glucose Monitoring\nMedication Reminders\nHealth Insights and Trends\nInsulin Dose Calculation\nExercise Tracking\nDiabetes Education Library\nDiabetes-Related Tests Reminder System\nEmergency Alerts",
        ),
      ],
    ),
  );
  Widget ContactUsWidget = RichText(
    text: TextSpan(
      style: const TextStyle(
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
        const TextSpan(
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
        const TextSpan(
          text:
              "\nYou can reach us via email. We aim to respond to all inquiries within 24 hours.\n\nFor general inquiries, support, or feedback, email us at:",
        ),
        const TextSpan(
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
        const TextSpan(
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
      style: const TextStyle(
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
        const TextSpan(
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
        const TextSpan(
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
        const TextSpan(
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
        const TextSpan(
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
        const TextSpan(
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
        const TextSpan(
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
        const TextSpan(
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
        const TextSpan(
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
        margin: const EdgeInsets.all(20.0),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/images/Abdullah.jpg"),
              ),
              const SizedBox(height: 10),
              const Text(
                'Abdullah Iftikhar',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(
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
                onTap: () {
                  String url =
                      'mailto:abdullahiftikhar6445@gmail.com?subject=User From Diabetes CareTaker App';
                  launchUrl(Uri.parse(url));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.link,
                  color: Colors.black,
                ),
                title: Text(
                  'https://www.linkedin.com/in/abdullah-iftikhar-b12866290?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app',
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    decoration: TextDecoration.underline,
                    color: Colors.red.shade500,
                  ),
                ),
                onTap: () {
                  String url =
                      'https://www.linkedin.com/in/abdullah-iftikhar-b12866290?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app';
                  launchUrl(Uri.parse(url));
                },
              ),
            ],
          ),
        ),
      ),
      Card(
        elevation: 10,
        margin: const EdgeInsets.all(20.0),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/images/zeeshan.jpg"),
              ),
              // CircleAvatar(
              //     radius: 50, child: Image.asset("assets/images/zeeshan.jpg")),
              const SizedBox(height: 10),
              const Text(
                'Zeeshan Haider',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(
                  Icons.email,
                  color: Colors.black,
                ),
                title: Text(
                  'zh150785@gmail.com',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.red.shade500,
                  ),
                ),
                onTap: () {
                  String url =
                      'mailto:zh150785@gmail.com?subject=User From Diabetes CareTaker App';
                  launchUrl(Uri.parse(url));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.link,
                  color: Colors.black,
                ),
                title: Text(
                  'https://www.linkedin.com/in/muhammad-zeeshan-haider-1b610a283?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app',
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    decoration: TextDecoration.underline,
                    color: Colors.red.shade500,
                  ),
                ),
                onTap: () {
                  String url =
                      'https://www.linkedin.com/in/muhammad-zeeshan-haider-1b610a283?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app';
                  launchUrl(Uri.parse(url));
                },
              ),
            ],
          ),
        ),
      ),
    ],
  );
  Widget TermsAndPrivacyWidget = RichText(
    text: TextSpan(
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      children: [
        TextSpan(
          text: "Terms and Privacy Policy\n",
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.red.shade900,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        const TextSpan(
          text:
              "It is important to understand that the App is not a substitute for professional medical advice, diagnosis, or treatment.",
        ),
        TextSpan(
          text: "\n\n1) No Professional-Patient Relationship:",
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.red.shade900,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        const TextSpan(
          text:
              "\nUse of the App does not create a professional-patient relationship between you and the developers, staff, or any other party associated with the App. The information and features provided by the App are for informational and organizational purposes only.",
        ),
        TextSpan(
          text: "\n\n2) Information Accuracy:\n",
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.red.shade900,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        const TextSpan(
          text:
              "While we strive to provide accurate and up-to-date information, we cannot guarantee the accuracy, completeness, or reliability of any information provided by the App. Medical science is constantly evolving, and new research can affect the accuracy of health-related information. Therefore, the App's content should not be considered comprehensive or current.",
        ),

        /////////
        ///
        ///
        ///
        ///

        TextSpan(
          text: "\n\n3) Consult with Healthcare Providers:\n",
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.red.shade900,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        const TextSpan(
          text:
              "Primary Source of Care: Always consult your physician or other qualified health provider regarding any questions or concerns you have about your health or medical condition.\nEmergency Situations: In the event of a medical emergency, call your doctor or emergency services immediately.",
        ),

        TextSpan(
          text: "\n\n4)No Treatment:\n",
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.red.shade900,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        const TextSpan(
          text:
              "The App does not create or recommend treatment plans. Any treatment or medication adjustments should be made in consultation with your healthcare provider.",
        ),

        TextSpan(
          text: "\n\n5) Limitations of Use:\n",
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.red.shade900,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        const TextSpan(
          text:
              "Scope of Information: The health-related information provided by the App is limited to general knowledge and user-generated data. It is not a comprehensive source of medical advice or treatment.",
        ),
      ],
    ),
  );
}
