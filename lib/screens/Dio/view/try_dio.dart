import 'package:flutter/material.dart';
import 'package:login/screens/Dio/models/product_provider.dart';
import 'package:provider/provider.dart';

class TryDio extends StatefulWidget {
  const TryDio({super.key});

  @override
  State<TryDio> createState() => _TryDioState();
}

class _TryDioState extends State<TryDio> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final ProuctProvider provider = context.watch<ProuctProvider>();
    provider.fetchProuct();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProuctProvider>(builder: (context, value, child) {
        if (value.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          print(value.isLoading);
          return ListView.builder(
            shrinkWrap: true,
            itemCount: value.getProuct.length,
            itemBuilder: (context, index) => ListTile(
              leading: Text(value.getProuct[index].id.toString()),
              title: Text(value.getProuct[index].title),
              subtitle: Text(value.getProuct[index].description),
            ),
          );
        }
      }),
    );
  }
}
