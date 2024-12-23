import 'package:ai_music/modules/account/bloc/account_bloc.dart';
import 'package:ai_music/routes/app_routes.dart';
import 'package:ai_music/themes/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/account/repositories/account_repository.dart';
import 'modules/explore/bloc/play_list_bloc.dart';
import 'modules/explore/repos/play_list_repo.dart';
import 'modules/home/bloc/home_page_bloc.dart';
import 'modules/music/bloc/music_page_bloc.dart';
import 'modules/music/bloc/music_page_repo.dart';
import 'routes/app_pages.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomePageBloc(),
        ),
        BlocProvider(
          create: (context) => AccountBloc(
            accountRepo: AccountRepository(),
            playListRepo: PlayListRepo(),
          ),
        ),
        BlocProvider(
          create: (context) => PlayListBloc(playListRepo: PlayListRepo()),
        ),
        BlocProvider(
          create: (context) => MusicPageBloc(MusicPageRepo(), PlayListRepo()),
        ),
      ],
      child: _buildMaterialApp(),
    );
  }

  MaterialApp _buildMaterialApp() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: defaultBgColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: defaultBgColor,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
            iconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          textTheme: const TextTheme(
            // 标题文字样式
            displayLarge: TextStyle(color: Colors.white),
            displayMedium: TextStyle(color: Colors.white),
            displaySmall: TextStyle(color: Colors.white),

            // 正文文字样式
            bodyLarge: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white),
            bodySmall: TextStyle(color: Colors.white),

            // 标题文字样式
            titleLarge: TextStyle(color: Colors.white),
            titleMedium: TextStyle(color: Colors.white),
            titleSmall: TextStyle(color: Colors.white),

            // 标签文字样式
            labelLarge: TextStyle(color: Colors.white),
            labelMedium: TextStyle(color: Colors.white),
            labelSmall: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white)),
      initialRoute: AppRoutes.home,
      routes: AppPages.routes,
      onUnknownRoute: (settings) => AppPages.unknownRoute,
    );
  }
}
