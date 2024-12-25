import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
//
// class MediaPickerUtils {
//   final ImagePicker _picker = ImagePicker();
//   final int imageQuality = 50;
//
//   Future<List<File>> pickMedia({required MediaSource mediaSource, required MediaType mediaType, bool allowMultiple = false}) async {
//     List<File> files = [];
//
//     try {
//       if (!await requestAllPermissions()) return files;
//
//       if (allowMultiple) {
//         files = await _pickMultipleFiles(mediaType) ?? [];
//       } else {
//         var singleFile = await _pickSingleFile(mediaSource, mediaType);
//         if (singleFile != null) files.add(singleFile);
//       }
//     } catch (e) {
//       print('Error picking media: $e');
//     }
//
//     return files;
//   }
//
//   Future<List<File>?> _pickMultipleFiles(MediaType mediaType) async {
//     FilePickerResult? result;
//
//     if (mediaType == MediaType.image) {
//       result = await FilePicker.platform.pickFiles(type: FileType.image, allowMultiple: true);
//     } else if (mediaType == MediaType.video) {
//       result = await FilePicker.platform.pickFiles(type: FileType.video, allowMultiple: true);
//     } else {
//       result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4', 'mov'], allowMultiple: true);
//     }
//
//     return result?.paths.map((path) => File(path!)).toList();
//   }
//
//   Future<File?> _pickSingleFile(MediaSource mediaSource, MediaType mediaType) async {
//     if (mediaSource == MediaSource.camera) {
//       final pickedFile = mediaType == MediaType.image ? await _picker.pickImage(source: ImageSource.camera, imageQuality: imageQuality) : await _picker.pickVideo(source: ImageSource.camera);
//
//       return pickedFile != null ? File(pickedFile.path) : null;
//     } else {
//       if (mediaType == MediaType.image) {
//         final pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: imageQuality);
//         return pickedFile != null ? File(pickedFile.path) : null;
//       }
//       if (mediaType == MediaType.video) {
//         final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
//         return pickedFile != null ? File(pickedFile.path) : null;
//       }
//       if (mediaType == MediaType.both) {
//         FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4', 'mov']);
//         return result != null ? File(result.files.first.path!) : null;
//       }
//     }
//     return null;
//   }
//
//   Future<bool> requestAllPermissions() async {
//     if (!await _requestPermission(Permission.camera)) return false;
//
//     if (Platform.isAndroid) {
//       AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
//
//       if (androidInfo.version.sdkInt >= 33) {
//         /// For Android 13+ request Photos and Videos permissions
//         if (!await _requestPermission(Permission.photos)) return false;
//         if (!await _requestPermission(Permission.videos)) return false;
//       } else {
//         /// For Android versions below 33 request Storage permission
//         if (!await _requestPermission(Permission.storage)) return false;
//       }
//     } else if (Platform.isIOS) {
//       if (!await _requestPermission(Permission.photos)) return false;
//     }
//
//     return true;
//   }
//
//   Future<bool> _requestPermission(Permission permission) async {
//     var status = await permission.status;
//
//     if (status.isGranted) {
//       return true;
//     } else if (status.isPermanentlyDenied) {
//       openAppSettings();
//       return false;
//     }
//
//     status = await permission.request();
//     return status.isGranted;
//   }
// }
//
// enum MediaSource { camera, gallery }
//
// enum MediaType { image, video, both }



enum MediaSource { camera, gallery }

enum MediaType { image, video, both, document, all }

class MediaPickerUtils {
  final ImagePicker _picker = ImagePicker();

  static Future<bool> _requestPermission(MediaSource type, BuildContext context) async {
    Permission permission;
    switch (type) {
      case MediaSource.camera:
        permission = Permission.camera;
        break;
      case MediaSource.gallery:
        permission = Platform.isAndroid && (await DeviceInfoPlugin().androidInfo).version.sdkInt >= 33 ? Permission.photos : Permission.storage;
        break;
    }

    return await _checkAndRequestPermission(permission, type.name, context);
  }

