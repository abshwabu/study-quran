class PackManifestItem {
  final String packId;
  final String type; // translation, tafsir, audio, morphology
  final String name;
  final String version;
  final String downloadUrl;
  final int sizeBytes;
  final String licenseNote;

  PackManifestItem({
    required this.packId,
    required this.type,
    required this.name,
    required this.version,
    required this.downloadUrl,
    required this.sizeBytes,
    required this.licenseNote,
  });

  factory PackManifestItem.fromJson(Map<String, dynamic> json) {
    return PackManifestItem(
      packId: json['pack_id'] as String,
      type: json['type'] as String,
      name: json['name'] as String,
      version: json['version'] as String,
      downloadUrl: json['download_url'] as String,
      sizeBytes: json['size_bytes'] as int,
      licenseNote: json['license_note'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pack_id': packId,
      'type': type,
      'name': name,
      'version': version,
      'download_url': downloadUrl,
      'size_bytes': sizeBytes,
      'license_note': licenseNote,
    };
  }
}

class PackManifest {
  final String manifestVersion;
  final String generatedAt;
  final List<PackManifestItem> packs;

  PackManifest({
    required this.manifestVersion,
    required this.generatedAt,
    required this.packs,
  });

  factory PackManifest.fromJson(Map<String, dynamic> json) {
    return PackManifest(
      manifestVersion: json['manifest_version'] as String,
      generatedAt: json['generated_at'] as String,
      packs: (json['packs'] as List)
          .map((item) => PackManifestItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
