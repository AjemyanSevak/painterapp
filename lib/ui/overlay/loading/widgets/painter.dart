import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:painter_app/base/base.dart';
import 'package:share_plus/share_plus.dart';

class CanvasPainterPage extends StatefulWidget {
  /// The title displayed in the app bar. Defaults to 'Drawing Canvas'.
  final String? title;

  /// The initial color for drawing strokes. Defaults to black.
  final Color initialColor;

  /// The initial brush size in pixels. Defaults to 8.0.
  final double initialBrushSize;

  /// Whether to show the built-in app bar with drawing tools.
  /// Set to false when embedding the canvas in a custom layout.
  final bool showAppBar;

  /// Additional custom action buttons to add to the app bar.
  /// These will appear after the built-in drawing tools.
  final List<Widget>? customActions;

  /// Callback function called when the user exports the canvas.
  /// Receives the canvas as PNG image bytes (Uint8List).
  /// If null, no export button will be shown.
  final Function(Uint8List imageBytes)? onExport;

  final String? imageUrl;

  /// Creates a professional drawing canvas widget.
  ///
  /// All parameters are optional with sensible defaults.
  /// The [onExport] callback enables the export functionality.
  const CanvasPainterPage({
    super.key,
    this.title = 'Drawing Canvas',
    this.initialColor = Colors.black,
    this.initialBrushSize = 8.0,
    this.showAppBar = true,
    this.customActions,
    this.onExport,
    this.imageUrl,
  });

  @override
  State<CanvasPainterPage> createState() => CanvasPainterPageState();
}

/// Private state class for the CanvasPainterPage.
///
/// Manages all the drawing state, user interactions, and rendering logic.
/// Uses efficient state management to ensure smooth drawing performance.
class CanvasPainterPageState extends State<CanvasPainterPage> {
  /// Global key for RepaintBoundary to enable high-quality image export
  final GlobalKey _repaintBoundaryKey = GlobalKey();

  // Drawing State Management
  /// List of all completed drawing strokes (both brush and eraser strokes)
  List<DrawnLine> lines = [];

  /// The currently active stroke being drawn (null when not drawing)
  DrawnLine? currentLine;

  /// Currently selected drawing color
  late Color selectedColor;

  /// Current brush/eraser stroke width in pixels
  late double strokeWidth;

  /// Whether the user is in eraser mode (true) or drawing mode (false)
  bool isEraser = false;

  // Background Image Management
  /// The selected background image file (if any)
  File? selectedImage;

  /// The decoded UI image for rendering (if any)
  ui.Image? backgroundImage;

