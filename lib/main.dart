import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:object_annotation_tool/bloc/annotation_bloc.dart';
import 'package:object_annotation_tool/bloc/bloc/panstartbloc_bloc.dart';
import 'widgets/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Annotation App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => PanstartblocBloc(),
        child: BlocProvider(
          create: (context) => AnnotationBloc(),
          child: HomePage(),
        ),
      ),
    );
  }
}
