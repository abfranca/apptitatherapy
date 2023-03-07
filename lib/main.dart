import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MyAppState(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'TiTa Therapy',
            home: const HomeScreen()));
  }
}

/**
 * Variáveis para "troca de informação" entre as telas.
 */
class MyAppState extends ChangeNotifier {
  var title = '';
  var color = Colors.white;

  void changeColor(String newTitle, Color newColor) {
    title = newTitle;
    color = newColor;
    notifyListeners();
  }
}

/**
 * Página principal da aplicação.
 */
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TiTa Therapy',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.purple[100],
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  appState.changeColor('Azul', Colors.blue);
                  Navigator.of(context).push(_createRoute());
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  'Azul',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  appState.changeColor('Vermelho', Colors.red);
                  Navigator.of(context).push(_createRoute());
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.red,
                ),
                child: const Text(
                  'Vermelho',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  appState.changeColor('Amarelo', Colors.yellow);
                  Navigator.of(context).push(_createRoute());
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.yellow,
                ),
                child: const Text(
                  'Amarelo',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  appState.changeColor('Verde', Colors.green);
                  Navigator.of(context).push(_createRoute());
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.green,
                ),
                child: const Text(
                  'Verde',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/**
 * Página de exibição da cor escolhida.
 */
class ColorScreen extends StatelessWidget {
  const ColorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return WillPopScope(
        onWillPop: () async {
          bool willLeave = false;
          await showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: const Text('Voltar para tela inicial?'),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            willLeave = true;
                            Navigator.of(context).pop();
                          },
                          child: const Text('Sim')),
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Não'))
                    ],
                  ));
          return willLeave;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              appState.title,
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.purple[100],
            centerTitle: true,
          ),
          backgroundColor: appState.color,
          body: const Center(
            child: Image(
              width: 300,
              height: 300,
              image: NetworkImage(
                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
            ),
          ),
        ));
  }
}

/**
 * Método responsavel pela animação de transição entre telas.
 */
Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const ColorScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
