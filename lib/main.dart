import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expense_tracker/blocs/category_bloc/category_bloc.dart';
import 'package:flutter_expense_tracker/blocs/search_cubit/search_cubit.dart';
import 'package:flutter_expense_tracker/blocs/time_range_cubit/time_range_cubit.dart';
import 'package:flutter_expense_tracker/blocs/transaction_bloc/transactions_bloc.dart';
import 'package:flutter_expense_tracker/database/drift_database.dart';
import 'package:flutter_expense_tracker/pages/main_page.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

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
  // hydrated bloc settings stored in same path as drift db
  final docDir = await getApplicationDocumentsDirectory();
  final dbFolder = Directory(p.join(docDir.path, 'appdb'));
  await dbFolder.create(recursive: true);
  HydratedBloc.storage =
      await HydratedStorage.build(storageDirectory: dbFolder);
  //
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
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            darkTheme: ThemeData.dark(),
            home: const MainPage(),
          ),
        ),
      ),
    );
  }
}
