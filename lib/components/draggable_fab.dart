import 'package:flutter/material.dart';
import 'package:namer_app/pages/settings_page.dart';
import 'package:namer_app/services/storage_service.dart';

class DraggableFab extends StatefulWidget {
  @override
  DraggableFabState createState() => DraggableFabState();
}

class DraggableFabState extends State<DraggableFab> {
  double _posX = 10;
  double _posY = 500;

  @override
  void initState() {
    super.initState();
    _loadPosition();
  }

  Future<void> _loadPosition() async {
    var position = await StorageService.loadFabPosition();
    setState(() {
      _posX = position[0];
      _posY = position[1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Positioned(
              left: _posX.clamp(0.0, constraints.maxWidth - 56),
              top: _posY.clamp(0.0, constraints.maxHeight - 56),
              child: Draggable(
                feedback: FloatingActionButton(
                  onPressed: _openSettings,
                  child: Icon(Icons.settings),
                ),
                childWhenDragging: SizedBox(),
                onDragEnd: (details) {
                  setState(() {
                    _posX = details.offset.dx.clamp(0.0, constraints.maxWidth - 56);
                    _posY = details.offset.dy.clamp(0.0, constraints.maxHeight - 56);
                  });
                  StorageService.saveFabPosition(_posX, _posY);
                },
                child: FloatingActionButton(
                  onPressed: _openSettings,
                  child: Icon(Icons.settings),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _openSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsPage()),
    );
  }
}
