import 'package:flutter/material.dart';
import 'package:haber_uygulamasi/data/news_service.dart';
import 'package:haber_uygulamasi/models/article.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Haberler',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Haberler'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Articles> articles = [];

  @override
  void initState() {
    NewsService.getNews().then((value) {
      setState(() {
        articles = value!;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
          child: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                Image.network(articles[index].urlToImage!),
                ListTile(
                  leading: Icon(Icons.arrow_drop_down_circle),
                  title: Text(articles[index].title!),
                  subtitle: Text(articles[index].author!),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(articles[index].description!),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await launch(articles[index].url!);
                      },
                      child: Text("Habere Git"),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      )),
    );
  }
}
