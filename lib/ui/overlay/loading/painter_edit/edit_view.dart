import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:painter_app/base/routes/rout_constants.dart';
import 'package:painter_app/base/routes/routes.dart';
import 'package:painter_app/cubit/painteredit/painter_edit_cubit.dart';
import 'package:painter_app/models/image/image_model.dart';
import 'package:painter_app/ui/overlay/loading/painter_edit/widgets/header.dart';
import 'package:painter_app/ui/overlay/loading/widgets/app_background.dart';
import 'package:painter_app/ui/overlay/loading/widgets/painter.dart';

class EditView extends StatelessWidget {
  final ImageDoc imageData;
  const EditView({super.key, required this.imageData});

  @override
  Widget build(BuildContext context) {
    final pageKey = GlobalKey<CanvasPainterPageState>();

    return BlocConsumer<PainterEditCubit, PainterEditState>(
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
                  EditHeader(
                    onSave: () async {
                      final imageBytes = await pageKey.currentState
                          ?.exportAsImage();
                      // ignore: use_build_context_synchronously
                      context.read<PainterEditCubit>().replaceWithNewVersion(
                        docId: imageData.id,
                        oldStoragePath: imageData.storagePath,
                        newBytes: imageBytes!,
                        deleteOld: true,
                      );
                    },
                  ),
                  Expanded(
                    child: CanvasPainterPage(
                      key: pageKey,
                      imageUrl: imageData.url,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
