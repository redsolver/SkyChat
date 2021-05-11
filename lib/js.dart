@JS()
library callable_function;

import 'package:js/js.dart';

/// Allows assigning a function to be callable from `window.skychatClick()`
@JS('skychatClick')
external set skychatClickJS(void Function(String type, [String id]) f);
/* 
/// Allows calling the assigned function from Dart as well.
@JS()
external void skychatClick();
 */
