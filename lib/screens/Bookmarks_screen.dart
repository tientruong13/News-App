import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_app/screens/empty_screen.dart';
import 'package:new_app/widgets/articles_widget.dart';
import 'package:new_app/widgets/utils.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: color),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          title: Text(
            ' Bookmarks',
            style: GoogleFonts.lobster(
                textStyle: TextStyle(
              color: color,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.6,
            )),
          ),
        ),
        body: EmptyNewsWidget(
          text: 'You didn\'t add anything yet to your bookmarks',
          imagePath: 'assets/images/bookmark.png',
        )
        // ListView.builder(
        //     itemCount: 20,
        //     itemBuilder: (ctx, index) {
        //       return const ArticlesWidget();
        //     }),
        );
  }
}
