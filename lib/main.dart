// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project_delphi/widgets/button.dart';
import 'package:project_delphi/widgets/textfield.dart';
import 'util.dart';
import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    TextTheme textTheme = createTextTheme(context, "PT Sans", "Poppins");

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      home: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: const Catalog()),
    );
  }
}

class Catalog extends StatelessWidget {
  const Catalog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Typography(),
              SizedBox(
                height: 10,
              ),
              Button(
                text: 'Next',
                onPressed: () {},
                leadingIcon: Icons.arrow_back,
                isLoading: false,
                trailingIcon: Icons.arrow_forward,
              ),
              SizedBox(
                height: 10,
              ),
              Textfield(),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Typography extends StatelessWidget {
  const Typography({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Heading",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          "Heading",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          "Heading",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Text(
          "label",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Text(
          "label",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Text(
          "label",
          style: Theme.of(context).textTheme.labelSmall,
        ),
        Text(
          "body",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          "body",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          "body",
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
