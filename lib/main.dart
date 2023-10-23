import 'package:flutter/material.dart';

bool nombrePremier(int number) { //fonction verif nbPremier
  if (number <= 1) {
    return false;
  }

  for (int i = 2; i * i <= number; i++) {
    if (number % i == 0) {
      return false;
    }
  }

  return true;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 1;
  List<int> listFruit = []; // la liste de fruit

  String typeDeNombre(int valeurFruit) { //determine si nb premier, pair ou impaire
    if (nombrePremier(valeurFruit)) {
      return 'nombre premier';
    } else if (valeurFruit.isEven) {
      return 'pair';
    } else {
      return 'impair';
    }
  }

  void _incrementCounter() {
    setState(() {
      listFruit // pour incrémenter la longueur de la liste en fonction du counter
          .add(_counter);
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final valeurDuTitre = typeDeNombre(_counter);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
            '$_counter - $valeurDuTitre',
            style: const TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount: listFruit // le nombre d'items en fonction de la longueur de la liste
            .length,
        itemBuilder: (BuildContext context, int index) {
          final valeurFruit = listFruit[index];
          final siPair = valeurFruit.isEven;

          final premierPairImpair = nombrePremier(valeurFruit);

          final backgroundColor = siPair ? Colors.indigo : Colors.cyan; // bgc en fonction  de pair ou impair

          final imageVerif = premierPairImpair // img affiché en fonction du type de nb
              ? Image.asset(
                  'images/ananas.png',
                  width: 40,
                  height: 40, 
                )
              : siPair
                  ? Image.asset(
                      'images/poire.png',
                      width: 40,
                      height: 40, 
                    )
                  : Image.asset(
                      'images/pomme.png',
                      width: 40,
                      height: 40, 
                    );

          return ListTile(
            tileColor:
                backgroundColor,
            title: Row(
              children: [
                const SizedBox(
                    width: 16),
                imageVerif,
                Text(
                  'Fruit $valeurFruit',
                  style: const TextStyle(
                      color: Colors.white),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
