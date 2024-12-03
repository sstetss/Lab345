import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Magic Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Magic Counter'),
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
  String _message = 'Enter magic words!';
  final TextEditingController _controller = TextEditingController();

  void _processInput(String input) {
    setState(() {
      if (input.toLowerCase() == 'wingardium leviosa') {
        _message = '✨ Counter floats up by 10! ✨';
        _counter += 10;
      } else if (input.toLowerCase() == 'accio gold') {
        _message = '💰 You summoned 100 points! 💰';
        _counter += 100;
      } else if (input.toLowerCase() == 'expelliarmus') {
        _message = '🛡 Counter reduced by 20! 🛡';
        _counter -= 20;
        if (_counter < 0) _counter = 0;
      } else if (input.toLowerCase() == 'finite incantatem') {
        _message = '🔄 All magic effects are reset! 🔄';
        _counter = 0;
      } else {
        final parsedValue = int.tryParse(input);
        if (parsedValue != null) {
          _message = 'You added $parsedValue to the counter!';
          _counter += parsedValue;
        } else {
          _message = '❌ Invalid input: no magic detected! ❌';
        }
      }

      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Counter: $_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Text(
              _message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, color: Colors.deepPurple),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Enter magic words or numbers',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: _processInput,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _processInput(_controller.text),
              child: const Text('Cast Magic!'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _counter++;
            _message = 'Counter incremented!';
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
