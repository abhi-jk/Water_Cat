import 'package:cwrdm/Authetication/RegistrationPage.dart';
import 'package:cwrdm/Authetication/SignInPage.dart';
import 'package:cwrdm/Authetication/admin.dart';
import 'package:cwrdm/firebase_options.dart';
import 'package:cwrdm/pages/FaqPage.dart';
import 'package:cwrdm/pages/about.dart';
import 'package:cwrdm/pages/admin.dart';
import 'package:cwrdm/pages/admin_alert.dart';
import 'package:cwrdm/pages/admin_bio.dart';
import 'package:cwrdm/pages/admin_floodlevel.dart';
import 'package:cwrdm/pages/admin_groundwater.dart';
import 'package:cwrdm/pages/admin_issues.dart';
import 'package:cwrdm/pages/admin_query.dart';
import 'package:cwrdm/pages/admin_rainfall.dart';
import 'package:cwrdm/pages/citizen_observation_portal.dart';
import 'package:cwrdm/pages/citizens_portal.dart';
import 'package:cwrdm/pages/city_info.dart';
import 'package:cwrdm/pages/client_alert.dart';
import 'package:cwrdm/pages/flood_level.dart';
import 'package:cwrdm/pages/ground_water_level.dart';
import 'package:cwrdm/pages/home.dart';
import 'package:cwrdm/pages/new_project.dart';
import 'package:cwrdm/pages/notesPage.dart';
import 'package:cwrdm/pages/projects_submitted.dart';
import 'package:cwrdm/pages/queryPage.dart';
import 'package:cwrdm/pages/rainfall.dart';
import 'package:cwrdm/pages/report_biodiversity.dart';
import 'package:cwrdm/pages/report_issue.dart';
import 'package:cwrdm/pages/result_table.dart';
import 'package:cwrdm/pages/submitted_projects.dart';
import 'package:cwrdm/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WATER CAT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontFamily: 'Montserrat'),
          // bodyText1: TextStyle(fontFamily: 'Montserrat'),
          // bodyText2: TextStyle(fontFamily: 'Montserrat'),
        ),
      ),
      routes: {
        '/floodlevel': (context) => const FloodLevel(),
        '/groundwaterlevel': (context) => const GroundWater(),
        '/rainfall': (context) => const Rainfall(),
        '/adminBio': (context) => AdminBioPage(),
        '/submittedProjects': (context) => SubmittedProjectsPage(),
        '/adminIssues': (context) => IssuesPage(),
        '/diversity': (context) => const ReportBiodiversityPage(),
        '/issues': (context) => const ReportIssuePage(),
        '/about': (context) => AboutPage(),
        '/projectsSubmitted': (context) => ProjectsSubmitted(),
        '/faq': (context) => FaqPage(),
        '/citizenObservation': (context) => CitizenObservationPortal(),
        '/project': (context) => const NewProjectPage(),
        '/notes': (context) => NotesPage(),
        '/queryPage': (context) => QueryPage(),
        '/citizen': (context) => CitizenPortalPage(),
        '/cityInfo': (context) => CityInfoPage(),
        '/signIn': (context) => const SignInPage(),
        '/admin': (context) => const AdminLogin(),
        '/register': (context) => const RegistrationPage(),
        '/home': (context) => const Home(),
        '/splash': (context) => SplashScreen(),
        '/adminPage': (context) => AdminPage(),
        '/adminQuery': (context) => AdminQueryPage(),
        '/adminfloodLevels': (context) => AdminFloodLevelPage(),
        '/admingroundwater': (context) => AdminGroundwaterPage(),
        '/adminfloodlevels': (context) => AdminFloodLevelPage(),
        '/adminrainfall': (context) => AdminRainfallPage(),
        '/adminalert': (context) => const AdminAlert(),
        '/clientalert': (context) => ViewAlert(),
        '/testRresult': (context) => TableWidget(),
      },
      initialRoute: '/splash',
    );
  }
}
