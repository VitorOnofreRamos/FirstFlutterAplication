// draggable_fab.dart
import 'package:flutter/material.dart';
import 'package:namer_app/pages/settings_page.dart';

class DraggableFab extends StatefulWidget {
  @override
  _DraggableFabState createState() => _DraggableFabState();
}

class _DraggableFabState extends State<DraggableFab> {
  double _posX = 10;
  double _posY = 500;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _posX,
      top: _posY,
      child: Draggable(
        feedback: FloatingActionButton(
          onPressed: _openSettings,
          child: Icon(Icons.settings),
        ),
        childWhenDragging: SizedBox(),
        onDragEnd: (details) {
          setState(() {
            _posX = details.offset.dx.clamp(0.0, MediaQuery.of(context).size.width - 56);
            _posY = details.offset.dy.clamp(0.0, MediaQuery.of(context).size.height - 56);
          });
        },
        child: FloatingActionButton(
          onPressed: _openSettings,
          child: Icon(Icons.settings),
        ),
      ),
    );
  }

  void _openSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsPage()),
    );
  }
}