  /// Image picker instance for selecting background images
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Initialize drawing parameters from widget configuration
    selectedColor = widget.initialColor;
    strokeWidth = widget.initialBrushSize;
    // Load background image from URL if provided
    if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty) {
      loadImageFromUrl(widget.imageUrl!);
    }
  }

  // ===== DRAWING INTERACTION METHODS =====

  /// Handles the start of a drawing gesture (when user touches the screen).
  ///
  /// Creates a new stroke with the current tool settings (brush or eraser).
  /// For eraser mode, creates a transparent stroke that will use BlendMode.clear.
  /// For drawing mode, creates a colored stroke with the selected color.
  void startLine(Offset offset) {
    if (isEraser) {
      // Create eraser stroke - color doesn't matter as it uses BlendMode.clear
      currentLine = DrawnLine(
        path: [offset],
        color: Colors.transparent,
        strokeWidth: strokeWidth,
        isEraser: true,
      );
    } else {
      // Create drawing stroke with selected color
      currentLine = DrawnLine(
        path: [offset],
        color: selectedColor,
        strokeWidth: strokeWidth,
        isEraser: false,
      );
    }
  }

  /// Loads an image from URL and sets it as background.
  /// Simple method using Image.network for basic URL image loading.
  void loadImageFromUrl(String imageUrl) {
    // Use NetworkImage to load the image
    final NetworkImage networkImage = NetworkImage(imageUrl);
    networkImage
        .resolve(const ImageConfiguration())
        .addListener(
          ImageStreamListener((ImageInfo info, bool _) {
            setState(() {
              backgroundImage = info.image;
              selectedImage = null; // Clear local file reference
            });
          }),
        );
  }

  /// Handles the continuation of a drawing gesture (when user drags across screen).
  ///
  /// Adds new points to the current stroke path for smooth line rendering.
  /// Triggers rebuild to show real-time drawing feedback.
  void updateLine(Offset offset) {
    setState(() {
      currentLine?.path.add(offset);
    });
  }

  /// Handles the end of a drawing gesture (when user lifts finger).
  ///
  /// Commits the current stroke to the permanent lines list.
  /// Both drawing and eraser strokes are stored - the difference is in rendering.
  void endLine() {
    if (currentLine != null) {
      // Add the completed stroke to our permanent collection
      lines.add(currentLine!);
      currentLine = null; // Clear current stroke
    }
  }

  // ===== BACKGROUND IMAGE MANAGEMENT =====

  /// Prompts user to select an image from the device gallery.
  ///
  /// Uses the image_picker package to access device photo library.
  /// Selected image will be decoded and set as canvas background.
  /// Maintains aspect ratio and centers the image on canvas.
  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85, // Optimize for performance while maintaining quality
      );

      if (image != null) {
        final file = File(image.path);
        await _loadImageFromFile(file);
      }
    } catch (e) {
      debugPrint('Error picking image from gallery: $e');
      // In a production app, you might want to show an error dialog here
    }
  }

  /// Loads and decodes an image file for use as canvas background.
  ///
  /// Converts the image file to a UI Image object that can be rendered
  /// on the canvas. Handles image decoding asynchronously to avoid UI blocking.
  ///
  /// [file] The image file to load and decode
  Future<void> _loadImageFromFile(File file) async {
    try {
      final bytes = await file.readAsBytes();
      final ui.Codec codec = await ui.instantiateImageCodec(bytes);
      final ui.FrameInfo frameInfo = await codec.getNextFrame();

      setState(() {
        selectedImage = file;
        backgroundImage = frameInfo.image;
      });
    } catch (e) {
      debugPrint('Error loading image file: $e');
      // In production, show user-friendly error message
    }
  }

  /// Removes the current background image from the canvas.
  ///
  /// Clears both the file reference and the decoded UI image,
  /// returning the canvas to a white background.
  void removeBackgroundImage() {
    setState(() {
      selectedImage = null;
      backgroundImage = null;
    });
  }

  // ===== USER INTERFACE DIALOGS =====

  /// Shows a comprehensive color picker dialog.
  ///
  /// Uses the flutter_colorpicker package to provide a full-featured
  /// color selection interface including color wheel, RGB sliders, and hex input.
  /// Automatically switches from eraser to drawing mode when color is selected.
  void selectColor() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Pick a Color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: selectedColor,
            onColorChanged: (color) {
              setState(() {
                selectedColor = color;
                isEraser = false; // Auto-switch to drawing mode
              });
            },
            // Enable all color picker features
            enableAlpha: false, // Disable alpha for simplicity
            displayThumbColor: true,

            paletteType: PaletteType.hsv,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  /// Shows a brush size adjustment dialog with real-time preview.
  ///
  /// Provides a slider for precise brush size control with live preview
  /// of the current size value. Range is 1-30 pixels for optimal usability.
  void _showBrushSizeDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Brush Size'),
        content: StatefulBuilder(
          builder: (context, setDialogState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Size: ${strokeWidth.round()}px'),
              const SizedBox(height: 16),
              Slider(
                value: strokeWidth,
                min: 1.0,
                max: 30.0,
                divisions: 29,
                label: '${strokeWidth.round()}px',
                onChanged: (value) {
                  setDialogState(() {
                    setState(() {
                      strokeWidth = value;
                    });
                  });
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  // ===== PUBLIC API METHODS =====

  /// Clears all drawings from the canvas.
  ///
  /// Removes all strokes (both drawing and eraser) while preserving
  /// the background image if present. This action cannot be undone.
  void clearCanvas() {
    setState(() {
      lines.clear();
    });
  }

  /// Returns a copy of the current drawing data.
  ///
  /// Useful for saving/loading drawings or implementing undo functionality.
  /// Returns a list of DrawnLine objects representing all strokes on canvas.
  ///
  List<DrawnLine> getDrawing() {
    return List<DrawnLine>.from(lines);
  }

  /// Loads a drawing from provided DrawnLine data.
  ///
  /// Replaces the current drawing with the provided strokes.
  /// Useful for loading saved drawings or implementing undo/redo.
  ///
  /// [drawing] The list of DrawnLine objects to load onto canvas
  void setDrawing(List<DrawnLine> drawing) {
    setState(() {
      lines = List<DrawnLine>.from(drawing);
    });
  }

  // ===== IMAGE EXPORT FUNCTIONALITY =====

  /// Exports the current canvas as high-quality PNG image bytes.
  ///
  /// Captures the entire canvas including background image and all drawings
  /// using RepaintBoundary for pixel-perfect export. The resulting image
  /// maintains the exact visual representation of the canvas.
  ///
  /// [pixelRatio] Controls export resolution (higher = better quality, larger file)
  /// - 1.0: Standard resolution
  /// - 2.0: Retina/high-DPI resolution
  /// - 3.0: Ultra-high resolution (default for crisp exports)
  ///
  /// Returns: Uint8List? - PNG image bytes, null if export fails
  Future<Uint8List?> exportAsImage({double pixelRatio = 3.0}) async {
    try {
      // Get the RepaintBoundary render object
      final RenderRepaintBoundary boundary =
          _repaintBoundaryKey.currentContext?.findRenderObject()
              as RenderRepaintBoundary;

      // Convert to image with specified quality
      final ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);

      // Convert to PNG bytes
      final ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      if (byteData != null) {
        return byteData.buffer.asUint8List();
      }
    } catch (e) {
      debugPrint('Error exporting canvas as image: $e');
      // In production, you might want to show an error dialog to the user
    }
    return null;
  }

  /// Handles the export button press and triggers the callback.
  ///
  /// Internal method that exports the canvas and calls the user-provided
  /// onExport callback with the resulting image bytes.
  // Future<void> _handleExport() async {
  //   if (widget.onExport != null) {
  //     final imageBytes = await exportAsImage();
  //     if (imageBytes != null) {
  //       widget.onExport!(imageBytes);
  //     } else {
  //       debugPrint('Failed to export canvas - no image bytes generated');
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final canvasWidget = RepaintBoundary(
      key: _repaintBoundaryKey,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: GestureDetector(
          onPanStart: (details) => startLine(details.localPosition),
          onPanUpdate: (details) => updateLine(details.localPosition),
          onPanEnd: (_) => endLine(),
          child: CustomPaint(
            painter: DrawingPainter(
              lines: lines,
              currentLine: currentLine,
              backgroundImage: backgroundImage,
            ),
            child: Container(),
          ),
        ),
      ),
    );

    if (!widget.showAppBar) {
      return canvasWidget;
    }

    return Column(
      children: [
        SizedBox(
          height: 86,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  overlayColor: WidgetStatePropertyAll(
                    AppColors.white.withValues(alpha: 0.5),
                  ),
                  child: Container(
                    height: 38,
                    width: 38,
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Image.asset(
                        AppAssets.share,
                        width: 20,
                        height: 20,
                        color: AppColors.whiter,
                      ),
                    ),
                  ),
                  onTap: () {
                    Size size = MediaQuery.of(context).size;
                    double screenWidth = size.width;
                    double screenHeight = size.height;
                    exportAsImage().then((byteData) {
                      if (byteData != null) {
                        try {
                          SharePlus.instance.share(
                            ShareParams(
                              files: [
                                XFile.fromData(
                                  byteData.buffer.asUint8List(),
                                  mimeType: 'image/png', //
                                ),
                              ],
                              sharePositionOrigin: Rect.fromLTWH(
                                0,
                                0,
                                screenWidth,
                                screenHeight,
                              ),
                            ),
                          );
                        } catch (e) {
                          debugPrint('Failed to share');
                        }
                      } else {
                        debugPrint(
                          'Failed to export canvas - no image bytes generated',
                        );
                      }
                    });
                  },
                ),
              ),
              SizedBox(width: 12),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  overlayColor: WidgetStatePropertyAll(
                    AppColors.white.withValues(alpha: 0.5),
                  ),
                  child: Container(
                    height: 38,
                    width: 38,
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Image.asset(
                        AppAssets.gallery,
                        width: 20,
                        height: 20,
                        color: AppColors.whiter,
                      ),
                    ),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Select Image'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: Icon(Icons.photo_library),
                              title: Text('From Gallery'),
                              onTap: () {
                                Navigator.pop(context);
                                pickImageFromGallery();
                              },
                            ),
                            if (backgroundImage != null)
                              ListTile(
                                leading: Icon(Icons.delete),
                                title: Text('Remove Image'),
                                onTap: () {
                                  Navigator.pop(context);
                                  removeBackgroundImage();
                                },
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 12),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  overlayColor: WidgetStatePropertyAll(
                    AppColors.white.withValues(alpha: 0.5),
                  ),
                  onTap: _showBrushSizeDialog,
                  child: Container(
                    height: 38,
                    width: 38,
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.line_weight,
                        size: 20,
                        color: AppColors.whiter,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              InkWell(
                borderRadius: BorderRadius.circular(100),
                overlayColor: WidgetStatePropertyAll(
                  AppColors.white.withValues(alpha: 0.5),
                ),
                onTap: () {
                  setState(() {
                    isEraser = false;
                    strokeWidth = 8.0;
                  });
                },
                child: Container(
                  height: 38,
                  width: 38,
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: Image.asset(
                      AppAssets.pan,
                      width: 20,
                      height: 20,
                      color: isEraser ? AppColors.whiter : AppColors.secondary,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              InkWell(
                borderRadius: BorderRadius.circular(100),
                overlayColor: WidgetStatePropertyAll(
                  AppColors.white.withValues(alpha: 0.5),
                ),
                onTap: () {
                  setState(() {
                    isEraser = true;
                    strokeWidth = 20.0;
                  });
                },
                child: Container(
                  height: 38,
                  width: 38,
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: Image.asset(
                      AppAssets.eraiser,
                      width: 20,
                      height: 20,
                      color: isEraser ? AppColors.secondary : AppColors.whiter,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  overlayColor: WidgetStatePropertyAll(
                    AppColors.white.withValues(alpha: 0.5),
                  ),
                  onTap: selectColor,
                  child: Container(
                    height: 38,
                    width: 38,
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Image.asset(
                        AppAssets.picker,
                        width: 20,
                        height: 20,
                        color: AppColors.whiter,
                      ),
                    ),
                  ),
                ),
              ),

              // IconButton(
              //   icon: Icon(Icons.delete),
              //   onPressed: clearCanvas,
              //   tooltip: 'Clear All',
              // ),
              ...?widget.customActions,
              SizedBox(width: 12),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(20),
              child: canvasWidget,
            ),
          ),
        ),
      ],
    );
  }
}

