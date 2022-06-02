// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Nice...

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:digy_coffer/pages/account.dart';
import 'package:digy_coffer/pages/home.dart';
import 'package:digy_coffer/pages/SignInSignUp.dart';
import 'package:provider/provider.dart';
import 'package:digy_coffer/notifiers/userNotifier.dart';
import 'package:digy_coffer/pages/splashScreen.dart';
void main() => runApp(ChangeNotifierProvider(
  create: (context) => UserNotifier(),
  child:   MaterialApp(
        title: "qwerty",
        initialRoute: '/',
        debugShowCheckedModeBanner: false,

        routes: {
          '/':(context)=>SplashScreen(),
          '/signInSignUp':(context)=>  signInSignUp(),
          '/account':(context)=>account(),
          '/home':(context)=>home()
        },
      ),
));
