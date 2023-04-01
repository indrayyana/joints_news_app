import 'package:flutter/material.dart';
import 'package:project/data/article_model.dart';
import 'package:project/data/network_manager.dart';
import 'package:project/manual/news_detail.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late Future<List<Article>> listNews;
  late TextEditingController _searchController;

  @override
  void initState() {
    listNews = NetworkManager().getAllNews();
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  void checkIsEmpty(String nilai) {
    if (nilai.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Text Search tidak boleh kosong!'),
        backgroundColor: Colors.red,
      ));
    } else {
      listNews = NetworkManager().getSearchNews(nilai);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Joints News App'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Card(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: TextFormField(
                      onFieldSubmitted: (value) {
                        checkIsEmpty(value);
                      },
                      controller: _searchController,
                      decoration: const InputDecoration(labelText: 'Search'),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      checkIsEmpty(_searchController.text);
                    },
                    icon: const Icon(Icons.search))
              ],
            ),
          ),
          FutureBuilder(
            future: listNews,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return NewsDetail(news: snapshot.data![index]);
                            },
                          ));
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(snapshot.data![index].title!),
                            subtitle: Row(
                              children: [
                                Expanded(
                                    child: Text(snapshot.data![index].author!)),
                                const SizedBox(width: 8),
                                Expanded(
                                    child: Text(snapshot
                                        .data![index].publishedAt!
                                        .toString()))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: snapshot.data!.length,
                    separatorBuilder: (context, index) {
                      return const Divider(thickness: 2);
                    },
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }
}
