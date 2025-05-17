import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/presentation/bloc/auth_bloc.dart';
import 'package:bloc_clean_arch/presentation/widgets/custom_button.dart';
import 'package:bloc_clean_arch/presentation/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            SnackbarDefinition.errorSnackBar(
              context: context,
              message: state.message,
            );
          }

          if (state is AuthSuccess) {
            SnackbarDefinition.successSnackBar(
              context: context,
              message: 'Successfully Logged out',
            );
          }
        },
        builder: (context, state) {
          return CustomButtonWidget(
            child:
                state is AuthLoading
                    ? const CustomLoadingIndicator()
                    : Text(
                      'Logout',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                    ),
            onPressed: () => context.read<AuthBloc>().add(AuthSignOut()),
          );
        },
      ),
    );
  }
}
