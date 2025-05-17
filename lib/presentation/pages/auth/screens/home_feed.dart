import 'package:bloc_clean_arch/presentation/bloc/auth_bloc.dart';
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
                  final state = context.read<AuthBloc>().state as AuthSuccess;
                  final username = state.user.username;

                  return Text(
                    username,
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
