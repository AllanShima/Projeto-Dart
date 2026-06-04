export 'qr_download_stub.dart'
    if (dart.library.html) 'qr_download_web.dart'
    if (dart.library.io) 'qr_download_mobile.dart';
