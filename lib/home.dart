import 'package:movieapp/data/datasource/remote/api.dart';
import 'package:movieapp/data/datasource/remote/constants.dart';
import 'package:movieapp/data/model/MovieResponse.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                  future: APIService.api.fetchMovieInfo(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      MovieResponse movieRespose = snapshot.data!;
                      return ListView.builder(
                          itemCount: movieRespose.results?.length,
                          itemBuilder: (context, index) => ListTile(
                                leading: Image.network("${imageURL}${movieRespose.results?[index].posterPath}"),
                                title: Text("${movieRespose.results?[index].title} (${movieRespose.results?[index].releaseDate})"),
                                subtitle: Text("${movieRespose.results?[index].voteAverage}"),
                              ));
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  })
            ],
          ),
        )),
      ),
    );
  }
}
