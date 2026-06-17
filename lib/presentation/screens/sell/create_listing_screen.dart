import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../config/routes/route_names.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/fake/fake_data.dart';
import '../../../domain/entities/product.dart';
import '../../../theme/zolya_theme.dart';
import '../../bloc/create_listing/create_listing_cubit.dart';
import '../../bloc/create_listing/create_listing_state.dart';
import '../../widgets/zolya/zolya.dart';

class CreateListingScreen extends StatelessWidget {
  const CreateListingScreen({super.key, this.editProductId});

  /// Non nul → l'écran est en mode édition d'une annonce existante.
  final String? editProductId;

  static const _categories = [
    'Tops',
    'Bas',
    'Dresses',
    'Shoes',
    'Accessories',
    'Sacs',
  ];

  static const _conditionLabels = {
    ProductCondition.neuf: 'Neuf',
    ProductCondition.veryGood: 'Very good',
    ProductCondition.good: 'Good',
    ProductCondition.acceptable: 'Acceptable',
  };

  @override
  Widget build(BuildContext context) {
    final editProduct =
        editProductId != null ? FakeData.productById(editProductId!) : null;
    return BlocProvider<CreateListingCubit>(
      create: (_) => CreateListingCubit(editProduct: editProduct),
      child: BlocConsumer<CreateListingCubit, CreateListingState>(
        listenWhen: (prev, curr) => prev.status != curr.status,
        listener: (context, state) {
          if (state.status == CreateListingStatus.failure &&
              state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
          if (state.status == CreateListingStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.isEditing ? 'Listing updated' : 'Article published',
                ),
              ),
            );
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(RouteNames.marketplace);
            }
          }
        },
        builder: (context, state) => _buildView(context, state),
      ),
    );
  }

  Widget _buildView(BuildContext context, CreateListingState state) {
    final cubit = context.read<CreateListingCubit>();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: ZolyaTopBar(
        title: state.isEditing ? 'Edit listing' : 'New listing',
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(ZolyaSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state.existingImageUrls.isNotEmpty) ...[
              const _SectionLabel('Current photos'),
              const SizedBox(height: ZolyaSpacing.sm),
              _ExistingPhotosRow(urls: state.existingImageUrls),
              const SizedBox(height: ZolyaSpacing.lg),
            ],
            _SectionLabel(
              state.existingImageUrls.isNotEmpty
                  ? 'Add photos (${state.images.length}/${AppConstants.maxProductImages})'
                  : 'Photos (${state.images.length}/${AppConstants.maxProductImages})',
            ),
            const SizedBox(height: ZolyaSpacing.sm),
            ZolyaPhotoGrid(
              images: state.images,
              maxCount: AppConstants.maxProductImages,
              onPick: cubit.pickImages,
              onRemove: cubit.removeImage,
            ),
            const SizedBox(height: ZolyaSpacing.xl),
            ZolyaTextField(
              label: 'Title',
              placeholder: 'Ex: Floral dress, size M',
              initialValue: state.title,
              onChanged: cubit.setTitle,
            ),
            const SizedBox(height: ZolyaSpacing.lg),
            ZolyaTextarea(
              label: 'Description',
              placeholder:
                  'Describe your item (brand, condition, flaws...)',
              initialValue: state.description,
              onChanged: cubit.setDescription,
            ),
            const SizedBox(height: ZolyaSpacing.lg),
            ZolyaTextField(
              label: 'Price (FCFA)',
              placeholder: 'Ex: 5000',
              initialValue: state.price,
              keyboardType: TextInputType.number,
              onChanged: cubit.setPrice,
            ),
            const SizedBox(height: ZolyaSpacing.lg),
            const _SectionLabel('Category'),
            const SizedBox(height: ZolyaSpacing.sm),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _categories
                  .map((cat) => ZolyaChip(
                        label: cat,
                        selected: state.category == cat,
                        onTap: () => cubit.setCategory(cat),
                      ))
                  .toList(),
            ),
            const SizedBox(height: ZolyaSpacing.lg),
            const _SectionLabel('Condition'),
            const SizedBox(height: ZolyaSpacing.sm),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ProductCondition.values
                  .map((c) => ZolyaChip(
                        label: _conditionLabels[c]!,
                        selected: state.condition == c,
                        onTap: () => cubit.setCondition(c),
                      ))
                  .toList(),
            ),
            const SizedBox(height: ZolyaSpacing.lg),
            ZolyaTextField(
              label: 'Size (optional)',
              placeholder: 'S, M, L, 38, 42...',
              initialValue: state.size,
              onChanged: cubit.setSize,
            ),
            const SizedBox(height: ZolyaSpacing.xxl),
            ZolyaButton(
              label: state.isEditing ? 'Save changes' : 'Publish article',
              onPressed: state.isSubmitting ? null : cubit.submit,
              loading: state.isSubmitting,
              expand: true,
              size: ZolyaButtonSize.lg,
            ),
            const SizedBox(height: ZolyaSpacing.xl),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: ZolyaTypography.body.copyWith(fontWeight: FontWeight.w700),
    );
  }
}

/// Vignettes (lecture seule) des photos déjà publiées en mode édition.
class _ExistingPhotosRow extends StatelessWidget {
  const _ExistingPhotosRow({required this.urls});
  final List<String> urls;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final placeholderColor =
        isLight ? ZolyaColors.surface2 : ZolyaColors.surface2Dark;

    return SizedBox(
      height: 72,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: urls.length,
        separatorBuilder: (_, __) => const SizedBox(width: ZolyaSpacing.sm),
        itemBuilder: (_, i) => ClipRRect(
          borderRadius: BorderRadius.circular(ZolyaRadius.sm),
          child: SizedBox(
            width: 72,
            height: 72,
            child: CachedNetworkImage(
              imageUrl: urls[i],
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(color: placeholderColor),
              errorWidget: (_, __, ___) => Container(color: placeholderColor),
            ),
          ),
        ),
      ),
    );
  }
}