/// Represents a single drawing stroke with complete visual properties.
///
/// This class encapsulates all the information needed to render a drawing stroke,
/// including the path coordinates, visual properties, and tool type. It supports
/// both regular drawing strokes and eraser strokes for complete drawing functionality.
///
/// Properties:
/// - [path]: Sequential list of coordinate points forming the stroke
/// - [color]: Drawing color (ignored for eraser strokes)
/// - [strokeWidth]: Thickness of the stroke in logical pixels
/// - [isEraser]: Flag indicating if this is an eraser stroke (uses blend mode clear)
class DrawnLine {
  /// The sequence of coordinate points that make up this stroke.
  /// Points are connected to form a smooth path during rendering.
  final List<Offset> path;

  /// The color used for drawing this stroke.
  /// This value is ignored when [isEraser] is true.
  final Color color;

  /// The width/thickness of the stroke in logical pixels.
  /// Controls how thick the line appears on screen and in exports.
  final double strokeWidth;

  /// Whether this stroke represents an eraser action.
  /// When true, the stroke will be rendered with BlendMode.clear to erase content.
  final bool isEraser;

  /// Creates a new DrawnLine with the specified properties.
  ///
  /// [path] must contain at least one point to create a valid stroke.
  /// [color] and [strokeWidth] define the visual appearance for drawing strokes.
  /// [isEraser] defaults to false for regular drawing strokes.
  DrawnLine({
    required this.path,
    required this.color,
    required this.strokeWidth,
    this.isEraser = false,
  });
}

