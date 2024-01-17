import 'package:backend_training/cubits/login_cubit/login_cubit.dart';
import 'package:backend_training/cubits/setting_cubit/setting_cubit.dart';
import 'package:backend_training/cubits/signup_cubit/signup_cubit.dart';
import 'package:backend_training/models/user_model.dart';
import 'package:backend_training/services/dio_helper.dart';
import 'package:backend_training/views/add_note_view.dart';
import 'package:backend_training/views/home_view.dart';
import 'package:backend_training/views/login_view.dart';
import 'package:backend_training/views/settings_view.dart';
import 'package:backend_training/views/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

Box? myBox;
Future<Box> openHiveBox(String boxname) async {
  if (!Hive.isBoxOpen(boxname)) {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }
  return await Hive.openBox(boxname);
}

void main() async {
  print(' Im secnod branch');
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // Register the adapter for UserModel
  Hive.registerAdapter(UserModelAdapter());
  DioHelper.init();
  myBox = await openHiveBox('myBox');
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignUpCubit(),
        ),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => SettingCubit()),

        // Add more BlocProviders here if needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          SignUpView.SignUpViewId: (context) => const SignUpView(),
          HomeView.HomeViewId: (context) => HomeView(),
          SettingView.SettingViewId: (context) => SettingView(),
          LoginView.LoginViewId: (context) => LoginView(),
          AddNoteScreen.AddNoteScreenId: (context) => AddNoteScreen(),
        },
        title: 'Flutter Demo',
        home: myBox?.get('id') == null ? LoginView() : HomeView(),
      ),
    );
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('onEvent -- ${bloc.runtimeType}, $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('onTransition -- ${bloc.runtimeType}, $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}
