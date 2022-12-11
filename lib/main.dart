// ignore_for_file: depend_on_referenced_packages

import 'package:catcher/catcher.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_search_app/config/api/api.dart';
import 'package:device_preview/device_preview.dart';
import 'package:my_search_app/module/presentation/ui/dashboard_page.dart';
import 'package:path_provider/path_provider.dart';
import 'config/router/router.gr.dart';
import 'core/bloc/auth/auth_bloc.dart' as auth_bloc;
import 'core/bloc/lang/lang_bloc.dart' as lang_bloc;

import 'config/injector/injector.dart';
import 'config/lang/lang.dart';
import 'core/bloc/bloc_observers.dart';
import 'core/util/connection_util.dart';
import 'core/util/dio_interceptors_util.dart';
import 'core/util/error_util.dart';
import 'core/util/global_util.dart';
import 'core/util/lang_util.dart';
import 'module/presentation/bloc/user/user_bloc.dart';
import 'module/presentation/cubit/city/city_cubit.dart';

Future<void> main() async {
  await mainApp();
}

Future<void> mainApp() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await configureInjector(Env.dev);

  final MySearchApi mySearchApi = getIt<MySearchApi>();
  debugPrint(mySearchApi.baseUrl());

  debugPrint = (String? message, {int? wrapWidth}) {};
  if (!kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) =>
        GlobalUtil.debugPrintSynchronouslyWithText(
          message,
          '',
          wrapWidth: wrapWidth,
        );
  }

  EquatableConfig.stringify = !kReleaseMode;
  Bloc.observer = BlocObservers(
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getTemporaryDirectory(),
    ),
  );

  final CatcherOptions debugOptions = CatcherOptions(
    SilentReportMode(),
    [
      ConsoleHandler(),
    ],
    customParameters: {
      "environment": mySearchApi.environment(),
      "mode": "debug"
    },
  );
  Catcher(
    rootWidget: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<lang_bloc.LangBloc>(),
        ),
        BlocProvider(
          create: (_) => getIt<UserBloc>()..add(const UserListFetchEv()),
        ),
        BlocProvider(
          create: (_) => getIt<CityCubit>(),
        ),
        BlocProvider(
          create: (_) =>
              getIt<auth_bloc.AuthBloc>()..add(const auth_bloc.AppStartedEv()),
        ),
      ],
      child: DevicePreview(
        enabled: false,
        builder: (context) => const App(),
      ),
    ),
    debugConfig: debugOptions,
  );
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late dynamic _connectionChangeStream;
  // final SharedPreferencesUtil _sharedPreferencesUtil =
  //     getIt<SharedPreferencesUtil>();
  final _appRouter = AppRouter();

  @override
  void initState() {
    super.initState();
    debugPrint('InitState: $runtimeType');

    // #Region Setup ConnectionUtil
    final ConnectionUtil _connectionUtil = getIt<ConnectionUtil>();
    _connectionUtil.initialize();
    _connectionChangeStream =
        _connectionUtil.connectionChange.listen(_connectionUtil.connectionInfo);
    // #Endregion

    // #Region Setup Dios
    final dio = getIt<Dio>();
    dio.interceptors.add(DioInterceptorsUtil(dio));
    // #Endregion
  }

  @override
  void dispose() {
    _connectionChangeStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Build: $runtimeType');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<lang_bloc.LangBloc, lang_bloc.LangState>(
        builder: (
          BuildContext context,
          lang_bloc.LangState lstate,
        ) {
          debugPrint('Locale: ${lstate.locale}');
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            builder: (_, child) => MaterialApp.router(
              routerDelegate: _appRouter.delegate(),
              routeInformationParser: _appRouter.defaultRouteParser(),
              //supportedLocales: const [Locale('id', 'ID'), Locale('en', 'US')],
              supportedLocales:
                  mySearchLang.entries.map((e) => e.value).toList(),
              localizationsDelegates: const [
                LangUtilDelegate(),
                FallbackCupertinoLocalisationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
              title: MySearchApi.appName,
              locale: lstate.locale,
              debugShowCheckedModeBanner: false,

              builder: (BuildContext context, Widget? widget) {
                ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
                  return ErrorUtil.widgetError(context, errorDetails);
                };

                return MediaQuery(
                  //Setting font does not change with system font size
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: widget!,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('Build: $runtimeType');

    return BlocBuilder<auth_bloc.AuthBloc, auth_bloc.AuthState>(
      builder: (BuildContext context, auth_bloc.AuthState state) {
        if (state is auth_bloc.AuthenticatedSt) {
          FlutterNativeSplash.remove();
          return const DashboardPage();
        }

        return const SizedBox();
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
