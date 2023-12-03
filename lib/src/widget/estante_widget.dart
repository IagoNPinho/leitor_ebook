import 'package:flutter/material.dart';

class EstanteWidget extends StatelessWidget {
  final BuildContext context;
  final AsyncSnapshot snapshot;

  const EstanteWidget(
      {super.key, required this.context, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 10,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      //itemCount: snapshot.data["data"].length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(border: Border.all()),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(12)),
                      ),
                      child: const Image(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/cover.jpg"),
                      ),
                    ),
                    Positioned(
                      right: 5,
                      child: GestureDetector(
                        child: const Icon(
                          Icons.favorite_border,
                          color: Colors.blue,
                        ),
                        onTap: (){},
                      ),
                    ),
                  ],
                ),
                const Text("The Bible of Nature"),
                const Text("Oswald, Felix L."),
              ],
            ),
          ),
        );
      },
    );
  }
}
