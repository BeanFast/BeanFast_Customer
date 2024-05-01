class UserQrCode {
  String? qrCode;
  DateTime? qrCodeExpiry;

  UserQrCode({
    required this.qrCode,
    required this.qrCodeExpiry,
  });

  factory UserQrCode.fromJson(dynamic json) => UserQrCode(
        qrCode: json['qrCode'],
        qrCodeExpiry: json['qrCodeExpiry'] == null
            ? null
            : DateTime.parse(json['qrCodeExpiry']),
      );
}