  static Future<bool> _checkAndRequestPermission(Permission permission, String type, BuildContext context) async {
    final status = await permission.status;
    log("$type permission status: $status");

    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      final result = await permission.request();
      return result.isGranted;
    } else if (status.isPermanentlyDenied) {
      await _showPermissionDialog("Please enable $type permission in app settings.", context);
      return false;
    }
    return false;
  }

  static Future<void> _showPermissionDialog(String message, BuildContext context) async {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Permission Required"),
        content: Text(message),
        actions: [
          TextButton(onPressed: Navigator.of(context).pop, child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              openAppSettings();
            },
            child: const Text("Open Settings"),
          ),
        ],
      ),
    );
  }

  Future<List<Map<String, dynamic>>> pickMedia({
    required MediaSource mediaSource,
    required MediaType mediaType,
    bool allowMultiple = false,
    bool enableImageCropping = false,
    CropStyle cropStyle = CropStyle.rectangle,
    required BuildContext context,
  }) async {
    List<Map<String, dynamic>> filesData = [];

    try {
      final allowCamera = mediaSource == MediaSource.camera;
      final allowGallery = mediaSource == MediaSource.gallery;

      final hasStoragePermission = allowGallery ? await _requestPermission(MediaSource.gallery, context) : true;
      final hasCameraPermission = allowCamera ? await _requestPermission(MediaSource.camera, context) : true;

      if (!hasStoragePermission || !hasCameraPermission) {
        debugPrint("Storage or camera permission denied.");
        return [];
      }

      List<File> files;
      if (mediaSource == MediaSource.gallery && mediaType == MediaType.image && allowMultiple) {
        // Select multiple images from gallery
        final pickedFiles = await _picker.pickMultiImage();
        if (pickedFiles != null) {
          files = pickedFiles.map((xfile) => File(xfile.path)).toList();
        } else {
          files = [];
        }
      } else if (mediaSource == MediaSource.gallery && mediaType == MediaType.video && allowMultiple) {
        // Select multiple videos from gallery
        files = await _pickMultipleFiles(MediaType.video) ?? [];
      } else if (mediaSource == MediaSource.gallery && mediaType == MediaType.both && allowMultiple) {
        // Select multiple images or videos from gallery
        files = await _pickMultipleFiles(MediaType.both) ?? [];
      } else if (mediaSource == MediaSource.gallery && mediaType == MediaType.document && allowMultiple) {
        // Select multiple document files from gallery
        files = await _pickMultipleFiles(MediaType.document) ?? [];
      } else if (mediaSource == MediaSource.gallery && mediaType == MediaType.all && allowMultiple) {
        // Select multiple files (image, video, document) from gallery
        files = await _pickMultipleFiles(MediaType.all) ?? [];
      } else {
        // Handle single file selection
        var singleFile = await _pickSingleFile(mediaSource, mediaType);
        files = singleFile != null ? [singleFile] : [];
      }

      for (var file in files) {
        String? filePath = file.path;

        // Crop image if enabled
        if (enableImageCropping && mediaType == MediaType.image) {
          filePath = await _cropImage(filePath, cropStyle);
          if (filePath == null) continue;
        }

        final base64Data = base64Encode(await File(filePath).readAsBytes());
        filesData.add({
          'path': filePath,
          'base64': 'data:${_getMimeType(filePath)};base64,$base64Data',
          'name': filePath.split('/').last,
          'extension': filePath.split('.').last,
          'size': await File(filePath).length(),
        });
      }
    } catch (e) {
      log('Error picking media: $e');
      return Future.error('An error occurred while picking media');
    }

    return filesData;
  }

  Future<File?> _pickSingleFile(MediaSource mediaSource, MediaType mediaType) async {
    XFile? pickedFile;

    if (mediaType == MediaType.image || mediaType == MediaType.video) {
      final source = mediaSource == MediaSource.camera ? ImageSource.camera : ImageSource.gallery;
      pickedFile = mediaType == MediaType.image ? await _picker.pickImage(source: source) : await _picker.pickVideo(source: source);
    } else if (mediaType == MediaType.both) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4', 'mov'],
      );
      if (result != null && result.paths.isNotEmpty) {
        return File(result.paths.first!);
      }
    } else if (mediaType == MediaType.document) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'txt', 'xlsx'],
      );
      if (result != null && result.paths.isNotEmpty) {
        return File(result.paths.first!);
      }
    } else if (mediaType == MediaType.all) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4', 'mov', 'pdf', 'doc', 'docx', 'txt', 'xlsx'],
      );
      if (result != null && result.paths.isNotEmpty) {
        return File(result.paths.first!);
      }
    }

    return pickedFile != null ? File(pickedFile.path) : null;
  }

  Future<List<File>?> _pickMultipleFiles(MediaType mediaType) async {
    FilePickerResult? result;
    if (mediaType == MediaType.image) {
      result = await FilePicker.platform.pickFiles(type: FileType.image, allowMultiple: true);
    } else if (mediaType == MediaType.video) {
      result = await FilePicker.platform.pickFiles(type: FileType.video, allowMultiple: true);
    } else if (mediaType == MediaType.both) {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4', 'mov'],
        allowMultiple: true,
      );
    } else if (mediaType == MediaType.document) {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'txt', 'xlsx'],
        allowMultiple: true,
      );
    } else if (mediaType == MediaType.all) {
      result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        // allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4', 'mov', 'pdf', 'doc', 'docx', 'txt', 'xlsx'],
        allowMultiple: true,
      );
    }
    return result?.paths.map((path) => File(path!)).toList();
  }

  Future<String?> _cropImage(String path, CropStyle style) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      // cropStyle: style,
      compressQuality: 90,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.blue,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Crop Image',
          minimumAspectRatio: 1.0,
        ),
      ],
    );
    return croppedFile?.path;
  }

  String _getMimeType(String path) {
    final extension = path.split('.').last.toLowerCase();
    if (['jpg', 'jpeg', 'png'].contains(extension)) return 'image/$extension';
    if (['mp4', 'mov'].contains(extension)) return 'video/$extension';
    return 'application/octet-stream';
  }
}
