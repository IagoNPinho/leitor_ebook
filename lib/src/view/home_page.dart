import 'package:flutter/material.dart';
import 'package:leitor_ebook/src/widget/estante_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ebook's",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: const Expanded(
        child: Center(child: Text('')),
        //child: EstanteWidget(
        //  context: context,
        //  snapshot: snapshot,
        //),
      ),
    );
  }
}