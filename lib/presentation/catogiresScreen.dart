import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/datasource/remote/apiService.dart';
import '../data/models/newsChannelHadlineModel.dart';

class CatogiresScreen extends StatefulWidget {
  @override
  State<CatogiresScreen> createState() => _MyCatogiresScreenState();
}

class _MyCatogiresScreenState extends State<CatogiresScreen> {
  List<String> btnCatogires = ["Generial", "phone", "laptop", "art", "perfume"];
  String name = "Generial";
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
            child: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Center(
            child: Column(children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: btnCatogires.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            name = btnCatogires[index];
                            print(ApiService.api
                                .fetchCustomNewsChannelHeadlinesApi(name));
                          });
                        },
                        child: Expanded(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 22, vertical: 12),
                            decoration: BoxDecoration(
                                color: btnCatogires[index] == name
                                    ? Colors.green
                                    : Colors.deepOrange,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              btnCatogires[index],
                              style: GoogleFonts.allan(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                child: FutureBuilder<NewsChannelsHandelingModel>(
                  future: name == "Generial"
                      ? ApiService.api.fetchNewsChannelHeadlinesApi()
                      : ApiService.api.fetchCustomNewsChannelHeadlinesApi(name),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data?.products?.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot
                                        .data!.products![index].images![0]
                                        .toString(),
                                    fit: BoxFit.cover,
                                    width: width * 0.3,
                                    height: height * 0.22,
                                    placeholder: (context, url) => Container(
                                      child: spinkit2,
                                    ),
                                    errorWidget: (context, url, error) => Icon(
                                        Icons.error_outline,
                                        color: Colors.red),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: height * 0.22,
                                    width: width * 0.7,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 20, left: 5, right: 5),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${snapshot.data!.products![index].title}",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "${snapshot.data!.products![index].description}",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              "The Rate Is : ${snapshot.data!.products![index].rating}",
                                              style: GoogleFonts.aBeeZee(
                                                  color: Colors.green,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ]),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text(
                        snapshot.error.toString(),
                        style: GoogleFonts.aBeeZee(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      );
                    } else {
                      return Center(
                        child: SpinKitCircle(
                          color: Colors.blue,
                          size: 50,
                        ),
                      );
                    }
                  },
                ),
              ),
            ]),
          ),
        )),
      ),
    );
  }
}

const spinkit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 40,
);
