import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatelessWidget {
  final XFile? imageFile;
  final String? networkImageUrl;
  final VoidCallback onTap;
  final double size;
  final bool isLoading;

  const ImagePickerWidget({
    super.key,
    this.imageFile,
    this.networkImageUrl,
    required this.onTap,
    this.size = 120,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Main container with image or placeholder
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: colorScheme.primary.withOpacity(0.2),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: _buildImageContent(colorScheme),
            ),
          ),

          // Loading overlay
          if (isLoading)
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),

          // Camera icon overlay
          if (!isLoading)
            Positioned(
              bottom: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.camera_alt,
                  size: 20,
                  color: colorScheme.onPrimary,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImageContent(ColorScheme colorScheme) {
    // Priority: local file > network image > placeholder
    if (imageFile != null) {
      return _buildLocalImageWidget(colorScheme);
    } else if (networkImageUrl != null && networkImageUrl!.isNotEmpty) {
      return _buildNetworkImageWidget(colorScheme);
    } else {
      return _buildPlaceholderIcon(colorScheme);
    }
  }

  Widget _buildLocalImageWidget(ColorScheme colorScheme) {
    return FutureBuilder<Uint8List>(
      future: imageFile!.readAsBytes(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Image.memory(
            snapshot.data!,
            fit: BoxFit.cover,
            width: size,
            height: size,
            errorBuilder: (context, error, stackTrace) {
              return _buildPlaceholderIcon(colorScheme);
            },
          );
        } else if (snapshot.hasError) {
          return _buildPlaceholderIcon(colorScheme);
        } else {
          return const Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        }
      },
    );
  }

  Widget _buildNetworkImageWidget(ColorScheme colorScheme) {
    return Image.network(
      networkImageUrl!,
      fit: BoxFit.cover,
      width: size,
      height: size,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return _buildPlaceholderIcon(colorScheme);
      },
    );
  }

  Widget _buildPlaceholderIcon(ColorScheme colorScheme) {
    return Center(
      child: Icon(Icons.person, size: size * 0.4, color: Colors.grey.shade400),
    );
  }
}
