import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart' as picker;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:remote_ui/remote_ui.dart';

class ColorPicker extends HookWidget {
  final Color value;
  final String id;
  final double colorPickerWidth;
  final bool displayThumbColor;
  final bool enableAlpha;
  final bool enableLabel;
  final double pickerAreaHeightPercent;
  final double buttonWidth;
  final double buttonHeight;
  final picker.PaletteType paletteType;

  ColorPicker({
    this.buttonWidth,
    this.buttonHeight,
    this.value,
    this.id,
    this.paletteType,
    this.displayThumbColor,
    this.enableAlpha,
    this.enableLabel,
    this.pickerAreaHeightPercent,
    this.colorPickerWidth,
  });

  @override
  Widget build(BuildContext context) {
    final valueState = useState(value);

    useEffect(() {
      valueState.value = value;
    }, [value]);

    return Center(
      child: Container(
        width: buttonWidth,
        height: buttonHeight,
        color: valueState.value,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              _showDialog(context, valueState);
            },
            child: Center(child: Container()),
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext mainContext, ValueNotifier<Color> valueState) {
    showDialog(
      context: mainContext,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: SingleChildScrollView(
            child: picker.ColorPicker(
              pickerColor: valueState.value,
              onColorChanged: (color) {
                valueState.value = color;
              },
              enableLabel: enableLabel,
              enableAlpha: enableAlpha,
              paletteType: paletteType,
              displayThumbColor: displayThumbColor,
              colorPickerWidth: colorPickerWidth,
              pickerAreaHeightPercent: pickerAreaHeightPercent,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('Got it'),
              onPressed: () {
                RemoteManagerWidget.of(mainContext).onChanges(id, valueState.value);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}