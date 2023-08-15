import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(const StopWatchApp());

class StopWatchApp extends StatelessWidget {
  const StopWatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stop Watch App',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: const StopWatchPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StopWatchPage extends StatefulWidget {
  const StopWatchPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StopWatchPageState createState() => _StopWatchPageState();
}

class _StopWatchPageState extends State<StopWatchPage> {
  bool _isRunning = false;
  bool _isHolding = false;
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {});
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _resetTimer() {
    _stopwatch.reset();
    setState(() {});
  }

  void _toggleHolding() {
    if (_isHolding) {
      _startTimer();
    } else {
      _stopTimer();
    }
    setState(() {
      _isHolding = !_isHolding;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stop Watch')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${_stopwatch.elapsed.inMinutes}:${(_stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0')}.${(_stopwatch.elapsed.inMilliseconds % 1000).toString().padLeft(3, '0')}',
              style: const TextStyle(fontSize: 48.0),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (!_isRunning) {
                      _stopwatch.start();
                      _startTimer();
                      setState(() {
                        _isRunning = true;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  child: const Text('Start', style: TextStyle(fontSize: 18)),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_isRunning) {
                      _stopwatch.stop();
                      _stopTimer();
                      setState(() {
                        _isRunning = false;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  child: const Text('Stop', style: TextStyle(fontSize: 18)),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    _toggleHolding();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isHolding ? Colors.orange : Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  child: Text(_isHolding ? 'Resume' : 'Hold',
                      style: const TextStyle(fontSize: 18)),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    _stopwatch.stop();
                    _stopTimer();
                    _resetTimer();
                    setState(() {
                      _isRunning = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  child: const Text('Restart', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
