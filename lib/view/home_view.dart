import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvvm_practices/data/responses/status.dart';
import 'package:mvvm_practices/model/movies_model.dart';
import 'package:mvvm_practices/utils/routes/routes_names.dart';
import 'package:mvvm_practices/utils/utils.dart';
import 'package:mvvm_practices/view_model/home_view_model.dart';
import 'package:mvvm_practices/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    homeViewModel.fetchMoviesListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserViewModel>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Home Screen'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout_rounded,size: 40,),
              onPressed: (){
                userPreference.removeSession().then((value){
                  Navigator.pushNamed(context, RoutesName.login);
                });
              },
            ),
            const SizedBox(width: 10,)
          ],
        ),
        body:  ChangeNotifierProvider<HomeViewModel>(
          create: (BuildContext context) => homeViewModel,
          child:Consumer<HomeViewModel>(
            builder: (context,value,_){
              switch(value.moviesList.status){
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return Center(child: Text(value.moviesList.message.toString()));
                case Status.COMPLETED:
                  return ListView.builder(
                    itemCount: value.moviesList.data!.movies!.length,
                      itemBuilder: (context,index){
                      return Card(
                        child: ListTile(
                          leading: Image.network(value.moviesList.data!.movies![index].posterurl.toString(),
                          errorBuilder: (context,error,stack){
                            return const Icon(Icons.error,color: Colors.red,);
                          },
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                          title: Text(value.moviesList.data!.movies![index].title.toString()),
                          subtitle: Text(value.moviesList.data!.movies![index].year.toString()),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(Utils.averageRating(value.moviesList.data!.movies![index].ratings!).toStringAsFixed(1)),
                              const Icon(Icons.star,color: Colors.orangeAccent,)
                            ],
                          ),
                        ),
                      );
                      });
                case null:
                  // TODO: Handle this case.
                default:
              }
              return Container();
            }
          )
        )
    );
  }
}
