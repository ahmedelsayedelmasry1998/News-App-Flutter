import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapplication/data/datasource/remote/apiService.dart';
import 'package:newsapplication/data/models/newsChannelHadlineModel.dart';
import 'package:newsapplication/presentation/newsDetailsScreen.dart';

import 'catogiresScreen.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum FilterList { phone, laptop, art, perfume }

class _MyHomePageState extends State<MyHomePage> {
  FilterList? selectedMenu;
  String name = "phone";
  bool selectFunction = true;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<FilterList>(
            onSelected: (value) {
              setState(() {
                name = value.name;
                selectFunction = false;
                ApiService.api.fetchCustomNewsChannelHeadlinesApi(name);
              });
            },
            initialValue: selectedMenu,
            icon: Icon(Icons.more_vert_sharp, color: Colors.black),
            color: Colors.greenAccent,
            itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
              PopupMenuItem<FilterList>(
                child: Text("Phone"),
                value: FilterList.phone,
              ),
              PopupMenuItem<FilterList>(
                child: Text("Laptop"),
                value: FilterList.laptop,
              ),
              PopupMenuItem<FilterList>(
                child: Text("Art"),
                value: FilterList.art,
              ),
              PopupMenuItem<FilterList>(
                child: Text("Perfume"),
                value: FilterList.perfume,
              ),
            ],
          ),
        ],
        backgroundColor: Colors.white10,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset("images/catogary.png"),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CatogiresScreen(),
                ));
          },
        ),
        title: Text(
          "News",
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Center(
          child: ListView(shrinkWrap: true, children: [
            SizedBox(
              height: height * 0.55,
              width: width,
              child: FutureBuilder<NewsChannelsHandelingModel>(
                future: selectFunction
                    ? ApiService.api.fetchNewsChannelHeadlinesApi()
                    : ApiService.api.fetchCustomNewsChannelHeadlinesApi(name),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data?.products?.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => NewsDetails(
                                title: snapshot.data?.products![index].title
                                    .toString(),
                                brand: snapshot.data?.products![index].brand
                                    .toString(),
                                description: snapshot
                                    .data?.products![index].description
                                    .toString(),
                                stock: snapshot.data?.products![index].stock
                                    .toString(),
                                thumbnail: snapshot
                                    .data?.products![index].thumbnail
                                    .toString(),
                                image: snapshot
                                    .data?.products![index].images![0]
                                    .toString(),
                              ),
                            ));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: height * 0.02,
                                horizontal: width * 0.04),
                            child: Container(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    width: width * 0.9,
                                    height: height * 0.6,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: snapshot
                                            .data!.products![index].images![0]
                                            .toString(),
                                        fit: BoxFit.cover,
                                        width: width,
                                        height: height,
                                        placeholder: (context, url) =>
                                            Container(
                                          child: spinkit2,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error_outline,
                                                color: Colors.red),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 50,
                                    child: Card(
                                      elevation: 5,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Container(
                                          width: width * 0.8,
                                          height: height * 0.10,
                                          alignment: Alignment.bottomCenter,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                child: Text(
                                                  "${snapshot.data!.products![index].title}",
                                                  style: GoogleFonts.piazzolla(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Spacer(),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(bottom: 6),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text(
                                                        "${snapshot.data?.products![index].price}",
                                                        style:
                                                            GoogleFonts.alata(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                    Text(
                                                        "${snapshot.data?.products![index].brand}",
                                                        style:
                                                            GoogleFonts.alata(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
            SizedBox(
              height: 8,
              child: Divider(thickness: .5, color: Colors.grey),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 2, top: 10, left: 10, right: 5),
              child: FutureBuilder<NewsChannelsHandelingModel>(
                future: selectFunction
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
        )),
      ),
    );
  }
}

const spinkit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 40,
);
