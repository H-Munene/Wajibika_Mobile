import 'package:bloc_clean_arch/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeFeed extends StatelessWidget {
  const HomeFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            children: [
              Text('Welcome, ', style: Theme.of(context).textTheme.bodyLarge),
              Builder(
                builder: (context) {
                  final userModel = context.read<UserProvider>().userModel;

                  return Text(
                    userModel.username,
                    style: Theme.of(context).textTheme.bodyLarge,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
