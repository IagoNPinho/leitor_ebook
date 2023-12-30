import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leitor_ebook/src/controller/favoritos_controller.dart';
import 'package:leitor_ebook/src/model/favoritos_model.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';
import '../../repositories/favoritos_repository.dart';

class EBookFavWidget extends StatefulWidget {
  final Map json;
  final BuildContext ctx;
  const EBookFavWidget({
    super.key,
    required this.ctx,
    required this.json,
  });

  @override
  State<EBookFavWidget> createState() => _EBookFavWidgetState();
}

class _EBookFavWidgetState extends State<EBookFavWidget> {
  @override
  Widget build(BuildContext context) {
    final FavoritosModel eBook = FavoritosModel.fromJson(widget.json);
    final double width = MediaQuery.of(widget.ctx).size.width;
    final double height = MediaQuery.of(widget.ctx).size.height;
    final FavoritosRepository repository = Provider.of<FavoritosRepository>(context);
    final FavoritosController controller = FavoritosController();

    return InkWell(
      onTap: () async {
        await controller
            .downloadBook(
          eBook.title,
          eBook.bookUrl,
        )
            .then((path) {
          EpubLocator? locator;

          VocsyEpub.setConfig(
            themeColor: Theme.of(context).primaryColor,
            identifier: 'iosBook',
            scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
            enableTts: true,
            allowSharing: true,
            nightMode: true,
          );

          VocsyEpub.open(
            path,
            lastLocation: locator,
          );

          VocsyEpub.locatorStream.listen((locator) {
            locator = EpubLocator.fromJson(jsonDecode(locator));
          });

          VocsyEpub.closeReader();
        });
      },
      child: Container(
        decoration: BoxDecoration(border: Border.all()),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: eBook.coverUrl,
                    height: 270,
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: InkWell(
                    onTap: () {
                      controller.removeFavorito(eBook).then(
                            (favorito) => repository.removeFavorito(favorito),
                          );
                    },
                    child: const Icon(
                      Icons.favorite,
                      size: 40,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                width: width,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      eBook.title,
                      style: GoogleFonts.roboto(
                        color: Colors.brown,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: height * 0.007),
                    Text(
                      eBook.author,
                      style: GoogleFonts.robotoCondensed(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
