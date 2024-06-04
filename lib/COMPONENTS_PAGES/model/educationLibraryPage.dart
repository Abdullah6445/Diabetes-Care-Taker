import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';

class educationLibraryPage extends StatefulWidget {
  @override
  _educationLibraryPageState createState() => _educationLibraryPageState();
}

class _educationLibraryPageState extends State<educationLibraryPage> {
  List<Map<String, dynamic>> articles = [];

  Future<void> fetchArticles() async {
    final response = await http.get(Uri.parse(
        'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&retmode=json&retmax=1000&term=diabetes'));

    if (response.statusCode == 200) {
      setState(() {
        articles =
            (json.decode(response.body)['esearchresult']['idlist'] as List)
                .map((id) => {'id': id})
                .toList();
      });
    } else {
      throw Exception('Failed to load articles');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Diabetes Articles'),
        ),
        body: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: FutureBuilder(
                  future: fetchArticleTitletitle(articles[index]['id']),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return LoadingAnimationWidget.threeArchedCircle(
                        size: MediaQuery.of(context).size.height * 0.05,
                        color: Colors.blue,
                      );
                    } else if (snapshot.hasError) {
                      return Text(
                        'Loading...',
                      );
                    } else {
                      return Text(
                        snapshot.data.toString(),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w900),
                      );
                    }
                  },
                ),
                subtitle: FutureBuilder(
                  future: fetchArticleTitle(articles[index]['id']),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("loading...");
                    } else if (snapshot.hasError) {
                      return Row(
                        children: [
                          Text(
                            "THis article may take a while",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      );
                    } else {
                      return Text(
                        snapshot.data.toString(),
                        style: TextStyle(fontSize: 14),
                      );
                    }
                  },
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: articles.length));
  }

  Future<String> fetchArticleTitle(String id) async {
    final response = await http.get(Uri.parse(
        'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi?db=pubmed&id=$id&retmode=json'));
    if (response.statusCode == 200) {
      return json.decode(response.body)['result'][id]['sorttitle'];
    } else {
      throw Exception('Failed to load article title');
    }
  }

  Future<String> fetchArticleTitletitle(String id) async {
    final response = await http.get(Uri.parse(
        'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi?db=pubmed&id=$id&retmode=json'));
    if (response.statusCode == 200) {
      return json.decode(response.body)['result'][id]['title'];
    } else {
      throw Exception('Failed to load article title');
    }
  }
}




















// import 'package:diabetes_articles/model/RearchArticles.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ArticleListScreen(),
//     );
//   }
// }

// class ArticleListScreen extends StatefulWidget {
//   @override
//   _ArticleListScreenState createState() => _ArticleListScreenState();
// }

// class _ArticleListScreenState extends State<ArticleListScreen> {
//   final ArticleService _articleService = ArticleService();
//   Future<List<dynamic>>? _articlesFuture;

//   @override
//   void initState() {
//     super.initState();
//     _articlesFuture = _articleService.fetchArticles();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Diabetes Articles'),
//       ),
//       body: FutureBuilder<List<dynamic>>(
//         future: _articlesFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No articles found.'));
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 final article = snapshot.data![index];
//                 return ListTile(
//                   title: Text(article['title']),
//                   subtitle: Text(article['description']),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }





























// // // import 'package:diabetes_articles/model/RearchArticles.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:http/http.dart' as http;

// // // class homePage extends StatefulWidget {
// // //   const homePage({super.key});

// // //   @override
// // //   State<homePage> createState() => _homePageState();
// // // }

// // // class _homePageState extends State<homePage> {
// // //   ResesrchArticleModelClass? research_articles_list;

// // //   getDAta() async {
// // //     var response = await http.get(Uri.parse(
// // //         'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&retmode=json&retmax=100&term=diabetes'));

