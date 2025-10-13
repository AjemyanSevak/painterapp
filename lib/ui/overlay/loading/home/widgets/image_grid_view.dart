import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:painter_app/base/colors/app_colors.dart';
import 'package:painter_app/base/routes/rout_constants.dart';
import 'package:painter_app/base/routes/routes.dart';
import 'package:painter_app/base/text_styles.dart';
import 'package:painter_app/cubit/home/home_cubit.dart';

class GalleryGrid extends StatelessWidget {
  const GalleryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    const radius = 22.0;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return StreamBuilder(
          stream: HomeCubit().streamUserImages(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final images = snap.data ?? const [];
            if (images.isEmpty) {
              context.read<HomeCubit>().setCreateButtonVisible(true);
              return Center(
                child: Text(
                  'No images yet',
                  style: AppTextStyles.bodyLargeMedium.copyWith(
                    color: AppColors.whiter,
                  ),
                ),
              );
            } else {
              context.read<HomeCubit>().setCreateButtonVisible(false);
            }

            return GridView.builder(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 1.05, // ≈ almost square like your mock
              ),
              itemCount: images.length,
              itemBuilder: (ctx, i) {
                final img = images[i];
                return _GalleryTile(
                  imageUrl: img.url,
                  radius: radius,
                  onTap: () {
                    goRouter.go(AppRoute.painteredit, extra: img);
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}

class _GalleryTile extends StatelessWidget {
  final String imageUrl;
  final double radius;
  final VoidCallback onTap;

  const _GalleryTile({
    required this.imageUrl,
    required this.radius,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(radius),
      clipBehavior: Clip.antiAlias,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          // soft drop shadow like in your screen
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.35),
              blurRadius: 24,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(radius),
          overlayColor: WidgetStatePropertyAll(
            AppColors.white.withValues(alpha: 0.10),
          ),
          splashColor: AppColors.white.withValues(alpha: 0.18),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) {
                  return child;
                }
                return AnimatedOpacity(
                  opacity: frame == null ? 0 : 1,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                  child: child,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
