import 'package:flutter/material.dart';
import 'package:leitor_ebook/src/leitor_ebook.dart';
import 'package:leitor_ebook/src/repositories/favoritos_repository.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FavoritosRepository()),
      ],
      child: const LeitorEbook(),
    ),
  );
}
