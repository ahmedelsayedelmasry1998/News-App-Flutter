import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/retry.dart';

class NewsDetails extends StatefulWidget {
  String? title, stock, brand, thumbnail, description, image;

  NewsDetails(
      {this.title,
      this.stock,
      this.brand,
      this.thumbnail,
      this.description,
      this.image,
      super.key});

  @override
  State<NewsDetails> createState() => _MyNewsDetailsState();
}

class _MyNewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white12,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Center(
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(bottom: 20, top: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                child: CachedNetworkImage(
                  imageUrl: widget.image.toString(),
                  width: width,
                  height: height * 0.45,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: SpinKitCircle(
                      color: Colors.green,
                      size: 50,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              top: 50,
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      widget.title.toString(),
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      widget.description.toString(),
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                      maxLines: 3,
                      overflow: TextOverflow.fade,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.brand.toString(),
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        Text(
                          widget.stock.toString(),
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "${DateTime.now()}",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        )),
      ),
    );
  }
}