/// Professional-grade custom painter for rendering the complete drawing canvas.
///
/// This painter handles the sophisticated rendering of all canvas elements including:
/// - Background images with proper scaling and aspect ratio preservation
/// - Multi-layered drawing system supporting both drawing and erasing operations
/// - Real-time stroke rendering during active drawing gestures
/// - Blend mode operations for true transparent erasing functionality
///
/// The painter uses Flutter's layer system to ensure proper erasing behavior
/// and maintains high performance through efficient canvas state management.
class DrawingPainter extends CustomPainter {
  /// Complete list of finished drawing strokes.
  /// Each stroke maintains its own visual properties and tool type.
  final List<DrawnLine> lines;

  /// Currently active stroke being drawn (null when not drawing).
  /// Provides real-time visual feedback during drawing gestures.
  final DrawnLine? currentLine;

  /// Optional background image to display behind all drawings.
  /// When present, automatically scaled to fit the canvas dimensions while preserving aspect ratio.
  final ui.Image? backgroundImage;

  /// Creates a new DrawingPainter with the specified canvas content.
  ///
  /// [lines] should contain all completed strokes in drawing order.
  /// [currentLine] represents the active stroke during drawing gestures.
  /// [backgroundImage] will be scaled to fit the canvas if provided.
  DrawingPainter({required this.lines, this.currentLine, this.backgroundImage});

