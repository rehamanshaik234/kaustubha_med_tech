import 'package:flutter/material.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class RouteAwareWidget extends StatefulWidget {
  final Widget child;
  final String routeName;
  final Function(String?) onPop;

  RouteAwareWidget({super.key, required this.child, required this.routeName, required this.onPop});

  @override
  _RouteAwareWidgetState createState() => _RouteAwareWidgetState();
}

class _RouteAwareWidgetState extends State<RouteAwareWidget> with RouteAware {


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onPop(widget.routeName);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose(){
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPushNext() {
    widget.onPop(widget.routeName);
    // TODO: implement didPushNext
    super.didPushNext();
  }

  @override
  void didPopNext() {
    widget.onPop(widget.routeName);
    // TODO: implement didPopNext
    super.didPopNext();
  }



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
