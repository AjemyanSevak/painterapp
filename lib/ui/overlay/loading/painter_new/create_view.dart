import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:painter_app/base/routes/rout_constants.dart';
import 'package:painter_app/base/routes/routes.dart';
import 'package:painter_app/cubit/painternew/painter_new_cubit.dart';
import 'package:painter_app/ui/overlay/loading/painter_new/widgets/header.dart';
import 'package:painter_app/ui/overlay/loading/widgets/app_background.dart';
import 'package:painter_app/ui/overlay/loading/widgets/painter.dart';

class CreateNewView extends StatelessWidget {
  const CreateNewView({super.key});

  @override
  Widget build(BuildContext context) {
    final pageKey = GlobalKey<CanvasPainterPageState>();

    return BlocConsumer<PainterNewCubit, PainterNewState>(
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: ${state.error}')));
        } else {
          Future.delayed(Duration(seconds: 2), () {
            goRouter.go(AppRoute.home);
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              AppBackground(),
              Column(
                children: [
                  CreateNewHeader(
                    onSave: () async {
                      final imageBytes = await pageKey.currentState
                          ?.exportAsImage();
                      // ignore: use_build_context_synchronously
                      context.read<PainterNewCubit>().uploadBytes(
                        imageBytes!,
                        fileName: 'name',
                        title: null,
                      );
                    },
                  ),
                  Expanded(child: CanvasPainterPage(key: pageKey)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
