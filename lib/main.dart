import 'dart:io';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expense_tracker/blocs/category_bloc/category_bloc.dart';
import 'package:flutter_expense_tracker/blocs/search_cubit/search_cubit.dart';
import 'package:flutter_expense_tracker/blocs/time_range_cubit/time_range_cubit.dart';
import 'package:flutter_expense_tracker/blocs/transaction_bloc/transactions_bloc.dart';
import 'package:flutter_expense_tracker/database/drift_database.dart';
import 'package:flutter_expense_tracker/routes/app_routes.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) {
            return AppDatabase();
          },
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return TimeRangeCubit();
            },
          ),
          BlocProvider(
            create: (context) =>
                TransactionsBloc(appDatabase: context.read<AppDatabase>())
                  ..add(TransactionsLoadedEvent(
                      timeRangeState: context.read<TimeRangeCubit>().state)),
          ),
          BlocProvider(
            create: (context) =>
                CategoryBloc(appDatabase: context.read<AppDatabase>())
                  ..add(CategoryInitialEvent()),
          ),
          BlocProvider(
            create: (context) {
              return SearchCubit(appDatabase: context.read<AppDatabase>());
            },
          ),
        ],
        child: SafeArea(
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: FlexThemeData.dark(
              useMaterial3: false,
              scheme: FlexScheme.mandyRed,
              colorScheme: const ColorScheme.dark(primary: Colors.red),
              appBarBackground: (Colors.grey[850]),
              // dialogBackground: (Colors.grey[850]),
            ),
            // home: const HomePage(),
            routerConfig: goRouter,
          ),
        ),
      ),
    );
  }
}
