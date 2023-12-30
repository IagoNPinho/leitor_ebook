import 'package:flutter/material.dart';
import 'package:leitor_ebook/src/controller/ebook_controller.dart';
import 'package:leitor_ebook/src/view/widget/ebook_widget.dart';

class EstanteWidget extends StatelessWidget {
  const EstanteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final EBookController controller = EBookController();

    return FutureBuilder(
      future: controller.callAPI(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Container(
              width: 200,
              height: 200,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                strokeWidth: 5,
              ),
            );
          default:
            if (snapshot.hasError || snapshot.data!.isEmpty) {
              return const Center(
                child: Text("Problema com sua conexão"),
              );
            } else {
              List data = snapshot.data!;
              return GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.5,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 10,
                ),
                itemCount: data.length,
                itemBuilder: (context, index) => EBookWidget(
                  ctx: context,
                  json: data[index],
                ),
              );
            }
        }
      },
    );
  }
}
