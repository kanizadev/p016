import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fortune Wheel',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6B8F71)),
        textTheme: GoogleFonts.baloo2TextTheme(),
        iconTheme: const IconThemeData(color: Color(0xFF6B8F71)),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF6B8F71), width: 2),
          ),
          labelStyle: const TextStyle(color: Color(0xFF2F3E34)),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF6B8F71),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ),
      home: const CreateWheelPage(),
    );
  }
}

class CreateWheelPage extends StatefulWidget {
  const CreateWheelPage({super.key});

  @override
  State<CreateWheelPage> createState() => _CreateWheelPageState();
}

class _CreateWheelPageState extends State<CreateWheelPage> {
  late List<TextEditingController> _controllers;

  Color _previewColorFor(int index) {
    final double hue = 110.0;
    final double saturation = 0.25 + 0.20 * ((index % 4) / 3.0);
    final double value = 0.55 + 0.25 * ((index % 6) / 5.0);
    return HSVColor.fromAHSV(
      1.0,
      hue,
      saturation.clamp(0.0, 1.0),
      value.clamp(0.0, 1.0),
    ).toColor();
  }

  Widget _buildSageButton({
    required String text,
    required VoidCallback? onTap,
  }) {
    final bool enabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 150),
        opacity: enabled ? 1.0 : 0.5,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xFF6B8F71), Color(0xFF8FB996)],
            ),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x556B8F71),
                blurRadius: 16,
                spreadRadius: 1,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controllers = <TextEditingController>[
      TextEditingController(text: 'item 1'),
      TextEditingController(text: 'item 2'),
      TextEditingController(text: 'item 3'),
      TextEditingController(text: 'item 4'),
    ];
  }

  @override
  void dispose() {
    for (final TextEditingController c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _addSlice() {
    setState(() {
      _controllers.add(
        TextEditingController(text: 'Item ${_controllers.length + 1}'),
      );
    });
  }

  void _removeSlice(int index) {
    if (_controllers.length <= 2) return;
    setState(() {
      _controllers.removeAt(index).dispose();
    });
  }

  void _start() {
    final List<String> values = _controllers
        .map((TextEditingController c) => c.text.trim())
        .where((String t) => t.isNotEmpty)
        .toList();
    if (values.length < 2) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => FortuneWheelPage(initialSegments: values),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.pets_outlined),
        title: const Text('Create Wheel'),
        centerTitle: true,
        elevation: 2,
        backgroundColor: const Color(0xFF6B8F71),
        foregroundColor: Colors.white,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
        actions: <Widget>[
          IconButton(
            tooltip: 'Add slice',
            icon: const Icon(Icons.add_circle_outline),
            onPressed: _addSlice,
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.3),
            radius: 1.1,
            colors: <Color>[
              Color(0xFFA3B18A),
              Color(0xFFCFE1B9),
              Color(0xFF6B8F71),
            ],
            stops: <double>[0.0, 0.6, 1.0],
          ),
        ),
        child: SafeArea(
          minimum: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Add slice texts',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () {
                    if (_controllers.isEmpty) return;
                    setState(() {
                      for (final TextEditingController c in _controllers) {
                        c.dispose();
                      }
                      _controllers = <TextEditingController>[];
                    });
                  },
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Color(0xFF6B8F71),
                  ),
                  label: const Text(
                    'Clear',
                    style: TextStyle(color: Color(0xFF6B8F71)),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ReorderableListView.builder(
                  itemCount: _controllers.length,
                  proxyDecorator:
                      (Widget child, int index, Animation<double> anim) {
                        return Material(
                          elevation: 6,
                          borderRadius: BorderRadius.circular(12),
                          child: child,
                        );
                      },
                  onReorder: (int oldIndex, int newIndex) {
                    setState(() {
                      if (newIndex > oldIndex) newIndex -= 1;
                      final TextEditingController moved = _controllers.removeAt(
                        oldIndex,
                      );
                      _controllers.insert(newIndex, moved);
                    });
                  },
                  itemBuilder: (BuildContext _, int i) {
                    return Padding(
                      key: ValueKey(_controllers[i]),
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: BackdropFilter(
                          filter: ui.ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                          child: Card(
                            elevation: 4,
                            color: const Color(0xE5FFFFFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: _previewColorFor(i),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    width: 34,
                                    height: 34,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF8FB996),
                                      shape: BoxShape.circle,
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          color: Color(0x338FB996),
                                          blurRadius: 8,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      '${i + 1}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextField(
                                      controller: _controllers[i],
                                      decoration: InputDecoration(
                                        labelText: 'Text',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF6B8F71),
                                            width: 2,
                                          ),
                                        ),
                                        isDense: true,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  IconButton(
                                    tooltip: 'Remove',
                                    icon: const Icon(
                                      Icons.remove_circle_outline,
                                    ),
                                    color: const Color(0xFF6B8F71),
                                    onPressed: () => _removeSlice(i),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              _buildSageButton(
                text: 'Start',
                onTap:
                    _controllers
                            .where(
                              (TextEditingController c) =>
                                  c.text.trim().isNotEmpty,
                            )
                            .length >=
                        2
                    ? _start
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FortuneWheelPage extends StatefulWidget {
  const FortuneWheelPage({super.key, this.initialSegments});

  final List<String>? initialSegments;

  @override
  State<FortuneWheelPage> createState() => _FortuneWheelPageState();
}

class _FortuneWheelPageState extends State<FortuneWheelPage> {
  late List<String> _segments;

  late final StreamController<int> _controller;
  final Random _random = Random();
  bool _isSpinning = false;
  int? _lastIndex;

  @override
  void initState() {
    super.initState();
    _controller = StreamController<int>();
    _segments =
        (widget.initialSegments == null || widget.initialSegments!.isEmpty)
        ? <String>['Grand Prize', 'Try Again', '10', '50']
        : List<String>.from(widget.initialSegments!);
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  void _spin() {
    if (_isSpinning) return;
    setState(() {
      _isSpinning = true;
    });
    HapticFeedback.selectionClick();
    final int next = _random.nextInt(_segments.length);
    _lastIndex = next;
    _controller.add(next);
  }

  void _onSpinEnd() {
    setState(() {
      _isSpinning = false;
    });
    if (_lastIndex != null) {
      HapticFeedback.heavyImpact();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You got: ${_segments[_lastIndex!]}')),
      );
    }
  }

  void _openEditor() {
    final List<TextEditingController> ctrls = _segments
        .map((String s) => TextEditingController(text: s))
        .toList();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 12,
            bottom: 12 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: StatefulBuilder(
            builder:
                (BuildContext context, void Function(void Function()) setS) {
                  void addSlice() {
                    setS(() {
                      ctrls.add(TextEditingController(text: 'New'));
                    });
                  }

                  void removeSlice(int index) {
                    if (ctrls.length <= 2) return; // keep at least 2 slices
                    setS(() {
                      ctrls.removeAt(index);
                    });
                  }

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            'Customize Wheel',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: <Widget>[
                              IconButton(
                                tooltip: 'Add slice',
                                onPressed: addSlice,
                                icon: const Icon(Icons.add_circle_outline),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Flexible(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: ctrls.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 8),
                          itemBuilder: (BuildContext _, int i) {
                            return Row(
                              children: <Widget>[
                                Expanded(
                                  child: TextField(
                                    controller: ctrls[i],
                                    decoration: const InputDecoration(
                                      labelText: 'Text',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                  tooltip: 'Remove',
                                  onPressed: () => removeSlice(i),
                                  icon: const Icon(Icons.remove_circle_outline),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          const SizedBox(width: 8),
                          FilledButton.icon(
                            onPressed: () {
                              final List<String> newValues = ctrls
                                  .map(
                                    (TextEditingController c) => c.text.trim(),
                                  )
                                  .where((String t) => t.isNotEmpty)
                                  .toList();
                              if (newValues.length < 2) {
                                // keep a minimal viable wheel
                                while (newValues.length < 2) {
                                  newValues.add('Item ${newValues.length + 1}');
                                }
                              }
                              setState(() {
                                _lastIndex = null;
                                _isSpinning = false;
                                _controller.addStream(Stream<int>.empty());
                                _segments
                                  ..clear()
                                  ..addAll(newValues);
                              });
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.check),
                            label: const Text('Save'),
                          ),
                        ],
                      ),
                    ],
                  );
                },
          ),
        );
      },
    );
  }

  Color _sliceColorFor(int index) {
    // Sage palette around hue ~110 (green with gray undertone)
    final double hue = 110.0;
    final double saturation = 0.25 + 0.20 * ((index % 4) / 3.0);
    final double value = 0.55 + 0.25 * ((index % 6) / 5.0);
    return HSVColor.fromAHSV(
      1.0,
      hue,
      saturation.clamp(0.0, 1.0),
      value.clamp(0.0, 1.0),
    ).toColor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.pets_outlined),
        title: const Text('Fortune Wheel'),
        backgroundColor: const Color(0xFF6B8F71),
        foregroundColor: Colors.white,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
        actions: <Widget>[
          IconButton(
            tooltip: 'Edit slices',
            onPressed: _isSpinning ? null : _openEditor,
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.3),
            radius: 1.1,
            colors: <Color>[
              Color(0xFFA3B18A), // sage
              Color(0xFFCFE1B9), // light matcha
              Color(0xFF6B8F71), // deep sage
            ],
            stops: <double>[0.0, 0.6, 1.0],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 12),
              const Text(
                'Try your luck',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 12),
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    width: 340,
                    height: 340,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: const Color(0x596B8F71),
                          blurRadius: 80,
                          spreadRadius: 8,
                        ),
                        BoxShadow(
                          color: const Color(0x4D94B49F),
                          blurRadius: 70,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  // Gradient rim just outside the wheel
                  Container(
                    width: 336,
                    height: 336,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: SweepGradient(
                        colors: <Color>[
                          Color(0xFF8FB996),
                          Color(0xFF6B8F71),
                          Color(0xFFA3B18A),
                          Color(0xFF8FB996),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 330,
                    height: 330,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0x59FFFFFF),
                        width: 2,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 320,
                    height: 320,
                    child: FortuneWheel(
                      selected: _controller.stream,
                      animateFirst: false,
                      onAnimationEnd: _onSpinEnd,
                      indicators: const <FortuneIndicator>[
                        FortuneIndicator(
                          alignment: Alignment.topCenter,
                          child: TriangleIndicator(color: Color(0xFF6B8F71)),
                        ),
                      ],
                      items: <FortuneItem>[
                        for (int i = 0; i < _segments.length; i++)
                          FortuneItem(
                            child: Text(
                              _segments[i],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.2,
                                shadows: <Shadow>[
                                  Shadow(
                                    color: Colors.black26,
                                    blurRadius: 2,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                            ),
                            style: FortuneItemStyle(
                              color: _sliceColorFor(i),
                              borderColor: Colors.white70,
                              borderWidth: 1.2,
                            ),
                          ),
                      ],
                    ),
                  ),
                  // Center badge behind the spin button
                  Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[Color(0xFF8FB996), Color(0xFF6B8F71)],
                      ),
                      border: Border.all(
                        color: const Color(0x80FFFFFF),
                        width: 2,
                      ),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Color(0x406B8F71),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                  IgnorePointer(
                    ignoring: _isSpinning,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: _isSpinning ? 0.6 : 1.0,
                      child: TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        tween: Tween<double>(
                          begin: 1.0,
                          end: _isSpinning ? 0.98 : 1.06,
                        ),
                        builder: (BuildContext _, double scale, Widget? child) {
                          return Transform.scale(scale: scale, child: child);
                        },
                        child: GestureDetector(
                          onTap: _spin,
                          child: Container(
                            width: 96,
                            height: 96,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: <Color>[
                                  Color(0xFF6B8F71),
                                  Color(0xFF8FB996),
                                ],
                              ),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Color(0xFF6B8F71),
                                  blurRadius: 24,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Text(
                              _isSpinning ? '...' : 'SPIN ✨',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (_lastIndex != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0x2EFFFFFF),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: const Color(0x59FFFFFF),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons.emoji_events_rounded,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Latest: ${_segments[_lastIndex!]}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          IconButton(
                            tooltip: 'Copy result',
                            icon: const Icon(Icons.copy, color: Colors.white),
                            onPressed: () async {
                              await Clipboard.setData(
                                ClipboardData(text: _segments[_lastIndex!]),
                              );
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Result copied')),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
