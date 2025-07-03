
import '../../export.dart';

int defaultItemCount = 10;

var preLoginNestedId = 1;
var postLoginNestedId = 2;

// var log = Logger();
// GetStorage storage = GetStorage();

final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerState =
    GlobalKey<ScaffoldMessengerState>();

cardDecoration({Color? bgColor}) => BoxDecoration(
    color: bgColor ?? Colors.white,
    boxShadow: const [
      BoxShadow(color: Colors.black12, blurRadius: 2, spreadRadius: 2)
    ],
    borderRadius: BorderRadius.circular(20));
