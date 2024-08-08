import 'dart:convert';

import 'package:diabetes_care_taker/COMPONENTS_PAGES/model/diabetes_listtile_items.dart';
import 'package:diabetes_care_taker/PAGES/popupMenuPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class educationLibraryPage extends StatefulWidget {
  const educationLibraryPage({super.key});

  @override
  State<educationLibraryPage> createState() => _educationLibraryPageState();
}

class _educationLibraryPageState extends State<educationLibraryPage> {
  bool isLoading = true;
  double loadingProgress = 1;

  @override
  void initState() {
    super.initState();
    fetchDataFromApi();
  }

  List<Map<String, dynamic>> diabetesArticalListitems = [];

  Future<void> fetchDataFromApi() async {
    try {
      var url =
          "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&retmode=json&retmax=20&term=diabetes";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        List<String> idList =
            List<String>.from(responseData['esearchresult']['idlist']);

        List<Map<String, dynamic>> fetchedItems = [];
        int totalRequests = idList.length;

        for (int i = 0; i < totalRequests; i++) {
          String id = idList[i];
          var idUrl =
              "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi?db=pubmed&id=$id&retmode=json";
          final idUrlResponseData = await http.get(Uri.parse(idUrl));

          if (idUrlResponseData.statusCode == 200) {
            var summaryData = jsonDecode(idUrlResponseData.body);
            var title =
                summaryData['result'][id]['title'] ?? 'No title available';
            var sortTitle = summaryData['result'][id]['sorttitle'] ??
                'No sorted title available';
            fetchedItems.add({
              'title': title,
              'sorttitle': sortTitle,
            });

            setState(() {
              loadingProgress = (i + 1) / totalRequests;
              diabetesArticalListitems = fetchedItems;
            });
          } else {
            throw Exception("Failed to load title for ID: $id");
          }
        }
      } else {
        throw Exception("Failed to load IDs");
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Diabetes Practice Page"),
        actions: const [
          popupMenuPage(),
        ],
      ),
      body: isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.red,
                    value: loadingProgress,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Loading: $loadingProgress ",
                    style: const TextStyle(
                        color: Colors.green, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("please wait :)"),
                ],
              ),
            )
          : ListView.separated(
              itemCount: diabetesArticalListitems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListTileItemInDetail(
                            title: diabetesArticalListitems[index]['title'],
                            subTitle: diabetesArticalListitems[index]
                                ['sorttitle'],
                          ),
                        ));
                  },
                  leading: CircleAvatar(
                    child: Text("${index + 1}"),
                  ),
                  title: Text(
                    diabetesArticalListitems[index]['title'] ??
                        'No title available',
                    maxLines: 2,
                  ),
                  subtitle: Text(
                    diabetesArticalListitems[index]['sorttitle'] ??
                        'No sorted title available',
                    maxLines: 2,
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            ),
    );
  }
}
