import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/bloc/news_bloc.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App - Bloc'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: TextFormField(
                        onFieldSubmitted: (value) {
                          context
                              .read<NewsBloc>()
                              .add(NewsSearchEvent(search: value));
                        },
                        controller: _searchController,
                        decoration: const InputDecoration(labelText: 'Search')),
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: IconButton(
                      onPressed: () {
                        context.read<NewsBloc>().add(
                            NewsSearchEvent(search: _searchController.text));
                      },
                      icon: const Icon(Icons.search)))
            ],
          ),
          // Jika ingin menggunakan keduanya(BlocBuilder & BlocListener)
          BlocConsumer<NewsBloc, NewsState>(
            builder: (context, state) {
              if (state is NewsLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is NewsLoadedState) {
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(state.listNews[index].title!),
                          subtitle: Text(
                              state.listNews[index].publishedAt.toString()),
                        ),
                      );
                    },
                    itemCount: state.listNews.length,
                  ),
                );
              }
              return const Center(child: Text('No Data'));
            },
            listener: (context, state) {
              if (state is NewsLoadingState) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                    'Pencarian sedang berlangsung',
                    style: TextStyle(color: Colors.black),
                  ),
                  backgroundColor: Colors.yellow,
                ));
              }

              if (state is NewsLoadedState) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Pencarian berhasil'),
                  backgroundColor: Colors.blue,
                ));
              }
            },
          ),
          // BlocListener<NewsBloc, NewsState>(
          //   listener: (context, state) {
          //     if (state is NewsLoadingState) {
          //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          //         content: Text(
          //           'Pencarian sedang berlangsung',
          //           style: TextStyle(color: Colors.black),
          //         ),
          //         backgroundColor: Colors.yellow,
          //       ));
          //     }

          //     if (state is NewsLoadedState) {
          //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          //         content: Text('Pencarian berhasil'),
          //         backgroundColor: Colors.blue,
          //       ));
          //     }
          //   },
          //   child: BlocBuilder<NewsBloc, NewsState>(
          //     builder: (context, state) {
          //       if (state is NewsLoadingState) {
          //         return const Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       }

          //       if (state is NewsLoadedState) {
          //         return Expanded(
          //           child: ListView.builder(
          //             itemBuilder: (context, index) {
          //               return Card(
          //                 child: ListTile(
          //                   title: Text(state.listNews[index].title!),
          //                   subtitle: Text(
          //                       state.listNews[index].publishedAt.toString()),
          //                 ),
          //               );
          //             },
          //             itemCount: state.listNews.length,
          //           ),
          //         );
          //       }
          //       return const Center(child: Text('No Data'));
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
