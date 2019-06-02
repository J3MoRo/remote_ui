import 'package:flutter/material.dart';
import 'package:remote_ui/remote_ui.dart';
import 'package:remote_ui/src/parsers/default_parser.dart';

class FlatButtonParser extends WidgetParser {
  Widget parse(BuildContext context, Map<String, dynamic> definition, Map<String, dynamic> data, RemoteWidgetFactory factory) {
    //TODO
    return FlatButton(
      onPressed: () {
        RemoteManagerWidget.of(context).onChanges(factory.getData(definition, data, 'id'), factory.getData(definition, data, 'value'));
      },
      child: factory.fromJson(context, definition['child'], data) ?? Text(factory.getData(definition, data, 'text', defaultValue: '')),
    );
  }
}