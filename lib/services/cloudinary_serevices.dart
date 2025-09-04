import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:quick_bite/constants/cloudinary_config.dart';

class CloudinaryService {
  /// Uploads image bytes to Cloudinary using signed upload (local signature).
  /// WARNING: This method uses your API secret in-app. For production, use server-side
  /// signing to avoid leaking secrets.
  Future<String> uploadImage(Uint8List imageBytes, String fileName) async {
    final timestamp = (DateTime.now().millisecondsSinceEpoch ~/ 1000)
        .toString();
    final publicId = 'products/${fileName.split('.').first}';

    // Signature string must be formed as "public_id=...&timestamp=..." + api_secret
    final signatureRaw =
        'public_id=$publicId&timestamp=$timestamp${CloudinaryConfig.apiSecret}';
    final signature = sha1.convert(utf8.encode(signatureRaw)).toString();

    final uri = Uri.parse(
      'https://api.cloudinary.com/v1_1/${CloudinaryConfig.cloudName}/image/upload',
    );
    final request = http.MultipartRequest('POST', uri);
    request.fields['api_key'] = CloudinaryConfig.apiKey;
    request.fields['timestamp'] = timestamp;
    request.fields['public_id'] = publicId;
    request.fields['signature'] = signature;

    request.files.add(
      http.MultipartFile.fromBytes('file', imageBytes, filename: fileName),
    );

    final streamed = await request.send();
    final resp = await http.Response.fromStream(streamed);

    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      final body = json.decode(resp.body) as Map<String, dynamic>;
      return body['secure_url'] as String;
    }

    String msg = 'Cloudinary upload failed: ${resp.statusCode}';
    try {
      final body = json.decode(resp.body);
      msg += ' - ${body.toString()}';
    } catch (_) {}
    throw Exception(msg);
  }
}
