import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> _numbers = [];
  StreamController<List<int>> _streamController = StreamController();
  String _currentSortAlgo = 'bubble';
  double _sampleSize = 320;
  bool isSorted = false;
  bool isSorting = false;
  int speed = 0;
  static int duration = 1500;
  GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  String _getTitle() {
    switch (_currentSortAlgo) {
      case "bubble":
        return "Bubble Sort";
      case "coctail":
        return "Coctail Sort";
      case "pigeonhole":
        return "Pigeonhole Sort";
      case "recursivebubble":
        return "Recursive Bubble Sort";
      case "heap":
        return "Heap Sort";
      case "selection":
        return "Selection Sort";
      case "insertion":
        return "Insertion Sort";
      case "quick":
        return "Quick Sort";
      case "merge":
        return "Merge Sort";
      case "shell":
        return "Shell Sort";
      case "comb":
        return "Comb Sort";
      case "cycle":
        return "Cycle Sort";
      case "gnome":
        return "Gnome Sort";
      case "stooge":
        return "Stooge Sort";
      case "oddeven":
        return "Odd Even Sort";
      default:
        return "Bubble Sort";
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sampleSize = MediaQuery.of(context).size.width / 2;
    for (int i = 0; i < _sampleSize; ++i) {
      _numbers.add(Random().nextInt(500));
    }
    setState(() {});
  }

  void _setSortAlgo(String type) {
    setState(() {
      _reset();
      _currentSortAlgo = type;
    });
  }

  void _reset() {
    isSorted = false;
    _numbers = [];
    for (int i = 0; i < _sampleSize; ++i) {
      _numbers.add(Random().nextInt(500));
    }
    _streamController.add(_numbers);
  }

  _sort() async {
    setState(() {
      isSorting = true;
    });

    await _checkAndResetIfSorted();

    Stopwatch stopwatch = new Stopwatch()..start();

    switch (_currentSortAlgo) {
      case "comb":
        await _combSort();
        break;
      case "coctail":
        await _cocktailSort();
        break;
      case "bubble":
        await _bubbleSort();
        break;
      case "pigeonhole":
        await _pigeonHole();
        break;
      case "shell":
        await _shellSort();
        break;
      case "recursivebubble":
        await _recursiveBubbleSort(_sampleSize.toInt() - 1);
        break;
      case "selection":
        await _selectionSort();
        break;
      case "cycle":
        await _cycleSort();
        break;
      case "heap":
        await _heapSort();
        break;
      case "insertion":
        await _insertionSort();
        break;
      case "gnome":
        await _gnomeSort();
        break;
      case "oddeven":
        await _oddEvenSort();
        break;
      case "stooge":
        await _stoogesort(0, _sampleSize.toInt() - 1);
        break;
      case "quick":
        await _quickSort(0, _sampleSize.toInt() - 1);
        break;
      case "merge":
        await _mergeSort(0, _sampleSize.toInt() - 1);
        break;
    }

    stopwatch.stop();
    if (_scaffoldKey.currentState is ScaffoldMessengerState) {
      _scaffoldKey.currentState!.removeCurrentSnackBar();
    }

    if (_scaffoldKey.currentState is ScaffoldMessengerState) {
      _scaffoldKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(
            "Sorting completed in ${stopwatch.elapsed.inMilliseconds} ms.",
          ),
        ),
      );
    }
    setState(() {
      isSorting = false;
      isSorted = true;
    });
  }

  _bubbleSort() async {
    for (int i = 0; i < _numbers.length; ++i) {
      for (int j = 0; j < _numbers.length - i - 1; ++j) {
        if (!isSorting) break;
        if (_numbers[j] > _numbers[j + 1]) {
          int temp = _numbers[j];
          _numbers[j] = _numbers[j + 1];
          _numbers[j + 1] = temp;
        }

        await Future.delayed(_getDuration(), () {});

        _streamController.add(_numbers);
      }
    }
  }

  _recursiveBubbleSort(int n) async {
    if (n == 1) {
      return;
    }
    for (int i = 0; i < n - 1; i++) {
      if (!isSorting) break;
      if (_numbers[i] > _numbers[i + 1]) {
        int temp = _numbers[i];
        _numbers[i] = _numbers[i + 1];
        _numbers[i + 1] = temp;
      }
      await Future.delayed(_getDuration());
      _streamController.add(_numbers);
    }
    await _recursiveBubbleSort(n - 1);
  }

  _selectionSort() async {
    for (int i = 0; i < _numbers.length; i++) {
      for (int j = i + 1; j < _numbers.length; j++) {
        if (!isSorting) break;
        if (_numbers[i] > _numbers[j]) {
          int temp = _numbers[j];
          _numbers[j] = _numbers[i];
          _numbers[i] = temp;
        }
        print("$i ${_numbers.length}");

        await Future.delayed(_getDuration(), () {});

        _streamController.add(_numbers);
      }
    }
  }

  _heapSort() async {
    for (int i = _numbers.length ~/ 2; i >= 0; i--) {
      if (!isSorting) break;
      await heapify(_numbers, _numbers.length, i);
      _streamController.add(_numbers);
    }
    for (int i = _numbers.length - 1; i >= 0; i--) {
      if (!isSorting) break;
      int temp = _numbers[0];
      _numbers[0] = _numbers[i];
      _numbers[i] = temp;
      await heapify(_numbers, i, 0);
      _streamController.add(_numbers);
    }
  }

  heapify(List<int> arr, int n, int i) async {
    int largest = i;
    int l = 2 * i + 1;
    int r = 2 * i + 2;

    if (l < n && arr[l] > arr[largest]) largest = l;

    if (r < n && arr[r] > arr[largest]) largest = r;

    if (largest != i) {
      int temp = _numbers[i];
      _numbers[i] = _numbers[largest];
      _numbers[largest] = temp;
      heapify(arr, n, largest);
    }
    await Future.delayed(_getDuration());
  }

  _insertionSort() async {
    for (int i = 1; i < _numbers.length; i++) {
      if (!isSorting) break;
      int temp = _numbers[i];
      int j = i - 1;
      while (j >= 0 && temp < _numbers[j]) {
        _numbers[j + 1] = _numbers[j];
        --j;
        await Future.delayed(_getDuration(), () {});

        _streamController.add(_numbers);
      }
      _numbers[j + 1] = temp;
      await Future.delayed(_getDuration(), () {});

      _streamController.add(_numbers);
    }
  }

  cf(int a, int b) {
    if (a < b) {
      return -1;
    } else if (a > b) {
      return 1;
    } else {
      return 0;
    }
  }

  _quickSort(int leftIndex, int rightIndex) async {
    if (!isSorting) return;
    Future<int> _partition(int left, int right) async {
      int p = (left + (right - left) / 2).toInt();

      var temp = _numbers[p];
      _numbers[p] = _numbers[right];
      _numbers[right] = temp;
      await Future.delayed(_getDuration(), () {});

      _streamController.add(_numbers);

      int cursor = left;

      for (int i = left; i < right; i++) {
        if (cf(_numbers[i], _numbers[right]) <= 0 && isSorting) {
          var temp = _numbers[i];
          _numbers[i] = _numbers[cursor];
          _numbers[cursor] = temp;
          cursor++;

          await Future.delayed(_getDuration(), () {});

          _streamController.add(_numbers);
        }
      }

      temp = _numbers[right];
      _numbers[right] = _numbers[cursor];
      _numbers[cursor] = temp;

      await Future.delayed(_getDuration(), () {});

      _streamController.add(_numbers);

      return cursor;
    }

    if (leftIndex < rightIndex) {
      int p = await _partition(leftIndex, rightIndex);

      await _quickSort(leftIndex, p - 1);

      await _quickSort(p + 1, rightIndex);
    }
  }

  _mergeSort(int leftIndex, int rightIndex) async {
    if (!isSorting) return;
    Future<void> merge(int leftIndex, int middleIndex, int rightIndex) async {
      int leftSize = middleIndex - leftIndex + 1;
      int rightSize = rightIndex - middleIndex;

      List leftList = List.filled(leftSize, 0, growable: false);
      List rightList = List.filled(rightSize, 0, growable: false);

      for (int i = 0; i < leftSize; i++) leftList[i] = _numbers[leftIndex + i];
      for (int j = 0; j < rightSize; j++)
        rightList[j] = _numbers[middleIndex + j + 1];

      int i = 0, j = 0;
      int k = leftIndex;

      while (i < leftSize && j < rightSize && isSorting) {
        if (leftList[i] <= rightList[j]) {
          _numbers[k] = leftList[i];
          i++;
        } else {
          _numbers[k] = rightList[j];
          j++;
        }

        await Future.delayed(_getDuration(), () {});
        _streamController.add(_numbers);

        k++;
      }

      while (i < leftSize) {
        _numbers[k] = leftList[i];
        i++;
        k++;

        await Future.delayed(_getDuration(), () {});
        _streamController.add(_numbers);
      }

      while (j < rightSize) {
        _numbers[k] = rightList[j];
        j++;
        k++;

        await Future.delayed(_getDuration(), () {});
        _streamController.add(_numbers);
      }
    }

    if (leftIndex < rightIndex) {
      int middleIndex = (rightIndex + leftIndex) ~/ 2;

      await _mergeSort(leftIndex, middleIndex);
      await _mergeSort(middleIndex + 1, rightIndex);

      await Future.delayed(_getDuration(), () {});

      _streamController.add(_numbers);

      await merge(leftIndex, middleIndex, rightIndex);
    }
  }

  _shellSort() async {
    for (int gap = _numbers.length ~/ 2; gap > 0; gap ~/= 2) {
      for (int i = gap; i < _numbers.length; i += 1) {
        int temp = _numbers[i];
        int j;
        for (j = i; j >= gap && _numbers[j - gap] > temp; j -= gap) {
          if (!isSorting) break;
          _numbers[j] = _numbers[j - gap];
        }
        _numbers[j] = temp;
        await Future.delayed(_getDuration());
        _streamController.add(_numbers);
      }
    }
  }

  int getNextGap(int gap) {
    gap = (gap * 10) ~/ 13;

    if (gap < 1) return 1;
    return gap;
  }

  _combSort() async {
    int gap = _numbers.length;

    bool swapped = true;

    while (gap != 1 || swapped == true) {
      gap = getNextGap(gap);

      swapped = false;

      for (int i = 0; i < _numbers.length - gap; i++) {
        if (!isSorting) break;
        if (_numbers[i] > _numbers[i + gap]) {
          int temp = _numbers[i];
          _numbers[i] = _numbers[i + gap];
          _numbers[i + gap] = temp;
          swapped = true;
        }
        await Future.delayed(_getDuration());
        _streamController.add(_numbers);
      }
    }
  }

  _pigeonHole() async {
    int min = _numbers[0];
    int max = _numbers[0];
    int range, i, j, index;
    for (int a = 0; a < _numbers.length; a++) {
      if (_numbers[a] > max) max = _numbers[a];
      if (_numbers[a] < min) min = _numbers[a];
    }
    range = max - min + 1;
    List<int> phole = new List.generate(range, (i) => 0);

    for (i = 0; i < _numbers.length; i++) {
      phole[_numbers[i] - min]++;
    }

    index = 0;

    for (j = 0; j < range; j++) {
      while (phole[j]-- > 0 && isSorting) {
        _numbers[index++] = j + min;
        await Future.delayed(_getDuration());
        _streamController.add(_numbers);
      }
    }
  }

  _cycleSort() async {
    int writes = 0;
    for (int cycleStart = 0; cycleStart <= _numbers.length - 2; cycleStart++) {
      int item = _numbers[cycleStart];
      int pos = cycleStart;
      for (int i = cycleStart + 1; i < _numbers.length; i++) {
        if (_numbers[i] < item) pos++;
      }

      if (pos == cycleStart) {
        continue;
      }

      while (item == _numbers[pos]) {
        pos += 1;
      }

      if (pos != cycleStart) {
        int temp = item;
        item = _numbers[pos];
        _numbers[pos] = temp;
        writes++;
      }

      while (pos != cycleStart && isSorting) {
        pos = cycleStart;
        for (int i = cycleStart + 1; i < _numbers.length; i++) {
          if (_numbers[i] < item) pos += 1;
        }

        while (item == _numbers[pos]) {
          pos += 1;
        }

        if (item != _numbers[pos]) {
          int temp = item;
          item = _numbers[pos];
          _numbers[pos] = temp;
          writes++;
        }
        await Future.delayed(_getDuration());
        _streamController.add(_numbers);
      }
    }
  }

  _cocktailSort() async {
    bool swapped = true;
    int start = 0;
    int end = _numbers.length;

    while (swapped == true) {
      swapped = false;
      for (int i = start; i < end - 1; ++i) {
        if (!isSorting) break;
        if (_numbers[i] > _numbers[i + 1]) {
          int temp = _numbers[i];
          _numbers[i] = _numbers[i + 1];
          _numbers[i + 1] = temp;
          swapped = true;
        }
        await Future.delayed(_getDuration());
        _streamController.add(_numbers);
      }
      if (swapped == false) break;
      swapped = false;
      end = end - 1;
      for (int i = end - 1; i >= start; i--) {
        if (!isSorting) break;
        if (_numbers[i] > _numbers[i + 1]) {
          int temp = _numbers[i];
          _numbers[i] = _numbers[i + 1];
          _numbers[i + 1] = temp;
          swapped = true;
        }
        await Future.delayed(_getDuration());
        _streamController.add(_numbers);
      }
      start = start + 1;
    }
  }

  _gnomeSort() async {
    int index = 0;

    while (index < _numbers.length && isSorting) {
      if (index == 0) index++;
      if (_numbers[index] >= _numbers[index - 1])
        index++;
      else {
        int temp = _numbers[index];
        _numbers[index] = _numbers[index - 1];
        _numbers[index - 1] = temp;

        index--;
      }
      await Future.delayed(_getDuration());
      _streamController.add(_numbers);
    }
    return;
  }

  _stoogesort(int l, int h) async {
    if (l >= h || !isSorting) return;

    if (_numbers[l] > _numbers[h]) {
      int temp = _numbers[l];
      _numbers[l] = _numbers[h];
      _numbers[h] = temp;
      await Future.delayed(_getDuration());
      _streamController.add(_numbers);
    }

    if (h - l + 1 > 2) {
      int t = (h - l + 1) ~/ 3;
      await _stoogesort(l, h - t);
      await _stoogesort(l + t, h);
      await _stoogesort(l, h - t);
    }
  }

  _oddEvenSort() async {
    bool isSorted = false;

    while (!isSorted || !isSorting) {
      isSorted = true;

      for (int i = 1; i <= _numbers.length - 2; i = i + 2) {
        if (_numbers[i] > _numbers[i + 1]) {
          int temp = _numbers[i];
          _numbers[i] = _numbers[i + 1];
          _numbers[i + 1] = temp;
          isSorted = false;
          await Future.delayed(_getDuration());
          _streamController.add(_numbers);
        }
      }

      for (int i = 0; i <= _numbers.length - 2; i = i + 2) {
        if (_numbers[i] > _numbers[i + 1]) {
          int temp = _numbers[i];
          _numbers[i] = _numbers[i + 1];
          _numbers[i + 1] = temp;
          isSorted = false;
          await Future.delayed(_getDuration());
          _streamController.add(_numbers);
        }
      }
    }

    return;
  }

  Duration _getDuration() {
    return Duration(microseconds: duration);
  }

  _checkAndResetIfSorted() async {
    if (isSorted) {
      _reset();
      await Future.delayed(Duration(milliseconds: 200));
    }
  }

  _changeSpeed() {
    if (speed >= 3) {
      speed = 0;
      duration = 1500;
    } else {
      speed++;
      duration = duration ~/ 2;
    }

    print(speed.toString() + " " + duration.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle()),
        actions: <Widget>[
          PopupMenuButton<String>(
            initialValue: _currentSortAlgo,
            icon: Icon(Icons.list),
            itemBuilder: (ctx) {
              return [
                PopupMenuItem(
                  value: 'bubble',
                  child: Text("Bubble Sort"),
                ),
                PopupMenuItem(
                  value: 'recursivebubble',
                  child: Text("Recursive Bubble Sort"),
                ),
                PopupMenuItem(
                  value: 'heap',
                  child: Text("Heap Sort"),
                ),
                PopupMenuItem(
                  value: 'selection',
                  child: Text("Selection Sort"),
                ),
                PopupMenuItem(
                  value: 'insertion',
                  child: Text("Insertion Sort"),
                ),
                PopupMenuItem(
                  value: 'quick',
                  child: Text("Quick Sort"),
                ),
                PopupMenuItem(
                  value: 'merge',
                  child: Text("Merge Sort"),
                ),
                PopupMenuItem(
                  value: 'shell',
                  child: Text("Shell Sort"),
                ),
                PopupMenuItem(
                  value: 'comb',
                  child: Text("Comb Sort"),
                ),
                PopupMenuItem(
                  value: 'pigeonhole',
                  child: Text("Pigeonhole Sort"),
                ),
                PopupMenuItem(
                  value: 'cycle',
                  child: Text("Cycle Sort"),
                ),
                PopupMenuItem(
                  value: 'coctail',
                  child: Text("Coctail Sort"),
                ),
                PopupMenuItem(
                  value: 'gnome',
                  child: Text("Gnome Sort"),
                ),
                PopupMenuItem(
                  value: 'stooge',
                  child: Text("Stooge Sort"),
                ),
                PopupMenuItem(
                  value: 'oddeven',
                  child: Text("Odd Even Sort"),
                ),
              ];
            },
            onSelected: (String value) {
              _setSortAlgo(value);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 0.0),
          child: StreamBuilder<List<int>>(
              initialData: _numbers,
              stream: _streamController.stream,
              builder: (context, snapshot) {
                List<int>? numbers = snapshot.data;
                int counter = 0;

                return Row(
                  children: numbers!.map((int num) {
                    counter++;
                    return Container(
                      child: CustomPaint(
                        painter: BarPainter(
                            index: counter,
                            value: num,
                            width: MediaQuery.of(context).size.width /
                                _sampleSize),
                      ),
                    );
                  }).toList(),
                );
              }),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            Expanded(
                child: ElevatedButton(
                    onPressed: isSorting
                        ? null
                        : () {
                            _reset();
                            _setSortAlgo(_currentSortAlgo);
                          },
                    child: Text("RESET"))),
            Expanded(
                child: ElevatedButton(
                    onPressed: isSorting ? null : _sort, child: Text("SORT"))),
            Expanded(
                child: ElevatedButton(
                    onPressed: isSorting
                        ? () {
                            setState(() {
                              isSorting = false;
                            });
                          }
                        : null,
                    child: Text("STOP"))),
            Expanded(
                child: ElevatedButton(
                    onPressed: isSorting ? null : _changeSpeed,
                    child: Text(
                      "${speed + 1}x",
                      style: TextStyle(fontSize: 20),
                    ))),
          ],
        ),
      ),
    );
  }
}

class BarPainter extends CustomPainter {
  final width;
  final value;
  final index;

  BarPainter({this.width, this.value, this.index});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    if (this.value < 500 * .10) {
      paint.color = Color(0xFFDEEDCF);
    } else if (this.value < 500 * .20) {
      paint.color = Color(0xFFBFE1B0);
    } else if (this.value < 500 * .30) {
      paint.color = Color(0xFF99D492);
    } else if (this.value < 500 * .40) {
      paint.color = Color(0xFF74C67A);
    } else if (this.value < 500 * .50) {
      paint.color = Color(0xFF56B870);
    } else if (this.value < 500 * .60) {
      paint.color = Color(0xFF39A96B);
    } else if (this.value < 500 * .70) {
      paint.color = Color(0xFF1D9A6C);
    } else if (this.value < 500 * .80) {
      paint.color = Color(0xFF188977);
    } else if (this.value < 500 * .90) {
      paint.color = Color(0xFF137177);
    } else {
      paint.color = Color(0xFF0E4D64);
    }

    paint.strokeWidth = width;
    paint.strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(index * this.width, 0),
        Offset(index * this.width, this.value.ceilToDouble()), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
