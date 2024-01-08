import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_course_selection_demo/view/lecturer_management_page.dart';
import 'package:student_course_selection_demo/view_model/course_detail_provider.dart';
import 'package:student_course_selection_demo/view_model/edit_dialog_provider.dart';
import 'package:student_course_selection_demo/view_model/lecturer_provider.dart';
import 'package:student_course_selection_demo/view_model/service_provider.dart';
import 'utilities.dart';
import 'view/course_detail.dart';
import 'view/course_management_page.dart';
import 'view/lecturer_list.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ServiceProvider>(
        create: (context) {
          ServiceProvider serviceProvider = ServiceProvider()..getServiceData();
          return serviceProvider;
        },
      ),
      ChangeNotifierProvider<LecturerProvider>(
          create: (context) => LecturerProvider()),
      ChangeNotifierProvider<CourseDetailProvider>(
          create: (context) => CourseDetailProvider()),
      ChangeNotifierProvider<EditDialogProvider>(
          create: (context) => EditDialogProvider()),
    ],
    child: const MainPage(),
  ));
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student course selection',
      theme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.deepPurple,
        ),
      ),
      onGenerateRoute: (settings) {
        late Widget page;
        if (settings.name == routeHome) {
          page = const MainView();
        } else if (settings.name == lecturerList) {
          page = const LecturerListPage();
        } else if (settings.name == courseDetail) {
          page = const CourseDetailPage();
        } else if (settings.name == lecturerManagement) {
          page = const LecturerManagementPage();
        } else if (settings.name == courseManagement) {
          page = const CourseManagementPage();
        } else {
          throw Exception('Unknown route: ${settings.name}');
        }
        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return page;
          },
          settings: settings,
        );
      },
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Center(child: Consumer<ServiceProvider>(
        builder: (context, value, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(lecturerList);
                },
                child: const Text('講師清單'),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(lecturerManagement);
                },
                child: const Text('講師管理'),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(courseManagement);
                },
                child: const Text('課程管理'),
              ),
            ],
          );
        },
      )),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Student course selection system'),
    );
  }
}
