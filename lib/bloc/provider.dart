import 'package:flutter/material.dart';
import 'bloc.dart';


class BLoCProvider extends InheritedWidget{
  final BLoC bloc = BLoC();

  BLoCProvider({Key key, Widget child}):super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static BLoC of(BuildContext context) => (context.inheritFromWidgetOfExactType(BLoCProvider) as BLoCProvider).bloc;
}