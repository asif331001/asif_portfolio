import 'package:file_saver/file_saver.dart';
import 'package:flutter/services.dart';

abstract final class ResumeDownloadService {
  const ResumeDownloadService._();

  static const String assetPath = 'assets/resume/asif_ahmed_resume.pdf';

  static Future<bool> download() async {
    try {
      final data = await rootBundle.load(assetPath);

      final bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );

      await FileSaver.instance.saveFile(
        name: 'MD_Asif_Ahmed_Resume',
        bytes: bytes,
        fileExtension: 'pdf',
        mimeType: MimeType.pdf,
      );

      return true;
    } catch (_) {
      return false;
    }
  }
}
