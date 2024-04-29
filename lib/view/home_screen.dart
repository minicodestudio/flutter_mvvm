import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/home_view_model.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';
import '../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    homeViewModel.fetchMovieListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
            onTap: () {
              userPreferences.remove().then((value) {
                Navigator.pushNamed(context, RoutesName.login);
              });
            },
            child: Text('Logout'),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: ChangeNotifierProvider<HomeViewModel>(
        create: (BuildContext context) => homeViewModel,
        child: Consumer<HomeViewModel>(builder: (context, value, _) {
          switch (value.moviesList.status) {
            case Status.ERROR:
              return Center(child: Text(value.moviesList.message.toString()));
            case Status.COMPLETED:
              return ListView.builder(
                  itemCount: value.moviesList.data?.movies!.length,
                  itemBuilder: (context, index) {
                    return (Card(
                      child: ListTile(
                        leading: Image.network(
                          value.moviesList.data!.movies![index].posterurl
                              .toString(),
                          errorBuilder: (context, error, stack) {
                            return Icon(Icons.error);
                          },
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                        ),
                        title: Text(value.moviesList.data!.movies![index].title
                            .toString()),
                        subtitle: Text(value
                            .moviesList.data!.movies![index].year
                            .toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(Utils.averageRating(value
                                    .moviesList.data!.movies![index].ratings!)
                                .toStringAsFixed(1)),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                          ],
                        ),
                      ),
                    ));
                  });
            case Status.LOADING:
            default:
              return Center(child: CircularProgressIndicator());
          }
          return Container();
        }),
      ),
    );
  }
}
