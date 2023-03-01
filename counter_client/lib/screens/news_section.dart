import 'package:http/http.dart' as http;
import 'package:counter_client/models/news_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsSection extends StatefulWidget {
  const NewsSection({
    super.key,
    required this.stock,
  });

  final String stock;

  @override
  State<NewsSection> createState() => _NewsSectionState();
}

class _NewsSectionState extends State<NewsSection> {
  late NewsModel _newsModel = NewsModel(
    status: '',
    totalResults: 0,
    articles: [],
  );

  String apiKey = '';

  void callApi() async {
    var client = http.Client();
    var response = await client.get(
      Uri.parse(
          'https://newsapi.org/v2/everything?q=${widget.stock}&apiKey=$apiKey'),
    );
    setState(() {
      _newsModel = newsModelFromJson(response.body);
    });
  }

  @override
  void initState() {
    callApi();
    super.initState();
  }

  void launchURL(String url) async {
    Uri uri = Uri.parse(url);
    launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(
          'News Section for ${widget.stock}',
          style: GoogleFonts.robotoMono(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: _newsModel.totalResults == 0
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    onTap: () {
                      launchURL(_newsModel.articles[index].url);
                    },
                    title: Text(
                      _newsModel.articles[index].title,
                      style: GoogleFonts.robotoMono(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      _newsModel.articles[index].content,
                      style: GoogleFonts.robotoMono(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    trailing: Image.network(
                      _newsModel.articles[index].urlToImage!,
                      height: 100,
                      width: 100,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
