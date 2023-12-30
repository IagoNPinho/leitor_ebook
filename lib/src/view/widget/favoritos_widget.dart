import 'package:flutter/material.dart';
import 'package:leitor_ebook/src/repositories/favoritos_repository.dart';
import 'package:leitor_ebook/src/view/widget/ebook_fav_widget.dart';
import 'package:provider/provider.dart';

class FavoritosWidget extends StatelessWidget {
  const FavoritosWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritosRepository>(
      builder: (context, favoritos, child) {
        return favoritos.ebooks.isEmpty
            ? const ListTile(
                leading: Icon(Icons.favorite),
                title: Text('Não há livros favoritos'),
              )
            : GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.5,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 10,
                ),
                itemCount: favoritos.ebooks.length,
                itemBuilder: (_, index) {
                  return EBookFavWidget(
                    ctx: context,
                    json: favoritos.ebooks[index],
                  );
                },
              );
      },
    );
  }
}
