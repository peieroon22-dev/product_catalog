import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'services/api_service.dart';
import 'cubits/product_cubit.dart';
import 'screens/product_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product Catalog',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => ProductCubit(ApiService())..loadInitialProducts(),
        child: const ProductListScreen(),
      ),
    );
  }
}