// // //     if (response.statusCode == 200) {
// // //       ResesrchArticleModelClass res =
// // //           resesrchArticleModelClassFromJson(response.body);
// // //       research_articles_list = res;
// // //       return res;
// // //     } else {
// // //       return false;
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text("research articles"),
// // //       ),
// // //       body: Container(
// // //         height: double.infinity,
// // //         width: double.infinity,
// // //         color: Colors.blue.shade200,
// // //         child: Column(
// // //           children: [
// // //             FutureBuilder(
// // //               future: getDAta(),
// // //               builder: (context, snapshot) {
// // //                 if (snapshot.connectionState == ConnectionState.waiting) {
// // //                   return CircularProgressIndicator();
// // //                 }
// // //                 if (snapshot.hasError) {
// // //                   return Text("error");
// // //                 }
// // //                 if (snapshot.hasData) {
// // //                   return Expanded(
// // //                     child: ListView.builder(
// // //                       itemCount:
// // //                           research_articles_list!.esearchresult!.idlist!.length,
// // //                       itemBuilder: (context, index) {
// // //                         return ListTile(
// // //                           leading: Text(research_articles_list!
// // //                               .esearchresult!.idlist![index]
// // //                               .toString()),
// // //                         );
// // //                       },
// // //                     ),
// // //                   );
// // //                 } else {
// // //                   return Text("loading");
// // //                 }
// // //               },
// // //             )
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }






























// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';

// // class homePage extends StatefulWidget {
// //   @override
// //   _homePageState createState() => _homePageState();
// // }

// // class _homePageState extends State<homePage> {
// //   List<Map<String, dynamic>> articles = [];

// //   Future<void> fetchArticles() async {
// //     final response = await http.get(Uri.parse(
// //         'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&retmode=json&retmax=10&term=diabetes'));

// //     if (response.statusCode == 200) {
// //       setState(() {
// //         articles =
// //             (json.decode(response.body)['esearchresult']['idlist'] as List)
// //                 .map((id) => {'id': id})
// //                 .toList();
// //       });
// //     } else {
// //       throw Exception('Failed to load articles');
// //     }
// //   }

// //   @override
// //   void initState() {
// //     super.initState();
// //     fetchArticles();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Diabetes Articles'),
// //       ),
// //       body: ListView.builder(
// //         itemCount: articles.length,
// //         itemBuilder: (context, index) {
// //           return ListTile(
// //             title: Text('Article ${index + 1}'),
// //             subtitle: FutureBuilder(
// //               future: fetchArticleTitle(articles[index]['id']),
// //               builder: (context, snapshot) {
// //                 if (snapshot.connectionState == ConnectionState.waiting) {
// //                   return CircularProgressIndicator();
// //                 } else if (snapshot.hasError) {
// //                   return Text('Error: ${snapshot.error}');
// //                 } else {
// //                   return Text(snapshot.data.toString());
// //                 }
// //               },
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }

// //   Future<String> fetchArticleTitle(String id) async {
// //     final response = await http.get(Uri.parse(
// //         'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi?db=pubmed&id=$id&retmode=json'));
// //     if (response.statusCode == 200) {
// //       return json.decode(response.body)['result'][id]['title'];
// //     } else {
// //       throw Exception('Failed to load article title');
// //     }
// //   }
// // }


















// // // // import 'dart:convert';

// // // // import 'package:diabetes_articles/model/RearchArticles.dart';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:http/http.dart' as http;

// // // // class homePage extends StatefulWidget {
// // // //   const homePage({super.key});

// // // //   @override
// // // //   State<homePage> createState() => _homePageState();
// // // // }

// // // // class _homePageState extends State<homePage> {
// // // //   List<ResearchArticles> research_articles_list = [];

// // // //   Future<List<ResearchArticles>> getDAta() async {
// // // //     final Response = http.get(Uri.parse(
// // // //         'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&retmode=json&retmax=10&term=diabetes'));
// // // //     var data = jsonDecode(Response.toString());

// // // //     if (Response.) {
      
// // // //     }
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: Text("research articles"),
// // // //       ),
// // // //       body: Container(
// // // //         height: double.infinity,
// // // //         width: double.infinity,
// // // //         color: Colors.blue.shade200,
// // // //       ),
// // // //     );
// // // //   }
// // // // }
