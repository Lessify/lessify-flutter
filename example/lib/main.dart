import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lessify_flutter/lessify_flutter.dart';

void main() {
  runApp(LessifyApp(
    fallbackLocale: const Locale('en'),
    supportedLocales: [const Locale('en'), const Locale('de')],
    loader: LessifyTranslationLoader(
        spaceId: '1647c6a0-ec21-11ea-a414-9ff19f1910a1',
        environment: 'master',
        apiKey: 'api-key-fhMwD-b4915cd0-ec22-11ea-a414-9ff19f1910a1-wzd4E'),
    //loader: BundleAssetTranslationLoader(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: LessifyApp.of(context).currentLocaleStream$,
        builder: (BuildContext context, AsyncSnapshot<Locale> snapshot) {
          return MaterialApp(
            locale: snapshot.data,
            title: 'Flutter Demo',
            localizationsDelegates: [
              LessifyApp.of(context).delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: LessifyApp.of(context).supportedLocales,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: MyHomePage(title: 'Flutter Demo Home Page'),
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  String _getLanguageCode(BuildContext context) {
    return Localizations.localeOf(context).languageCode;
  }

  @override
  Widget build(BuildContext context) {
    String currentLanguageCode = _getLanguageCode(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  onPressed: () =>
                      LessifyApp.of(context).changeLocale(Locale('en')),
                  color: currentLanguageCode == 'en'
                      ? Theme.of(context).accentColor
                      : null,
                  child: Text('English'),
                ),
                const SizedBox(width: 30),
                RaisedButton(
                  onPressed: () =>
                      LessifyApp.of(context).changeLocale(Locale('de')),
                  color: currentLanguageCode == 'de'
                      ? Theme.of(context).accentColor
                      : null,
                  child: Text('German'),
                ),
              ],
            ),
            Text(translate('login.email')),
            Text(translatePlural('login.emails', Plural.few)),
            // Translate key
            Text(translate('welcome', namedArgs: {'user': 'Alex'})),
            // Translate key with named args
            Text('Current Locale : ' + _getLanguageCode(context)),
            Text(
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
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
