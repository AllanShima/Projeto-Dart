import 'dart:js_interop';
import 'dart:typed_data';
import 'package:web/web.dart' as web;

Future<void> downloadFile(List<int> bytes, String fileName) async {
  final uint8list = Uint8List.fromList(bytes);
  final blob = web.Blob(
    [uint8list.toJS].toJS,
    web.BlobPropertyBag(type: 'image/png'),
  );
  final url = web.URL.createObjectURL(blob);
  (web.document.createElement('a') as web.HTMLAnchorElement)
    ..href = url
    ..download = fileName
    ..click();
  web.URL.revokeObjectURL(url);
}