  @override
  void paint(Canvas canvas, Size size) {
    // Step 1: Render background image if available
    // This provides the base layer for all subsequent drawing operations
    if (backgroundImage != null) {
      _drawBackgroundImage(canvas, size);
    }

    // Step 2: Create a compositing layer for blend mode operations
    // This is essential for proper eraser functionality using BlendMode.clear
    final layerBounds = Offset.zero & size;
    canvas.saveLayer(layerBounds, Paint());

    // Step 3: Render all completed strokes in chronological order
    // This maintains proper layering and visual history
    for (var line in lines) {
      if (line.path.isNotEmpty) {
        _drawStroke(canvas, line);
      }
    }

    // Step 4: Render the active stroke for real-time feedback
    // Shows the current drawing gesture as it's being performed
    if (currentLine != null && currentLine!.path.isNotEmpty) {
      _drawStroke(canvas, currentLine!);
    }

    // Step 5: Restore canvas state and finalize rendering
    // Composite the layer over the background to complete the frame
    canvas.restore();
  }

  /// Renders the background image with proper aspect ratio preservation.
  ///
  /// Calculates optimal scaling to fit the image within canvas bounds while
  /// maintaining the original aspect ratio. Centers the image for balanced composition.
  void _drawBackgroundImage(Canvas canvas, Size size) {
    final double imageWidth = backgroundImage!.width.toDouble();
    final double imageHeight = backgroundImage!.height.toDouble();

    // Calculate uniform scale factor to maintain aspect ratio
    // Uses the smaller scale to ensure the entire image fits within bounds
    final double scaleX = size.width / imageWidth;
    final double scaleY = size.height / imageHeight;
    final double scale = scaleX < scaleY ? scaleX : scaleY;

    // Calculate final dimensions after scaling
    final double scaledWidth = imageWidth * scale;
    final double scaledHeight = imageHeight * scale;

    // Center the scaled image within the canvas
    final double dx = (size.width - scaledWidth) / 2;
    final double dy = (size.height - scaledHeight) / 2;

    // Define rendering rectangles
    final Rect destRect = Rect.fromLTWH(dx, dy, scaledWidth, scaledHeight);
    final Rect srcRect = Rect.fromLTWH(0, 0, imageWidth, imageHeight);

    // Render the background image
    canvas.drawImageRect(backgroundImage!, srcRect, destRect, Paint());
  }

  /// Renders a single drawing stroke with proper visual properties.
  ///
  /// Handles both regular drawing strokes and eraser strokes using appropriate
  /// blend modes. Creates smooth paths by connecting all points in the stroke.
  ///
  /// [line] The DrawnLine object containing path and visual properties
  void _drawStroke(Canvas canvas, DrawnLine line) {
    // Configure paint with stroke properties and blend mode
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = line.strokeWidth
      ..strokeCap = StrokeCap
          .round // Rounded line endings for smooth appearance
      ..strokeJoin = StrokeJoin
          .round // Rounded line connections for smooth curves
      ..color = line.isEraser ? Colors.transparent : line.color
      ..blendMode = line.isEraser ? BlendMode.clear : BlendMode.srcOver;

    // Build path from coordinate points
    final path = Path();
    if (line.path.isNotEmpty) {
      // Start the path at the first point
      path.moveTo(line.path[0].dx, line.path[0].dy);

      // Connect to all subsequent points for smooth continuous lines
      for (int i = 1; i < line.path.length; i++) {
        path.lineTo(line.path[i].dx, line.path[i].dy);
      }

      // Render the complete stroke to canvas
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) {
    // Always repaint to ensure real-time drawing updates
    // In production, you might optimize this by comparing the actual data
    return true;
  }
}
