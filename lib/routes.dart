library routes;

import 'package:flutter/material.dart';
import 'package:shop/screens/category/screen.dart';

Map<String, WidgetBuilder> getRoutes(context) => ({
    '/category/' : (context) {
      // final args = ModalRoute.of(context).settings.arguments;
      return new ScreenCategory(id: 0);
    }
});
