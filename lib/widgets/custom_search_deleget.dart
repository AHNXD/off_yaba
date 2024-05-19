import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:off_yaba/models/store_model.dart';
import 'package:off_yaba/screens/restaurantScreen.dart';
import 'package:off_yaba/services/network/apiService.dart';
import 'package:off_yaba/widgets/store_card.dart';

class StoreSearchDelegate extends SearchDelegate {
  Future<List> searchStores(String query) async {
    try {
      final response = await DioHelper.getAuthorizedData(
          path: "stores", queryParameters: {'search_word': query});
      if (response!.data['success']) {
        return response.data['data']['stores'];
      } else {
        print('Search failed: ${response.data['message']}');
        return [];
      }
    } on DioException catch (e) {
      print('DioError: $e');
      return [];
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List>(
      future: searchStores(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
              child: Text('لا يوجد نتائج توافق الكلمةالتي تبحث عنها'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var store = StoreModel.fromMap(snapshot.data![index]);
              // return StoreCard(store: store);
              return ListTile(
                onTap: () => Navigator.pushNamed(
                    context, RestaurantScreen.routeName,
                    arguments: {"store": store}),
                leading: CircleAvatar(
                  backgroundImage: store.image != null
                      ? NetworkImage(store.image!) as ImageProvider<Object>
                      : const AssetImage("assets/images/no-image-found.png")
                          as ImageProvider<Object>,
                ),
                title: Text(store.name!),
                subtitle: Text(store.address!),
                trailing: Text(
                  '${store.discount!}% off',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }
}

// // Usage
// showSearch(
//   context: context,
//   delegate: StoreSearchDelegate(),
// );
