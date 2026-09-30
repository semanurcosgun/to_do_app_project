import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_todo_app/data/local_storage.dart';
import 'package:flutter_todo_app/models/task_model.dart';
import 'package:flutter_todo_app/pages/home_page.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerSingleton<LocalStorage>(
    HiveLocalStorage(),
  );
}

Future<void> setupHive() async {
  // 1. Hive başlatılır
  await Hive.initFlutter();

  // 2. TaskModel Hive'a tanıtılır
  Hive.registerAdapter(TaskModelAdapter());

  // 3. tasks box açılır
  await Hive.openBox<TaskModel>('tasks');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initializeDateFormatting('tr_TR', null);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  await setupHive();
  setup();
  runApp(
      EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('tr', 'TR')],
      path: 'assets/languages',  
      //bir çeviri bulamazsak ing yedek dil olarak kullanılacak
      fallbackLocale: Locale('en', 'US'),
      child: MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      home: const HomePage(),
    );
  }
}