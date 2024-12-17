import 'package:flutter/material.dart';
import 'package:mvvm_model/model/movie_model.dart';
import 'package:mvvm_model/utils/routes/routes_name.dart';
import 'package:mvvm_model/utils/utils.dart';
import 'package:mvvm_model/view_model/home_view_model.dart';
import 'package:mvvm_model/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import '../data/response/status.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewViewModel homeViewViewModel = HomeViewViewModel();
  @override
  void initState() {
    // TODO: implement initState
    homeViewViewModel.fetchMovieListApi();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueAccent,
        actions: [
          InkWell(
            onTap: (){
              userPreference.remove().then((value){
                Navigator.pushNamed(context, RoutesName.login);
              });
            },
            child: Center(
                child: Text('Logout',style: TextStyle(color: Colors.white),)),),
          SizedBox(width: 20,)
        ],
      ),
      body: ChangeNotifierProvider<HomeViewViewModel>(
        create: (BuildContext context) => homeViewViewModel,
        child: Consumer<HomeViewViewModel>(
          builder: (context, value, _) {
            switch (value.moviesList.status) {
              case Status.LOADING:
                return Center(child: CircularProgressIndicator());
              case Status.ERROR:
                return Center(child: Text(value.moviesList.message.toString()));
              case Status.COMPLETED:
                return ListView.builder(
                    itemCount: value.moviesList.data!.movies!.length,
                    itemBuilder: (context ,index){
                  return Card(
                    child: ListTile(
                      leading: Image.network(value.moviesList.data!.movies![index].posterurl.toString(),
                      errorBuilder: (context , error , stackTrace){
                        return Icon(Icons.error,color: Colors.red,);
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
                          Icon(Icons.star,color: Colors.yellow,)
                        ],
                      ),

                    ),
                  );
                });
              case null: // Handle the null case
                return Center(child: Text("Status is null"));
            }
          },
        ),
      ),
    );
  }
}
