import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_bloc_api/blocs/theme_cubit.dart';
import 'package:users_bloc_api/theme.dart';
import 'screens/user_list_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeMode,
            home: UserListScreen(
              toggleTheme: () => context.read<ThemeCubit>().toggleTheme(),
              isDarkMode: themeMode == ThemeMode.dark,
            ),
          );
        },
      ),
    );
  }
}
