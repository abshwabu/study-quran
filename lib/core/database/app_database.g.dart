// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SurahsTable extends Surahs with TableInfo<$SurahsTable, Surah> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SurahsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<int> number = GeneratedColumn<int>(
    'number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameArabicMeta = const VerificationMeta(
    'nameArabic',
  );
  @override
  late final GeneratedColumn<String> nameArabic = GeneratedColumn<String>(
    'name_arabic',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameTranslitMeta = const VerificationMeta(
    'nameTranslit',
  );
  @override
  late final GeneratedColumn<String> nameTranslit = GeneratedColumn<String>(
    'name_translit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameTranslationMeta = const VerificationMeta(
    'nameTranslation',
  );
  @override
  late final GeneratedColumn<String> nameTranslation = GeneratedColumn<String>(
    'name_translation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _revelationPlaceMeta = const VerificationMeta(
    'revelationPlace',
  );
  @override
  late final GeneratedColumn<String> revelationPlace = GeneratedColumn<String>(
    'revelation_place',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ayahCountMeta = const VerificationMeta(
    'ayahCount',
  );
  @override
  late final GeneratedColumn<int> ayahCount = GeneratedColumn<int>(
    'ayah_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    number,
    nameArabic,
    nameTranslit,
    nameTranslation,
    revelationPlace,
    ayahCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'surahs';
  @override
  VerificationContext validateIntegrity(
    Insertable<Surah> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('number')) {
      context.handle(
        _numberMeta,
        number.isAcceptableOrUnknown(data['number']!, _numberMeta),
      );
    }
    if (data.containsKey('name_arabic')) {
      context.handle(
        _nameArabicMeta,
        nameArabic.isAcceptableOrUnknown(data['name_arabic']!, _nameArabicMeta),
      );
    } else if (isInserting) {
      context.missing(_nameArabicMeta);
    }
    if (data.containsKey('name_translit')) {
      context.handle(
        _nameTranslitMeta,
        nameTranslit.isAcceptableOrUnknown(
          data['name_translit']!,
          _nameTranslitMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nameTranslitMeta);
    }
    if (data.containsKey('name_translation')) {
      context.handle(
        _nameTranslationMeta,
        nameTranslation.isAcceptableOrUnknown(
          data['name_translation']!,
          _nameTranslationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nameTranslationMeta);
    }
    if (data.containsKey('revelation_place')) {
      context.handle(
        _revelationPlaceMeta,
        revelationPlace.isAcceptableOrUnknown(
          data['revelation_place']!,
          _revelationPlaceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_revelationPlaceMeta);
    }
    if (data.containsKey('ayah_count')) {
      context.handle(
        _ayahCountMeta,
        ayahCount.isAcceptableOrUnknown(data['ayah_count']!, _ayahCountMeta),
      );
    } else if (isInserting) {
      context.missing(_ayahCountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {number};
  @override
  Surah map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Surah(
      number: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}number'],
      )!,
      nameArabic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_arabic'],
      )!,
      nameTranslit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_translit'],
      )!,
      nameTranslation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_translation'],
      )!,
      revelationPlace: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}revelation_place'],
      )!,
      ayahCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ayah_count'],
      )!,
    );
  }

  @override
  $SurahsTable createAlias(String alias) {
    return $SurahsTable(attachedDatabase, alias);
  }
}

class Surah extends DataClass implements Insertable<Surah> {
  final int number;
  final String nameArabic;
  final String nameTranslit;
  final String nameTranslation;
  final String revelationPlace;
  final int ayahCount;
  const Surah({
    required this.number,
    required this.nameArabic,
    required this.nameTranslit,
    required this.nameTranslation,
    required this.revelationPlace,
    required this.ayahCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['number'] = Variable<int>(number);
    map['name_arabic'] = Variable<String>(nameArabic);
    map['name_translit'] = Variable<String>(nameTranslit);
    map['name_translation'] = Variable<String>(nameTranslation);
    map['revelation_place'] = Variable<String>(revelationPlace);
    map['ayah_count'] = Variable<int>(ayahCount);
    return map;
  }

  SurahsCompanion toCompanion(bool nullToAbsent) {
    return SurahsCompanion(
      number: Value(number),
      nameArabic: Value(nameArabic),
      nameTranslit: Value(nameTranslit),
      nameTranslation: Value(nameTranslation),
      revelationPlace: Value(revelationPlace),
      ayahCount: Value(ayahCount),
    );
  }

  factory Surah.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Surah(
      number: serializer.fromJson<int>(json['number']),
      nameArabic: serializer.fromJson<String>(json['nameArabic']),
      nameTranslit: serializer.fromJson<String>(json['nameTranslit']),
      nameTranslation: serializer.fromJson<String>(json['nameTranslation']),
      revelationPlace: serializer.fromJson<String>(json['revelationPlace']),
      ayahCount: serializer.fromJson<int>(json['ayahCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'number': serializer.toJson<int>(number),
      'nameArabic': serializer.toJson<String>(nameArabic),
      'nameTranslit': serializer.toJson<String>(nameTranslit),
      'nameTranslation': serializer.toJson<String>(nameTranslation),
      'revelationPlace': serializer.toJson<String>(revelationPlace),
      'ayahCount': serializer.toJson<int>(ayahCount),
    };
  }

  Surah copyWith({
    int? number,
    String? nameArabic,
    String? nameTranslit,
    String? nameTranslation,
    String? revelationPlace,
    int? ayahCount,
  }) => Surah(
    number: number ?? this.number,
    nameArabic: nameArabic ?? this.nameArabic,
    nameTranslit: nameTranslit ?? this.nameTranslit,
    nameTranslation: nameTranslation ?? this.nameTranslation,
    revelationPlace: revelationPlace ?? this.revelationPlace,
    ayahCount: ayahCount ?? this.ayahCount,
  );
  Surah copyWithCompanion(SurahsCompanion data) {
    return Surah(
      number: data.number.present ? data.number.value : this.number,
      nameArabic: data.nameArabic.present
          ? data.nameArabic.value
          : this.nameArabic,
      nameTranslit: data.nameTranslit.present
          ? data.nameTranslit.value
          : this.nameTranslit,
      nameTranslation: data.nameTranslation.present
          ? data.nameTranslation.value
          : this.nameTranslation,
      revelationPlace: data.revelationPlace.present
          ? data.revelationPlace.value
          : this.revelationPlace,
      ayahCount: data.ayahCount.present ? data.ayahCount.value : this.ayahCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Surah(')
          ..write('number: $number, ')
          ..write('nameArabic: $nameArabic, ')
          ..write('nameTranslit: $nameTranslit, ')
          ..write('nameTranslation: $nameTranslation, ')
          ..write('revelationPlace: $revelationPlace, ')
          ..write('ayahCount: $ayahCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    number,
    nameArabic,
    nameTranslit,
    nameTranslation,
    revelationPlace,
    ayahCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Surah &&
          other.number == this.number &&
          other.nameArabic == this.nameArabic &&
          other.nameTranslit == this.nameTranslit &&
          other.nameTranslation == this.nameTranslation &&
          other.revelationPlace == this.revelationPlace &&
          other.ayahCount == this.ayahCount);
}

class SurahsCompanion extends UpdateCompanion<Surah> {
  final Value<int> number;
  final Value<String> nameArabic;
  final Value<String> nameTranslit;
  final Value<String> nameTranslation;
  final Value<String> revelationPlace;
  final Value<int> ayahCount;
  const SurahsCompanion({
    this.number = const Value.absent(),
    this.nameArabic = const Value.absent(),
    this.nameTranslit = const Value.absent(),
    this.nameTranslation = const Value.absent(),
    this.revelationPlace = const Value.absent(),
    this.ayahCount = const Value.absent(),
  });
  SurahsCompanion.insert({
    this.number = const Value.absent(),
    required String nameArabic,
    required String nameTranslit,
    required String nameTranslation,
    required String revelationPlace,
    required int ayahCount,
  }) : nameArabic = Value(nameArabic),
       nameTranslit = Value(nameTranslit),
       nameTranslation = Value(nameTranslation),
       revelationPlace = Value(revelationPlace),
       ayahCount = Value(ayahCount);
  static Insertable<Surah> custom({
    Expression<int>? number,
    Expression<String>? nameArabic,
    Expression<String>? nameTranslit,
    Expression<String>? nameTranslation,
    Expression<String>? revelationPlace,
    Expression<int>? ayahCount,
  }) {
    return RawValuesInsertable({
      if (number != null) 'number': number,
      if (nameArabic != null) 'name_arabic': nameArabic,
      if (nameTranslit != null) 'name_translit': nameTranslit,
      if (nameTranslation != null) 'name_translation': nameTranslation,
      if (revelationPlace != null) 'revelation_place': revelationPlace,
      if (ayahCount != null) 'ayah_count': ayahCount,
    });
  }

  SurahsCompanion copyWith({
    Value<int>? number,
    Value<String>? nameArabic,
    Value<String>? nameTranslit,
    Value<String>? nameTranslation,
    Value<String>? revelationPlace,
    Value<int>? ayahCount,
  }) {
    return SurahsCompanion(
      number: number ?? this.number,
      nameArabic: nameArabic ?? this.nameArabic,
      nameTranslit: nameTranslit ?? this.nameTranslit,
      nameTranslation: nameTranslation ?? this.nameTranslation,
      revelationPlace: revelationPlace ?? this.revelationPlace,
      ayahCount: ayahCount ?? this.ayahCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (number.present) {
      map['number'] = Variable<int>(number.value);
    }
    if (nameArabic.present) {
      map['name_arabic'] = Variable<String>(nameArabic.value);
    }
    if (nameTranslit.present) {
      map['name_translit'] = Variable<String>(nameTranslit.value);
    }
    if (nameTranslation.present) {
      map['name_translation'] = Variable<String>(nameTranslation.value);
    }
    if (revelationPlace.present) {
      map['revelation_place'] = Variable<String>(revelationPlace.value);
    }
    if (ayahCount.present) {
      map['ayah_count'] = Variable<int>(ayahCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SurahsCompanion(')
          ..write('number: $number, ')
          ..write('nameArabic: $nameArabic, ')
          ..write('nameTranslit: $nameTranslit, ')
          ..write('nameTranslation: $nameTranslation, ')
          ..write('revelationPlace: $revelationPlace, ')
          ..write('ayahCount: $ayahCount')
          ..write(')'))
        .toString();
  }
}

class $AyahsTable extends Ayahs with TableInfo<$AyahsTable, Ayah> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AyahsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _globalAyahIndexMeta = const VerificationMeta(
    'globalAyahIndex',
  );
  @override
  late final GeneratedColumn<int> globalAyahIndex = GeneratedColumn<int>(
    'global_ayah_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _surahNumberMeta = const VerificationMeta(
    'surahNumber',
  );
  @override
  late final GeneratedColumn<int> surahNumber = GeneratedColumn<int>(
    'surah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ayahNumberMeta = const VerificationMeta(
    'ayahNumber',
  );
  @override
  late final GeneratedColumn<int> ayahNumber = GeneratedColumn<int>(
    'ayah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _arabicTextUthmaniMeta = const VerificationMeta(
    'arabicTextUthmani',
  );
  @override
  late final GeneratedColumn<String> arabicTextUthmani =
      GeneratedColumn<String>(
        'arabic_text_uthmani',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _juzMeta = const VerificationMeta('juz');
  @override
  late final GeneratedColumn<int> juz = GeneratedColumn<int>(
    'juz',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pageMeta = const VerificationMeta('page');
  @override
  late final GeneratedColumn<int> page = GeneratedColumn<int>(
    'page',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    globalAyahIndex,
    surahNumber,
    ayahNumber,
    arabicTextUthmani,
    juz,
    page,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ayahs';
  @override
  VerificationContext validateIntegrity(
    Insertable<Ayah> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('global_ayah_index')) {
      context.handle(
        _globalAyahIndexMeta,
        globalAyahIndex.isAcceptableOrUnknown(
          data['global_ayah_index']!,
          _globalAyahIndexMeta,
        ),
      );
    }
    if (data.containsKey('surah_number')) {
      context.handle(
        _surahNumberMeta,
        surahNumber.isAcceptableOrUnknown(
          data['surah_number']!,
          _surahNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_surahNumberMeta);
    }
    if (data.containsKey('ayah_number')) {
      context.handle(
        _ayahNumberMeta,
        ayahNumber.isAcceptableOrUnknown(data['ayah_number']!, _ayahNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_ayahNumberMeta);
    }
    if (data.containsKey('arabic_text_uthmani')) {
      context.handle(
        _arabicTextUthmaniMeta,
        arabicTextUthmani.isAcceptableOrUnknown(
          data['arabic_text_uthmani']!,
          _arabicTextUthmaniMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_arabicTextUthmaniMeta);
    }
    if (data.containsKey('juz')) {
      context.handle(
        _juzMeta,
        juz.isAcceptableOrUnknown(data['juz']!, _juzMeta),
      );
    } else if (isInserting) {
      context.missing(_juzMeta);
    }
    if (data.containsKey('page')) {
      context.handle(
        _pageMeta,
        page.isAcceptableOrUnknown(data['page']!, _pageMeta),
      );
    } else if (isInserting) {
      context.missing(_pageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {globalAyahIndex};
  @override
  Ayah map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Ayah(
      globalAyahIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}global_ayah_index'],
      )!,
      surahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}surah_number'],
      )!,
      ayahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ayah_number'],
      )!,
      arabicTextUthmani: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}arabic_text_uthmani'],
      )!,
      juz: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}juz'],
      )!,
      page: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}page'],
      )!,
    );
  }

  @override
  $AyahsTable createAlias(String alias) {
    return $AyahsTable(attachedDatabase, alias);
  }
}

class Ayah extends DataClass implements Insertable<Ayah> {
  final int globalAyahIndex;
  final int surahNumber;
  final int ayahNumber;
  final String arabicTextUthmani;
  final int juz;
  final int page;
  const Ayah({
    required this.globalAyahIndex,
    required this.surahNumber,
    required this.ayahNumber,
    required this.arabicTextUthmani,
    required this.juz,
    required this.page,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['global_ayah_index'] = Variable<int>(globalAyahIndex);
    map['surah_number'] = Variable<int>(surahNumber);
    map['ayah_number'] = Variable<int>(ayahNumber);
    map['arabic_text_uthmani'] = Variable<String>(arabicTextUthmani);
    map['juz'] = Variable<int>(juz);
    map['page'] = Variable<int>(page);
    return map;
  }

  AyahsCompanion toCompanion(bool nullToAbsent) {
    return AyahsCompanion(
      globalAyahIndex: Value(globalAyahIndex),
      surahNumber: Value(surahNumber),
      ayahNumber: Value(ayahNumber),
      arabicTextUthmani: Value(arabicTextUthmani),
      juz: Value(juz),
      page: Value(page),
    );
  }

  factory Ayah.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Ayah(
      globalAyahIndex: serializer.fromJson<int>(json['globalAyahIndex']),
      surahNumber: serializer.fromJson<int>(json['surahNumber']),
      ayahNumber: serializer.fromJson<int>(json['ayahNumber']),
      arabicTextUthmani: serializer.fromJson<String>(json['arabicTextUthmani']),
      juz: serializer.fromJson<int>(json['juz']),
      page: serializer.fromJson<int>(json['page']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'globalAyahIndex': serializer.toJson<int>(globalAyahIndex),
      'surahNumber': serializer.toJson<int>(surahNumber),
      'ayahNumber': serializer.toJson<int>(ayahNumber),
      'arabicTextUthmani': serializer.toJson<String>(arabicTextUthmani),
      'juz': serializer.toJson<int>(juz),
      'page': serializer.toJson<int>(page),
    };
  }

  Ayah copyWith({
    int? globalAyahIndex,
    int? surahNumber,
    int? ayahNumber,
    String? arabicTextUthmani,
    int? juz,
    int? page,
  }) => Ayah(
    globalAyahIndex: globalAyahIndex ?? this.globalAyahIndex,
    surahNumber: surahNumber ?? this.surahNumber,
    ayahNumber: ayahNumber ?? this.ayahNumber,
    arabicTextUthmani: arabicTextUthmani ?? this.arabicTextUthmani,
    juz: juz ?? this.juz,
    page: page ?? this.page,
  );
  Ayah copyWithCompanion(AyahsCompanion data) {
    return Ayah(
      globalAyahIndex: data.globalAyahIndex.present
          ? data.globalAyahIndex.value
          : this.globalAyahIndex,
      surahNumber: data.surahNumber.present
          ? data.surahNumber.value
          : this.surahNumber,
      ayahNumber: data.ayahNumber.present
          ? data.ayahNumber.value
          : this.ayahNumber,
      arabicTextUthmani: data.arabicTextUthmani.present
          ? data.arabicTextUthmani.value
          : this.arabicTextUthmani,
      juz: data.juz.present ? data.juz.value : this.juz,
      page: data.page.present ? data.page.value : this.page,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Ayah(')
          ..write('globalAyahIndex: $globalAyahIndex, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('arabicTextUthmani: $arabicTextUthmani, ')
          ..write('juz: $juz, ')
          ..write('page: $page')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    globalAyahIndex,
    surahNumber,
    ayahNumber,
    arabicTextUthmani,
    juz,
    page,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Ayah &&
          other.globalAyahIndex == this.globalAyahIndex &&
          other.surahNumber == this.surahNumber &&
          other.ayahNumber == this.ayahNumber &&
          other.arabicTextUthmani == this.arabicTextUthmani &&
          other.juz == this.juz &&
          other.page == this.page);
}

class AyahsCompanion extends UpdateCompanion<Ayah> {
  final Value<int> globalAyahIndex;
  final Value<int> surahNumber;
  final Value<int> ayahNumber;
  final Value<String> arabicTextUthmani;
  final Value<int> juz;
  final Value<int> page;
  const AyahsCompanion({
    this.globalAyahIndex = const Value.absent(),
    this.surahNumber = const Value.absent(),
    this.ayahNumber = const Value.absent(),
    this.arabicTextUthmani = const Value.absent(),
    this.juz = const Value.absent(),
    this.page = const Value.absent(),
  });
  AyahsCompanion.insert({
    this.globalAyahIndex = const Value.absent(),
    required int surahNumber,
    required int ayahNumber,
    required String arabicTextUthmani,
    required int juz,
    required int page,
  }) : surahNumber = Value(surahNumber),
       ayahNumber = Value(ayahNumber),
       arabicTextUthmani = Value(arabicTextUthmani),
       juz = Value(juz),
       page = Value(page);
  static Insertable<Ayah> custom({
    Expression<int>? globalAyahIndex,
    Expression<int>? surahNumber,
    Expression<int>? ayahNumber,
    Expression<String>? arabicTextUthmani,
    Expression<int>? juz,
    Expression<int>? page,
  }) {
    return RawValuesInsertable({
      if (globalAyahIndex != null) 'global_ayah_index': globalAyahIndex,
      if (surahNumber != null) 'surah_number': surahNumber,
      if (ayahNumber != null) 'ayah_number': ayahNumber,
      if (arabicTextUthmani != null) 'arabic_text_uthmani': arabicTextUthmani,
      if (juz != null) 'juz': juz,
      if (page != null) 'page': page,
    });
  }

  AyahsCompanion copyWith({
    Value<int>? globalAyahIndex,
    Value<int>? surahNumber,
    Value<int>? ayahNumber,
    Value<String>? arabicTextUthmani,
    Value<int>? juz,
    Value<int>? page,
  }) {
    return AyahsCompanion(
      globalAyahIndex: globalAyahIndex ?? this.globalAyahIndex,
      surahNumber: surahNumber ?? this.surahNumber,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      arabicTextUthmani: arabicTextUthmani ?? this.arabicTextUthmani,
      juz: juz ?? this.juz,
      page: page ?? this.page,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (globalAyahIndex.present) {
      map['global_ayah_index'] = Variable<int>(globalAyahIndex.value);
    }
    if (surahNumber.present) {
      map['surah_number'] = Variable<int>(surahNumber.value);
    }
    if (ayahNumber.present) {
      map['ayah_number'] = Variable<int>(ayahNumber.value);
    }
    if (arabicTextUthmani.present) {
      map['arabic_text_uthmani'] = Variable<String>(arabicTextUthmani.value);
    }
    if (juz.present) {
      map['juz'] = Variable<int>(juz.value);
    }
    if (page.present) {
      map['page'] = Variable<int>(page.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AyahsCompanion(')
          ..write('globalAyahIndex: $globalAyahIndex, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('arabicTextUthmani: $arabicTextUthmani, ')
          ..write('juz: $juz, ')
          ..write('page: $page')
          ..write(')'))
        .toString();
  }
}

class $TranslationsMetaTable extends TranslationsMeta
    with TableInfo<$TranslationsMetaTable, TranslationMeta> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TranslationsMetaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _translationIdMeta = const VerificationMeta(
    'translationId',
  );
  @override
  late final GeneratedColumn<String> translationId = GeneratedColumn<String>(
    'translation_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _languageMeta = const VerificationMeta(
    'language',
  );
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
    'language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _translatorNameMeta = const VerificationMeta(
    'translatorName',
  );
  @override
  late final GeneratedColumn<String> translatorName = GeneratedColumn<String>(
    'translator_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _licenseNoteMeta = const VerificationMeta(
    'licenseNote',
  );
  @override
  late final GeneratedColumn<String> licenseNote = GeneratedColumn<String>(
    'license_note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    translationId,
    language,
    translatorName,
    source,
    licenseNote,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'translations_meta';
  @override
  VerificationContext validateIntegrity(
    Insertable<TranslationMeta> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('translation_id')) {
      context.handle(
        _translationIdMeta,
        translationId.isAcceptableOrUnknown(
          data['translation_id']!,
          _translationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_translationIdMeta);
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    } else if (isInserting) {
      context.missing(_languageMeta);
    }
    if (data.containsKey('translator_name')) {
      context.handle(
        _translatorNameMeta,
        translatorName.isAcceptableOrUnknown(
          data['translator_name']!,
          _translatorNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_translatorNameMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('license_note')) {
      context.handle(
        _licenseNoteMeta,
        licenseNote.isAcceptableOrUnknown(
          data['license_note']!,
          _licenseNoteMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_licenseNoteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {translationId};
  @override
  TranslationMeta map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TranslationMeta(
      translationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}translation_id'],
      )!,
      language: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language'],
      )!,
      translatorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}translator_name'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      licenseNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}license_note'],
      )!,
    );
  }

  @override
  $TranslationsMetaTable createAlias(String alias) {
    return $TranslationsMetaTable(attachedDatabase, alias);
  }
}

class TranslationMeta extends DataClass implements Insertable<TranslationMeta> {
  final String translationId;
  final String language;
  final String translatorName;
  final String source;
  final String licenseNote;
  const TranslationMeta({
    required this.translationId,
    required this.language,
    required this.translatorName,
    required this.source,
    required this.licenseNote,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['translation_id'] = Variable<String>(translationId);
    map['language'] = Variable<String>(language);
    map['translator_name'] = Variable<String>(translatorName);
    map['source'] = Variable<String>(source);
    map['license_note'] = Variable<String>(licenseNote);
    return map;
  }

  TranslationsMetaCompanion toCompanion(bool nullToAbsent) {
    return TranslationsMetaCompanion(
      translationId: Value(translationId),
      language: Value(language),
      translatorName: Value(translatorName),
      source: Value(source),
      licenseNote: Value(licenseNote),
    );
  }

  factory TranslationMeta.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TranslationMeta(
      translationId: serializer.fromJson<String>(json['translationId']),
      language: serializer.fromJson<String>(json['language']),
      translatorName: serializer.fromJson<String>(json['translatorName']),
      source: serializer.fromJson<String>(json['source']),
      licenseNote: serializer.fromJson<String>(json['licenseNote']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'translationId': serializer.toJson<String>(translationId),
      'language': serializer.toJson<String>(language),
      'translatorName': serializer.toJson<String>(translatorName),
      'source': serializer.toJson<String>(source),
      'licenseNote': serializer.toJson<String>(licenseNote),
    };
  }

  TranslationMeta copyWith({
    String? translationId,
    String? language,
    String? translatorName,
    String? source,
    String? licenseNote,
  }) => TranslationMeta(
    translationId: translationId ?? this.translationId,
    language: language ?? this.language,
    translatorName: translatorName ?? this.translatorName,
    source: source ?? this.source,
    licenseNote: licenseNote ?? this.licenseNote,
  );
  TranslationMeta copyWithCompanion(TranslationsMetaCompanion data) {
    return TranslationMeta(
      translationId: data.translationId.present
          ? data.translationId.value
          : this.translationId,
      language: data.language.present ? data.language.value : this.language,
      translatorName: data.translatorName.present
          ? data.translatorName.value
          : this.translatorName,
      source: data.source.present ? data.source.value : this.source,
      licenseNote: data.licenseNote.present
          ? data.licenseNote.value
          : this.licenseNote,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TranslationMeta(')
          ..write('translationId: $translationId, ')
          ..write('language: $language, ')
          ..write('translatorName: $translatorName, ')
          ..write('source: $source, ')
          ..write('licenseNote: $licenseNote')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(translationId, language, translatorName, source, licenseNote);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TranslationMeta &&
          other.translationId == this.translationId &&
          other.language == this.language &&
          other.translatorName == this.translatorName &&
          other.source == this.source &&
          other.licenseNote == this.licenseNote);
}

class TranslationsMetaCompanion extends UpdateCompanion<TranslationMeta> {
  final Value<String> translationId;
  final Value<String> language;
  final Value<String> translatorName;
  final Value<String> source;
  final Value<String> licenseNote;
  final Value<int> rowid;
  const TranslationsMetaCompanion({
    this.translationId = const Value.absent(),
    this.language = const Value.absent(),
    this.translatorName = const Value.absent(),
    this.source = const Value.absent(),
    this.licenseNote = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TranslationsMetaCompanion.insert({
    required String translationId,
    required String language,
    required String translatorName,
    required String source,
    required String licenseNote,
    this.rowid = const Value.absent(),
  }) : translationId = Value(translationId),
       language = Value(language),
       translatorName = Value(translatorName),
       source = Value(source),
       licenseNote = Value(licenseNote);
  static Insertable<TranslationMeta> custom({
    Expression<String>? translationId,
    Expression<String>? language,
    Expression<String>? translatorName,
    Expression<String>? source,
    Expression<String>? licenseNote,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (translationId != null) 'translation_id': translationId,
      if (language != null) 'language': language,
      if (translatorName != null) 'translator_name': translatorName,
      if (source != null) 'source': source,
      if (licenseNote != null) 'license_note': licenseNote,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TranslationsMetaCompanion copyWith({
    Value<String>? translationId,
    Value<String>? language,
    Value<String>? translatorName,
    Value<String>? source,
    Value<String>? licenseNote,
    Value<int>? rowid,
  }) {
    return TranslationsMetaCompanion(
      translationId: translationId ?? this.translationId,
      language: language ?? this.language,
      translatorName: translatorName ?? this.translatorName,
      source: source ?? this.source,
      licenseNote: licenseNote ?? this.licenseNote,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (translationId.present) {
      map['translation_id'] = Variable<String>(translationId.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (translatorName.present) {
      map['translator_name'] = Variable<String>(translatorName.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (licenseNote.present) {
      map['license_note'] = Variable<String>(licenseNote.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TranslationsMetaCompanion(')
          ..write('translationId: $translationId, ')
          ..write('language: $language, ')
          ..write('translatorName: $translatorName, ')
          ..write('source: $source, ')
          ..write('licenseNote: $licenseNote, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AyahTranslationsTable extends AyahTranslations
    with TableInfo<$AyahTranslationsTable, AyahTranslation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AyahTranslationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _translationIdMeta = const VerificationMeta(
    'translationId',
  );
  @override
  late final GeneratedColumn<String> translationId = GeneratedColumn<String>(
    'translation_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _surahNumberMeta = const VerificationMeta(
    'surahNumber',
  );
  @override
  late final GeneratedColumn<int> surahNumber = GeneratedColumn<int>(
    'surah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ayahNumberMeta = const VerificationMeta(
    'ayahNumber',
  );
  @override
  late final GeneratedColumn<int> ayahNumber = GeneratedColumn<int>(
    'ayah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _textContentMeta = const VerificationMeta(
    'textContent',
  );
  @override
  late final GeneratedColumn<String> textContent = GeneratedColumn<String>(
    'text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    translationId,
    surahNumber,
    ayahNumber,
    textContent,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ayah_translations';
  @override
  VerificationContext validateIntegrity(
    Insertable<AyahTranslation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('translation_id')) {
      context.handle(
        _translationIdMeta,
        translationId.isAcceptableOrUnknown(
          data['translation_id']!,
          _translationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_translationIdMeta);
    }
    if (data.containsKey('surah_number')) {
      context.handle(
        _surahNumberMeta,
        surahNumber.isAcceptableOrUnknown(
          data['surah_number']!,
          _surahNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_surahNumberMeta);
    }
    if (data.containsKey('ayah_number')) {
      context.handle(
        _ayahNumberMeta,
        ayahNumber.isAcceptableOrUnknown(data['ayah_number']!, _ayahNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_ayahNumberMeta);
    }
    if (data.containsKey('text')) {
      context.handle(
        _textContentMeta,
        textContent.isAcceptableOrUnknown(data['text']!, _textContentMeta),
      );
    } else if (isInserting) {
      context.missing(_textContentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {
    translationId,
    surahNumber,
    ayahNumber,
  };
  @override
  AyahTranslation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AyahTranslation(
      translationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}translation_id'],
      )!,
      surahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}surah_number'],
      )!,
      ayahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ayah_number'],
      )!,
      textContent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text'],
      )!,
    );
  }

  @override
  $AyahTranslationsTable createAlias(String alias) {
    return $AyahTranslationsTable(attachedDatabase, alias);
  }
}

class AyahTranslation extends DataClass implements Insertable<AyahTranslation> {
  final String translationId;
  final int surahNumber;
  final int ayahNumber;
  final String textContent;
  const AyahTranslation({
    required this.translationId,
    required this.surahNumber,
    required this.ayahNumber,
    required this.textContent,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['translation_id'] = Variable<String>(translationId);
    map['surah_number'] = Variable<int>(surahNumber);
    map['ayah_number'] = Variable<int>(ayahNumber);
    map['text'] = Variable<String>(textContent);
    return map;
  }

  AyahTranslationsCompanion toCompanion(bool nullToAbsent) {
    return AyahTranslationsCompanion(
      translationId: Value(translationId),
      surahNumber: Value(surahNumber),
      ayahNumber: Value(ayahNumber),
      textContent: Value(textContent),
    );
  }

  factory AyahTranslation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AyahTranslation(
      translationId: serializer.fromJson<String>(json['translationId']),
      surahNumber: serializer.fromJson<int>(json['surahNumber']),
      ayahNumber: serializer.fromJson<int>(json['ayahNumber']),
      textContent: serializer.fromJson<String>(json['textContent']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'translationId': serializer.toJson<String>(translationId),
      'surahNumber': serializer.toJson<int>(surahNumber),
      'ayahNumber': serializer.toJson<int>(ayahNumber),
      'textContent': serializer.toJson<String>(textContent),
    };
  }

  AyahTranslation copyWith({
    String? translationId,
    int? surahNumber,
    int? ayahNumber,
    String? textContent,
  }) => AyahTranslation(
    translationId: translationId ?? this.translationId,
    surahNumber: surahNumber ?? this.surahNumber,
    ayahNumber: ayahNumber ?? this.ayahNumber,
    textContent: textContent ?? this.textContent,
  );
  AyahTranslation copyWithCompanion(AyahTranslationsCompanion data) {
    return AyahTranslation(
      translationId: data.translationId.present
          ? data.translationId.value
          : this.translationId,
      surahNumber: data.surahNumber.present
          ? data.surahNumber.value
          : this.surahNumber,
      ayahNumber: data.ayahNumber.present
          ? data.ayahNumber.value
          : this.ayahNumber,
      textContent: data.textContent.present
          ? data.textContent.value
          : this.textContent,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AyahTranslation(')
          ..write('translationId: $translationId, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('textContent: $textContent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(translationId, surahNumber, ayahNumber, textContent);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AyahTranslation &&
          other.translationId == this.translationId &&
          other.surahNumber == this.surahNumber &&
          other.ayahNumber == this.ayahNumber &&
          other.textContent == this.textContent);
}

class AyahTranslationsCompanion extends UpdateCompanion<AyahTranslation> {
  final Value<String> translationId;
  final Value<int> surahNumber;
  final Value<int> ayahNumber;
  final Value<String> textContent;
  final Value<int> rowid;
  const AyahTranslationsCompanion({
    this.translationId = const Value.absent(),
    this.surahNumber = const Value.absent(),
    this.ayahNumber = const Value.absent(),
    this.textContent = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AyahTranslationsCompanion.insert({
    required String translationId,
    required int surahNumber,
    required int ayahNumber,
    required String textContent,
    this.rowid = const Value.absent(),
  }) : translationId = Value(translationId),
       surahNumber = Value(surahNumber),
       ayahNumber = Value(ayahNumber),
       textContent = Value(textContent);
  static Insertable<AyahTranslation> custom({
    Expression<String>? translationId,
    Expression<int>? surahNumber,
    Expression<int>? ayahNumber,
    Expression<String>? textContent,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (translationId != null) 'translation_id': translationId,
      if (surahNumber != null) 'surah_number': surahNumber,
      if (ayahNumber != null) 'ayah_number': ayahNumber,
      if (textContent != null) 'text': textContent,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AyahTranslationsCompanion copyWith({
    Value<String>? translationId,
    Value<int>? surahNumber,
    Value<int>? ayahNumber,
    Value<String>? textContent,
    Value<int>? rowid,
  }) {
    return AyahTranslationsCompanion(
      translationId: translationId ?? this.translationId,
      surahNumber: surahNumber ?? this.surahNumber,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      textContent: textContent ?? this.textContent,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (translationId.present) {
      map['translation_id'] = Variable<String>(translationId.value);
    }
    if (surahNumber.present) {
      map['surah_number'] = Variable<int>(surahNumber.value);
    }
    if (ayahNumber.present) {
      map['ayah_number'] = Variable<int>(ayahNumber.value);
    }
    if (textContent.present) {
      map['text'] = Variable<String>(textContent.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AyahTranslationsCompanion(')
          ..write('translationId: $translationId, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('textContent: $textContent, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RootsTable extends Roots with TableInfo<$RootsTable, Root> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RootsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _rootIdMeta = const VerificationMeta('rootId');
  @override
  late final GeneratedColumn<int> rootId = GeneratedColumn<int>(
    'root_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rootArabicMeta = const VerificationMeta(
    'rootArabic',
  );
  @override
  late final GeneratedColumn<String> rootArabic = GeneratedColumn<String>(
    'root_arabic',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rootTranslitMeta = const VerificationMeta(
    'rootTranslit',
  );
  @override
  late final GeneratedColumn<String> rootTranslit = GeneratedColumn<String>(
    'root_translit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _meaningsSummaryMeta = const VerificationMeta(
    'meaningsSummary',
  );
  @override
  late final GeneratedColumn<String> meaningsSummary = GeneratedColumn<String>(
    'meanings_summary',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _occurrenceCountMeta = const VerificationMeta(
    'occurrenceCount',
  );
  @override
  late final GeneratedColumn<int> occurrenceCount = GeneratedColumn<int>(
    'occurrence_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    rootId,
    rootArabic,
    rootTranslit,
    meaningsSummary,
    occurrenceCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'roots';
  @override
  VerificationContext validateIntegrity(
    Insertable<Root> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('root_id')) {
      context.handle(
        _rootIdMeta,
        rootId.isAcceptableOrUnknown(data['root_id']!, _rootIdMeta),
      );
    }
    if (data.containsKey('root_arabic')) {
      context.handle(
        _rootArabicMeta,
        rootArabic.isAcceptableOrUnknown(data['root_arabic']!, _rootArabicMeta),
      );
    } else if (isInserting) {
      context.missing(_rootArabicMeta);
    }
    if (data.containsKey('root_translit')) {
      context.handle(
        _rootTranslitMeta,
        rootTranslit.isAcceptableOrUnknown(
          data['root_translit']!,
          _rootTranslitMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_rootTranslitMeta);
    }
    if (data.containsKey('meanings_summary')) {
      context.handle(
        _meaningsSummaryMeta,
        meaningsSummary.isAcceptableOrUnknown(
          data['meanings_summary']!,
          _meaningsSummaryMeta,
        ),
      );
    }
    if (data.containsKey('occurrence_count')) {
      context.handle(
        _occurrenceCountMeta,
        occurrenceCount.isAcceptableOrUnknown(
          data['occurrence_count']!,
          _occurrenceCountMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {rootId};
  @override
  Root map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Root(
      rootId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}root_id'],
      )!,
      rootArabic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}root_arabic'],
      )!,
      rootTranslit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}root_translit'],
      )!,
      meaningsSummary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meanings_summary'],
      )!,
      occurrenceCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}occurrence_count'],
      )!,
    );
  }

  @override
  $RootsTable createAlias(String alias) {
    return $RootsTable(attachedDatabase, alias);
  }
}

class Root extends DataClass implements Insertable<Root> {
  final int rootId;
  final String rootArabic;
  final String rootTranslit;
  final String meaningsSummary;
  final int occurrenceCount;
  const Root({
    required this.rootId,
    required this.rootArabic,
    required this.rootTranslit,
    required this.meaningsSummary,
    required this.occurrenceCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['root_id'] = Variable<int>(rootId);
    map['root_arabic'] = Variable<String>(rootArabic);
    map['root_translit'] = Variable<String>(rootTranslit);
    map['meanings_summary'] = Variable<String>(meaningsSummary);
    map['occurrence_count'] = Variable<int>(occurrenceCount);
    return map;
  }

  RootsCompanion toCompanion(bool nullToAbsent) {
    return RootsCompanion(
      rootId: Value(rootId),
      rootArabic: Value(rootArabic),
      rootTranslit: Value(rootTranslit),
      meaningsSummary: Value(meaningsSummary),
      occurrenceCount: Value(occurrenceCount),
    );
  }

  factory Root.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Root(
      rootId: serializer.fromJson<int>(json['rootId']),
      rootArabic: serializer.fromJson<String>(json['rootArabic']),
      rootTranslit: serializer.fromJson<String>(json['rootTranslit']),
      meaningsSummary: serializer.fromJson<String>(json['meaningsSummary']),
      occurrenceCount: serializer.fromJson<int>(json['occurrenceCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'rootId': serializer.toJson<int>(rootId),
      'rootArabic': serializer.toJson<String>(rootArabic),
      'rootTranslit': serializer.toJson<String>(rootTranslit),
      'meaningsSummary': serializer.toJson<String>(meaningsSummary),
      'occurrenceCount': serializer.toJson<int>(occurrenceCount),
    };
  }

  Root copyWith({
    int? rootId,
    String? rootArabic,
    String? rootTranslit,
    String? meaningsSummary,
    int? occurrenceCount,
  }) => Root(
    rootId: rootId ?? this.rootId,
    rootArabic: rootArabic ?? this.rootArabic,
    rootTranslit: rootTranslit ?? this.rootTranslit,
    meaningsSummary: meaningsSummary ?? this.meaningsSummary,
    occurrenceCount: occurrenceCount ?? this.occurrenceCount,
  );
  Root copyWithCompanion(RootsCompanion data) {
    return Root(
      rootId: data.rootId.present ? data.rootId.value : this.rootId,
      rootArabic: data.rootArabic.present
          ? data.rootArabic.value
          : this.rootArabic,
      rootTranslit: data.rootTranslit.present
          ? data.rootTranslit.value
          : this.rootTranslit,
      meaningsSummary: data.meaningsSummary.present
          ? data.meaningsSummary.value
          : this.meaningsSummary,
      occurrenceCount: data.occurrenceCount.present
          ? data.occurrenceCount.value
          : this.occurrenceCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Root(')
          ..write('rootId: $rootId, ')
          ..write('rootArabic: $rootArabic, ')
          ..write('rootTranslit: $rootTranslit, ')
          ..write('meaningsSummary: $meaningsSummary, ')
          ..write('occurrenceCount: $occurrenceCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    rootId,
    rootArabic,
    rootTranslit,
    meaningsSummary,
    occurrenceCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Root &&
          other.rootId == this.rootId &&
          other.rootArabic == this.rootArabic &&
          other.rootTranslit == this.rootTranslit &&
          other.meaningsSummary == this.meaningsSummary &&
          other.occurrenceCount == this.occurrenceCount);
}

class RootsCompanion extends UpdateCompanion<Root> {
  final Value<int> rootId;
  final Value<String> rootArabic;
  final Value<String> rootTranslit;
  final Value<String> meaningsSummary;
  final Value<int> occurrenceCount;
  const RootsCompanion({
    this.rootId = const Value.absent(),
    this.rootArabic = const Value.absent(),
    this.rootTranslit = const Value.absent(),
    this.meaningsSummary = const Value.absent(),
    this.occurrenceCount = const Value.absent(),
  });
  RootsCompanion.insert({
    this.rootId = const Value.absent(),
    required String rootArabic,
    required String rootTranslit,
    this.meaningsSummary = const Value.absent(),
    this.occurrenceCount = const Value.absent(),
  }) : rootArabic = Value(rootArabic),
       rootTranslit = Value(rootTranslit);
  static Insertable<Root> custom({
    Expression<int>? rootId,
    Expression<String>? rootArabic,
    Expression<String>? rootTranslit,
    Expression<String>? meaningsSummary,
    Expression<int>? occurrenceCount,
  }) {
    return RawValuesInsertable({
      if (rootId != null) 'root_id': rootId,
      if (rootArabic != null) 'root_arabic': rootArabic,
      if (rootTranslit != null) 'root_translit': rootTranslit,
      if (meaningsSummary != null) 'meanings_summary': meaningsSummary,
      if (occurrenceCount != null) 'occurrence_count': occurrenceCount,
    });
  }

  RootsCompanion copyWith({
    Value<int>? rootId,
    Value<String>? rootArabic,
    Value<String>? rootTranslit,
    Value<String>? meaningsSummary,
    Value<int>? occurrenceCount,
  }) {
    return RootsCompanion(
      rootId: rootId ?? this.rootId,
      rootArabic: rootArabic ?? this.rootArabic,
      rootTranslit: rootTranslit ?? this.rootTranslit,
      meaningsSummary: meaningsSummary ?? this.meaningsSummary,
      occurrenceCount: occurrenceCount ?? this.occurrenceCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (rootId.present) {
      map['root_id'] = Variable<int>(rootId.value);
    }
    if (rootArabic.present) {
      map['root_arabic'] = Variable<String>(rootArabic.value);
    }
    if (rootTranslit.present) {
      map['root_translit'] = Variable<String>(rootTranslit.value);
    }
    if (meaningsSummary.present) {
      map['meanings_summary'] = Variable<String>(meaningsSummary.value);
    }
    if (occurrenceCount.present) {
      map['occurrence_count'] = Variable<int>(occurrenceCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RootsCompanion(')
          ..write('rootId: $rootId, ')
          ..write('rootArabic: $rootArabic, ')
          ..write('rootTranslit: $rootTranslit, ')
          ..write('meaningsSummary: $meaningsSummary, ')
          ..write('occurrenceCount: $occurrenceCount')
          ..write(')'))
        .toString();
  }
}

class $WordsTable extends Words with TableInfo<$WordsTable, Word> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _surahNumberMeta = const VerificationMeta(
    'surahNumber',
  );
  @override
  late final GeneratedColumn<int> surahNumber = GeneratedColumn<int>(
    'surah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ayahNumberMeta = const VerificationMeta(
    'ayahNumber',
  );
  @override
  late final GeneratedColumn<int> ayahNumber = GeneratedColumn<int>(
    'ayah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _arabicTextMeta = const VerificationMeta(
    'arabicText',
  );
  @override
  late final GeneratedColumn<String> arabicText = GeneratedColumn<String>(
    'arabic_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _transliterationMeta = const VerificationMeta(
    'transliteration',
  );
  @override
  late final GeneratedColumn<String> transliteration = GeneratedColumn<String>(
    'transliteration',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _translationGlossMeta = const VerificationMeta(
    'translationGloss',
  );
  @override
  late final GeneratedColumn<String> translationGloss = GeneratedColumn<String>(
    'translation_gloss',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _partOfSpeechMeta = const VerificationMeta(
    'partOfSpeech',
  );
  @override
  late final GeneratedColumn<String> partOfSpeech = GeneratedColumn<String>(
    'part_of_speech',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _grammarDetailsMeta = const VerificationMeta(
    'grammarDetails',
  );
  @override
  late final GeneratedColumn<String> grammarDetails = GeneratedColumn<String>(
    'grammar_details',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _rootIdMeta = const VerificationMeta('rootId');
  @override
  late final GeneratedColumn<int> rootId = GeneratedColumn<int>(
    'root_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'REFERENCES roots(root_id)',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    surahNumber,
    ayahNumber,
    position,
    arabicText,
    transliteration,
    translationGloss,
    partOfSpeech,
    grammarDetails,
    rootId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'words';
  @override
  VerificationContext validateIntegrity(
    Insertable<Word> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('surah_number')) {
      context.handle(
        _surahNumberMeta,
        surahNumber.isAcceptableOrUnknown(
          data['surah_number']!,
          _surahNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_surahNumberMeta);
    }
    if (data.containsKey('ayah_number')) {
      context.handle(
        _ayahNumberMeta,
        ayahNumber.isAcceptableOrUnknown(data['ayah_number']!, _ayahNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_ayahNumberMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('arabic_text')) {
      context.handle(
        _arabicTextMeta,
        arabicText.isAcceptableOrUnknown(data['arabic_text']!, _arabicTextMeta),
      );
    } else if (isInserting) {
      context.missing(_arabicTextMeta);
    }
    if (data.containsKey('transliteration')) {
      context.handle(
        _transliterationMeta,
        transliteration.isAcceptableOrUnknown(
          data['transliteration']!,
          _transliterationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transliterationMeta);
    }
    if (data.containsKey('translation_gloss')) {
      context.handle(
        _translationGlossMeta,
        translationGloss.isAcceptableOrUnknown(
          data['translation_gloss']!,
          _translationGlossMeta,
        ),
      );
    }
    if (data.containsKey('part_of_speech')) {
      context.handle(
        _partOfSpeechMeta,
        partOfSpeech.isAcceptableOrUnknown(
          data['part_of_speech']!,
          _partOfSpeechMeta,
        ),
      );
    }
    if (data.containsKey('grammar_details')) {
      context.handle(
        _grammarDetailsMeta,
        grammarDetails.isAcceptableOrUnknown(
          data['grammar_details']!,
          _grammarDetailsMeta,
        ),
      );
    }
    if (data.containsKey('root_id')) {
      context.handle(
        _rootIdMeta,
        rootId.isAcceptableOrUnknown(data['root_id']!, _rootIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Word map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Word(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      surahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}surah_number'],
      )!,
      ayahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ayah_number'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      arabicText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}arabic_text'],
      )!,
      transliteration: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transliteration'],
      )!,
      translationGloss: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}translation_gloss'],
      )!,
      partOfSpeech: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}part_of_speech'],
      )!,
      grammarDetails: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grammar_details'],
      )!,
      rootId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}root_id'],
      ),
    );
  }

  @override
  $WordsTable createAlias(String alias) {
    return $WordsTable(attachedDatabase, alias);
  }
}

class Word extends DataClass implements Insertable<Word> {
  final int id;
  final int surahNumber;
  final int ayahNumber;
  final int position;
  final String arabicText;
  final String transliteration;
  final String translationGloss;
  final String partOfSpeech;
  final String grammarDetails;
  final int? rootId;
  const Word({
    required this.id,
    required this.surahNumber,
    required this.ayahNumber,
    required this.position,
    required this.arabicText,
    required this.transliteration,
    required this.translationGloss,
    required this.partOfSpeech,
    required this.grammarDetails,
    this.rootId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['surah_number'] = Variable<int>(surahNumber);
    map['ayah_number'] = Variable<int>(ayahNumber);
    map['position'] = Variable<int>(position);
    map['arabic_text'] = Variable<String>(arabicText);
    map['transliteration'] = Variable<String>(transliteration);
    map['translation_gloss'] = Variable<String>(translationGloss);
    map['part_of_speech'] = Variable<String>(partOfSpeech);
    map['grammar_details'] = Variable<String>(grammarDetails);
    if (!nullToAbsent || rootId != null) {
      map['root_id'] = Variable<int>(rootId);
    }
    return map;
  }

  WordsCompanion toCompanion(bool nullToAbsent) {
    return WordsCompanion(
      id: Value(id),
      surahNumber: Value(surahNumber),
      ayahNumber: Value(ayahNumber),
      position: Value(position),
      arabicText: Value(arabicText),
      transliteration: Value(transliteration),
      translationGloss: Value(translationGloss),
      partOfSpeech: Value(partOfSpeech),
      grammarDetails: Value(grammarDetails),
      rootId: rootId == null && nullToAbsent
          ? const Value.absent()
          : Value(rootId),
    );
  }

  factory Word.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Word(
      id: serializer.fromJson<int>(json['id']),
      surahNumber: serializer.fromJson<int>(json['surahNumber']),
      ayahNumber: serializer.fromJson<int>(json['ayahNumber']),
      position: serializer.fromJson<int>(json['position']),
      arabicText: serializer.fromJson<String>(json['arabicText']),
      transliteration: serializer.fromJson<String>(json['transliteration']),
      translationGloss: serializer.fromJson<String>(json['translationGloss']),
      partOfSpeech: serializer.fromJson<String>(json['partOfSpeech']),
      grammarDetails: serializer.fromJson<String>(json['grammarDetails']),
      rootId: serializer.fromJson<int?>(json['rootId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'surahNumber': serializer.toJson<int>(surahNumber),
      'ayahNumber': serializer.toJson<int>(ayahNumber),
      'position': serializer.toJson<int>(position),
      'arabicText': serializer.toJson<String>(arabicText),
      'transliteration': serializer.toJson<String>(transliteration),
      'translationGloss': serializer.toJson<String>(translationGloss),
      'partOfSpeech': serializer.toJson<String>(partOfSpeech),
      'grammarDetails': serializer.toJson<String>(grammarDetails),
      'rootId': serializer.toJson<int?>(rootId),
    };
  }

  Word copyWith({
    int? id,
    int? surahNumber,
    int? ayahNumber,
    int? position,
    String? arabicText,
    String? transliteration,
    String? translationGloss,
    String? partOfSpeech,
    String? grammarDetails,
    Value<int?> rootId = const Value.absent(),
  }) => Word(
    id: id ?? this.id,
    surahNumber: surahNumber ?? this.surahNumber,
    ayahNumber: ayahNumber ?? this.ayahNumber,
    position: position ?? this.position,
    arabicText: arabicText ?? this.arabicText,
    transliteration: transliteration ?? this.transliteration,
    translationGloss: translationGloss ?? this.translationGloss,
    partOfSpeech: partOfSpeech ?? this.partOfSpeech,
    grammarDetails: grammarDetails ?? this.grammarDetails,
    rootId: rootId.present ? rootId.value : this.rootId,
  );
  Word copyWithCompanion(WordsCompanion data) {
    return Word(
      id: data.id.present ? data.id.value : this.id,
      surahNumber: data.surahNumber.present
          ? data.surahNumber.value
          : this.surahNumber,
      ayahNumber: data.ayahNumber.present
          ? data.ayahNumber.value
          : this.ayahNumber,
      position: data.position.present ? data.position.value : this.position,
      arabicText: data.arabicText.present
          ? data.arabicText.value
          : this.arabicText,
      transliteration: data.transliteration.present
          ? data.transliteration.value
          : this.transliteration,
      translationGloss: data.translationGloss.present
          ? data.translationGloss.value
          : this.translationGloss,
      partOfSpeech: data.partOfSpeech.present
          ? data.partOfSpeech.value
          : this.partOfSpeech,
      grammarDetails: data.grammarDetails.present
          ? data.grammarDetails.value
          : this.grammarDetails,
      rootId: data.rootId.present ? data.rootId.value : this.rootId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Word(')
          ..write('id: $id, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('position: $position, ')
          ..write('arabicText: $arabicText, ')
          ..write('transliteration: $transliteration, ')
          ..write('translationGloss: $translationGloss, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('grammarDetails: $grammarDetails, ')
          ..write('rootId: $rootId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    surahNumber,
    ayahNumber,
    position,
    arabicText,
    transliteration,
    translationGloss,
    partOfSpeech,
    grammarDetails,
    rootId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Word &&
          other.id == this.id &&
          other.surahNumber == this.surahNumber &&
          other.ayahNumber == this.ayahNumber &&
          other.position == this.position &&
          other.arabicText == this.arabicText &&
          other.transliteration == this.transliteration &&
          other.translationGloss == this.translationGloss &&
          other.partOfSpeech == this.partOfSpeech &&
          other.grammarDetails == this.grammarDetails &&
          other.rootId == this.rootId);
}

class WordsCompanion extends UpdateCompanion<Word> {
  final Value<int> id;
  final Value<int> surahNumber;
  final Value<int> ayahNumber;
  final Value<int> position;
  final Value<String> arabicText;
  final Value<String> transliteration;
  final Value<String> translationGloss;
  final Value<String> partOfSpeech;
  final Value<String> grammarDetails;
  final Value<int?> rootId;
  const WordsCompanion({
    this.id = const Value.absent(),
    this.surahNumber = const Value.absent(),
    this.ayahNumber = const Value.absent(),
    this.position = const Value.absent(),
    this.arabicText = const Value.absent(),
    this.transliteration = const Value.absent(),
    this.translationGloss = const Value.absent(),
    this.partOfSpeech = const Value.absent(),
    this.grammarDetails = const Value.absent(),
    this.rootId = const Value.absent(),
  });
  WordsCompanion.insert({
    this.id = const Value.absent(),
    required int surahNumber,
    required int ayahNumber,
    required int position,
    required String arabicText,
    required String transliteration,
    this.translationGloss = const Value.absent(),
    this.partOfSpeech = const Value.absent(),
    this.grammarDetails = const Value.absent(),
    this.rootId = const Value.absent(),
  }) : surahNumber = Value(surahNumber),
       ayahNumber = Value(ayahNumber),
       position = Value(position),
       arabicText = Value(arabicText),
       transliteration = Value(transliteration);
  static Insertable<Word> custom({
    Expression<int>? id,
    Expression<int>? surahNumber,
    Expression<int>? ayahNumber,
    Expression<int>? position,
    Expression<String>? arabicText,
    Expression<String>? transliteration,
    Expression<String>? translationGloss,
    Expression<String>? partOfSpeech,
    Expression<String>? grammarDetails,
    Expression<int>? rootId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surahNumber != null) 'surah_number': surahNumber,
      if (ayahNumber != null) 'ayah_number': ayahNumber,
      if (position != null) 'position': position,
      if (arabicText != null) 'arabic_text': arabicText,
      if (transliteration != null) 'transliteration': transliteration,
      if (translationGloss != null) 'translation_gloss': translationGloss,
      if (partOfSpeech != null) 'part_of_speech': partOfSpeech,
      if (grammarDetails != null) 'grammar_details': grammarDetails,
      if (rootId != null) 'root_id': rootId,
    });
  }

  WordsCompanion copyWith({
    Value<int>? id,
    Value<int>? surahNumber,
    Value<int>? ayahNumber,
    Value<int>? position,
    Value<String>? arabicText,
    Value<String>? transliteration,
    Value<String>? translationGloss,
    Value<String>? partOfSpeech,
    Value<String>? grammarDetails,
    Value<int?>? rootId,
  }) {
    return WordsCompanion(
      id: id ?? this.id,
      surahNumber: surahNumber ?? this.surahNumber,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      position: position ?? this.position,
      arabicText: arabicText ?? this.arabicText,
      transliteration: transliteration ?? this.transliteration,
      translationGloss: translationGloss ?? this.translationGloss,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      grammarDetails: grammarDetails ?? this.grammarDetails,
      rootId: rootId ?? this.rootId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (surahNumber.present) {
      map['surah_number'] = Variable<int>(surahNumber.value);
    }
    if (ayahNumber.present) {
      map['ayah_number'] = Variable<int>(ayahNumber.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (arabicText.present) {
      map['arabic_text'] = Variable<String>(arabicText.value);
    }
    if (transliteration.present) {
      map['transliteration'] = Variable<String>(transliteration.value);
    }
    if (translationGloss.present) {
      map['translation_gloss'] = Variable<String>(translationGloss.value);
    }
    if (partOfSpeech.present) {
      map['part_of_speech'] = Variable<String>(partOfSpeech.value);
    }
    if (grammarDetails.present) {
      map['grammar_details'] = Variable<String>(grammarDetails.value);
    }
    if (rootId.present) {
      map['root_id'] = Variable<int>(rootId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordsCompanion(')
          ..write('id: $id, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('position: $position, ')
          ..write('arabicText: $arabicText, ')
          ..write('transliteration: $transliteration, ')
          ..write('translationGloss: $translationGloss, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('grammarDetails: $grammarDetails, ')
          ..write('rootId: $rootId')
          ..write(')'))
        .toString();
  }
}

class $ContentPacksTable extends ContentPacks
    with TableInfo<$ContentPacksTable, ContentPack> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContentPacksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _packIdMeta = const VerificationMeta('packId');
  @override
  late final GeneratedColumn<String> packId = GeneratedColumn<String>(
    'pack_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<String> version = GeneratedColumn<String>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _downloadedMeta = const VerificationMeta(
    'downloaded',
  );
  @override
  late final GeneratedColumn<bool> downloaded = GeneratedColumn<bool>(
    'downloaded',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("downloaded" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _downloadUrlMeta = const VerificationMeta(
    'downloadUrl',
  );
  @override
  late final GeneratedColumn<String> downloadUrl = GeneratedColumn<String>(
    'download_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sizeBytesMeta = const VerificationMeta(
    'sizeBytes',
  );
  @override
  late final GeneratedColumn<int> sizeBytes = GeneratedColumn<int>(
    'size_bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _licenseNoteMeta = const VerificationMeta(
    'licenseNote',
  );
  @override
  late final GeneratedColumn<String> licenseNote = GeneratedColumn<String>(
    'license_note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    packId,
    type,
    name,
    version,
    downloaded,
    downloadUrl,
    sizeBytes,
    licenseNote,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'content_packs';
  @override
  VerificationContext validateIntegrity(
    Insertable<ContentPack> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pack_id')) {
      context.handle(
        _packIdMeta,
        packId.isAcceptableOrUnknown(data['pack_id']!, _packIdMeta),
      );
    } else if (isInserting) {
      context.missing(_packIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('downloaded')) {
      context.handle(
        _downloadedMeta,
        downloaded.isAcceptableOrUnknown(data['downloaded']!, _downloadedMeta),
      );
    }
    if (data.containsKey('download_url')) {
      context.handle(
        _downloadUrlMeta,
        downloadUrl.isAcceptableOrUnknown(
          data['download_url']!,
          _downloadUrlMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_downloadUrlMeta);
    }
    if (data.containsKey('size_bytes')) {
      context.handle(
        _sizeBytesMeta,
        sizeBytes.isAcceptableOrUnknown(data['size_bytes']!, _sizeBytesMeta),
      );
    } else if (isInserting) {
      context.missing(_sizeBytesMeta);
    }
    if (data.containsKey('license_note')) {
      context.handle(
        _licenseNoteMeta,
        licenseNote.isAcceptableOrUnknown(
          data['license_note']!,
          _licenseNoteMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_licenseNoteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {packId};
  @override
  ContentPack map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContentPack(
      packId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pack_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}version'],
      )!,
      downloaded: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}downloaded'],
      )!,
      downloadUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}download_url'],
      )!,
      sizeBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}size_bytes'],
      )!,
      licenseNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}license_note'],
      )!,
    );
  }

  @override
  $ContentPacksTable createAlias(String alias) {
    return $ContentPacksTable(attachedDatabase, alias);
  }
}

class ContentPack extends DataClass implements Insertable<ContentPack> {
  final String packId;
  final String type;
  final String name;
  final String version;
  final bool downloaded;
  final String downloadUrl;
  final int sizeBytes;
  final String licenseNote;
  const ContentPack({
    required this.packId,
    required this.type,
    required this.name,
    required this.version,
    required this.downloaded,
    required this.downloadUrl,
    required this.sizeBytes,
    required this.licenseNote,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pack_id'] = Variable<String>(packId);
    map['type'] = Variable<String>(type);
    map['name'] = Variable<String>(name);
    map['version'] = Variable<String>(version);
    map['downloaded'] = Variable<bool>(downloaded);
    map['download_url'] = Variable<String>(downloadUrl);
    map['size_bytes'] = Variable<int>(sizeBytes);
    map['license_note'] = Variable<String>(licenseNote);
    return map;
  }

  ContentPacksCompanion toCompanion(bool nullToAbsent) {
    return ContentPacksCompanion(
      packId: Value(packId),
      type: Value(type),
      name: Value(name),
      version: Value(version),
      downloaded: Value(downloaded),
      downloadUrl: Value(downloadUrl),
      sizeBytes: Value(sizeBytes),
      licenseNote: Value(licenseNote),
    );
  }

  factory ContentPack.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContentPack(
      packId: serializer.fromJson<String>(json['packId']),
      type: serializer.fromJson<String>(json['type']),
      name: serializer.fromJson<String>(json['name']),
      version: serializer.fromJson<String>(json['version']),
      downloaded: serializer.fromJson<bool>(json['downloaded']),
      downloadUrl: serializer.fromJson<String>(json['downloadUrl']),
      sizeBytes: serializer.fromJson<int>(json['sizeBytes']),
      licenseNote: serializer.fromJson<String>(json['licenseNote']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'packId': serializer.toJson<String>(packId),
      'type': serializer.toJson<String>(type),
      'name': serializer.toJson<String>(name),
      'version': serializer.toJson<String>(version),
      'downloaded': serializer.toJson<bool>(downloaded),
      'downloadUrl': serializer.toJson<String>(downloadUrl),
      'sizeBytes': serializer.toJson<int>(sizeBytes),
      'licenseNote': serializer.toJson<String>(licenseNote),
    };
  }

  ContentPack copyWith({
    String? packId,
    String? type,
    String? name,
    String? version,
    bool? downloaded,
    String? downloadUrl,
    int? sizeBytes,
    String? licenseNote,
  }) => ContentPack(
    packId: packId ?? this.packId,
    type: type ?? this.type,
    name: name ?? this.name,
    version: version ?? this.version,
    downloaded: downloaded ?? this.downloaded,
    downloadUrl: downloadUrl ?? this.downloadUrl,
    sizeBytes: sizeBytes ?? this.sizeBytes,
    licenseNote: licenseNote ?? this.licenseNote,
  );
  ContentPack copyWithCompanion(ContentPacksCompanion data) {
    return ContentPack(
      packId: data.packId.present ? data.packId.value : this.packId,
      type: data.type.present ? data.type.value : this.type,
      name: data.name.present ? data.name.value : this.name,
      version: data.version.present ? data.version.value : this.version,
      downloaded: data.downloaded.present
          ? data.downloaded.value
          : this.downloaded,
      downloadUrl: data.downloadUrl.present
          ? data.downloadUrl.value
          : this.downloadUrl,
      sizeBytes: data.sizeBytes.present ? data.sizeBytes.value : this.sizeBytes,
      licenseNote: data.licenseNote.present
          ? data.licenseNote.value
          : this.licenseNote,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContentPack(')
          ..write('packId: $packId, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('version: $version, ')
          ..write('downloaded: $downloaded, ')
          ..write('downloadUrl: $downloadUrl, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('licenseNote: $licenseNote')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    packId,
    type,
    name,
    version,
    downloaded,
    downloadUrl,
    sizeBytes,
    licenseNote,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContentPack &&
          other.packId == this.packId &&
          other.type == this.type &&
          other.name == this.name &&
          other.version == this.version &&
          other.downloaded == this.downloaded &&
          other.downloadUrl == this.downloadUrl &&
          other.sizeBytes == this.sizeBytes &&
          other.licenseNote == this.licenseNote);
}

class ContentPacksCompanion extends UpdateCompanion<ContentPack> {
  final Value<String> packId;
  final Value<String> type;
  final Value<String> name;
  final Value<String> version;
  final Value<bool> downloaded;
  final Value<String> downloadUrl;
  final Value<int> sizeBytes;
  final Value<String> licenseNote;
  final Value<int> rowid;
  const ContentPacksCompanion({
    this.packId = const Value.absent(),
    this.type = const Value.absent(),
    this.name = const Value.absent(),
    this.version = const Value.absent(),
    this.downloaded = const Value.absent(),
    this.downloadUrl = const Value.absent(),
    this.sizeBytes = const Value.absent(),
    this.licenseNote = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ContentPacksCompanion.insert({
    required String packId,
    required String type,
    required String name,
    required String version,
    this.downloaded = const Value.absent(),
    required String downloadUrl,
    required int sizeBytes,
    required String licenseNote,
    this.rowid = const Value.absent(),
  }) : packId = Value(packId),
       type = Value(type),
       name = Value(name),
       version = Value(version),
       downloadUrl = Value(downloadUrl),
       sizeBytes = Value(sizeBytes),
       licenseNote = Value(licenseNote);
  static Insertable<ContentPack> custom({
    Expression<String>? packId,
    Expression<String>? type,
    Expression<String>? name,
    Expression<String>? version,
    Expression<bool>? downloaded,
    Expression<String>? downloadUrl,
    Expression<int>? sizeBytes,
    Expression<String>? licenseNote,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (packId != null) 'pack_id': packId,
      if (type != null) 'type': type,
      if (name != null) 'name': name,
      if (version != null) 'version': version,
      if (downloaded != null) 'downloaded': downloaded,
      if (downloadUrl != null) 'download_url': downloadUrl,
      if (sizeBytes != null) 'size_bytes': sizeBytes,
      if (licenseNote != null) 'license_note': licenseNote,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ContentPacksCompanion copyWith({
    Value<String>? packId,
    Value<String>? type,
    Value<String>? name,
    Value<String>? version,
    Value<bool>? downloaded,
    Value<String>? downloadUrl,
    Value<int>? sizeBytes,
    Value<String>? licenseNote,
    Value<int>? rowid,
  }) {
    return ContentPacksCompanion(
      packId: packId ?? this.packId,
      type: type ?? this.type,
      name: name ?? this.name,
      version: version ?? this.version,
      downloaded: downloaded ?? this.downloaded,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      licenseNote: licenseNote ?? this.licenseNote,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (packId.present) {
      map['pack_id'] = Variable<String>(packId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (version.present) {
      map['version'] = Variable<String>(version.value);
    }
    if (downloaded.present) {
      map['downloaded'] = Variable<bool>(downloaded.value);
    }
    if (downloadUrl.present) {
      map['download_url'] = Variable<String>(downloadUrl.value);
    }
    if (sizeBytes.present) {
      map['size_bytes'] = Variable<int>(sizeBytes.value);
    }
    if (licenseNote.present) {
      map['license_note'] = Variable<String>(licenseNote.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContentPacksCompanion(')
          ..write('packId: $packId, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('version: $version, ')
          ..write('downloaded: $downloaded, ')
          ..write('downloadUrl: $downloadUrl, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('licenseNote: $licenseNote, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TafsirsMetaTable extends TafsirsMeta
    with TableInfo<$TafsirsMetaTable, TafsirMeta> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TafsirsMetaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _tafsirIdMeta = const VerificationMeta(
    'tafsirId',
  );
  @override
  late final GeneratedColumn<String> tafsirId = GeneratedColumn<String>(
    'tafsir_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
    'author',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _languageMeta = const VerificationMeta(
    'language',
  );
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
    'language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _licenseNoteMeta = const VerificationMeta(
    'licenseNote',
  );
  @override
  late final GeneratedColumn<String> licenseNote = GeneratedColumn<String>(
    'license_note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    tafsirId,
    name,
    author,
    language,
    source,
    licenseNote,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tafsirs_meta';
  @override
  VerificationContext validateIntegrity(
    Insertable<TafsirMeta> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('tafsir_id')) {
      context.handle(
        _tafsirIdMeta,
        tafsirId.isAcceptableOrUnknown(data['tafsir_id']!, _tafsirIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tafsirIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('author')) {
      context.handle(
        _authorMeta,
        author.isAcceptableOrUnknown(data['author']!, _authorMeta),
      );
    } else if (isInserting) {
      context.missing(_authorMeta);
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    } else if (isInserting) {
      context.missing(_languageMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('license_note')) {
      context.handle(
        _licenseNoteMeta,
        licenseNote.isAcceptableOrUnknown(
          data['license_note']!,
          _licenseNoteMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_licenseNoteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {tafsirId};
  @override
  TafsirMeta map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TafsirMeta(
      tafsirId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tafsir_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      author: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author'],
      )!,
      language: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      licenseNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}license_note'],
      )!,
    );
  }

  @override
  $TafsirsMetaTable createAlias(String alias) {
    return $TafsirsMetaTable(attachedDatabase, alias);
  }
}

class TafsirMeta extends DataClass implements Insertable<TafsirMeta> {
  final String tafsirId;
  final String name;
  final String author;
  final String language;
  final String source;
  final String licenseNote;
  const TafsirMeta({
    required this.tafsirId,
    required this.name,
    required this.author,
    required this.language,
    required this.source,
    required this.licenseNote,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['tafsir_id'] = Variable<String>(tafsirId);
    map['name'] = Variable<String>(name);
    map['author'] = Variable<String>(author);
    map['language'] = Variable<String>(language);
    map['source'] = Variable<String>(source);
    map['license_note'] = Variable<String>(licenseNote);
    return map;
  }

  TafsirsMetaCompanion toCompanion(bool nullToAbsent) {
    return TafsirsMetaCompanion(
      tafsirId: Value(tafsirId),
      name: Value(name),
      author: Value(author),
      language: Value(language),
      source: Value(source),
      licenseNote: Value(licenseNote),
    );
  }

  factory TafsirMeta.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TafsirMeta(
      tafsirId: serializer.fromJson<String>(json['tafsirId']),
      name: serializer.fromJson<String>(json['name']),
      author: serializer.fromJson<String>(json['author']),
      language: serializer.fromJson<String>(json['language']),
      source: serializer.fromJson<String>(json['source']),
      licenseNote: serializer.fromJson<String>(json['licenseNote']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'tafsirId': serializer.toJson<String>(tafsirId),
      'name': serializer.toJson<String>(name),
      'author': serializer.toJson<String>(author),
      'language': serializer.toJson<String>(language),
      'source': serializer.toJson<String>(source),
      'licenseNote': serializer.toJson<String>(licenseNote),
    };
  }

  TafsirMeta copyWith({
    String? tafsirId,
    String? name,
    String? author,
    String? language,
    String? source,
    String? licenseNote,
  }) => TafsirMeta(
    tafsirId: tafsirId ?? this.tafsirId,
    name: name ?? this.name,
    author: author ?? this.author,
    language: language ?? this.language,
    source: source ?? this.source,
    licenseNote: licenseNote ?? this.licenseNote,
  );
  TafsirMeta copyWithCompanion(TafsirsMetaCompanion data) {
    return TafsirMeta(
      tafsirId: data.tafsirId.present ? data.tafsirId.value : this.tafsirId,
      name: data.name.present ? data.name.value : this.name,
      author: data.author.present ? data.author.value : this.author,
      language: data.language.present ? data.language.value : this.language,
      source: data.source.present ? data.source.value : this.source,
      licenseNote: data.licenseNote.present
          ? data.licenseNote.value
          : this.licenseNote,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TafsirMeta(')
          ..write('tafsirId: $tafsirId, ')
          ..write('name: $name, ')
          ..write('author: $author, ')
          ..write('language: $language, ')
          ..write('source: $source, ')
          ..write('licenseNote: $licenseNote')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(tafsirId, name, author, language, source, licenseNote);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TafsirMeta &&
          other.tafsirId == this.tafsirId &&
          other.name == this.name &&
          other.author == this.author &&
          other.language == this.language &&
          other.source == this.source &&
          other.licenseNote == this.licenseNote);
}

class TafsirsMetaCompanion extends UpdateCompanion<TafsirMeta> {
  final Value<String> tafsirId;
  final Value<String> name;
  final Value<String> author;
  final Value<String> language;
  final Value<String> source;
  final Value<String> licenseNote;
  final Value<int> rowid;
  const TafsirsMetaCompanion({
    this.tafsirId = const Value.absent(),
    this.name = const Value.absent(),
    this.author = const Value.absent(),
    this.language = const Value.absent(),
    this.source = const Value.absent(),
    this.licenseNote = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TafsirsMetaCompanion.insert({
    required String tafsirId,
    required String name,
    required String author,
    required String language,
    required String source,
    required String licenseNote,
    this.rowid = const Value.absent(),
  }) : tafsirId = Value(tafsirId),
       name = Value(name),
       author = Value(author),
       language = Value(language),
       source = Value(source),
       licenseNote = Value(licenseNote);
  static Insertable<TafsirMeta> custom({
    Expression<String>? tafsirId,
    Expression<String>? name,
    Expression<String>? author,
    Expression<String>? language,
    Expression<String>? source,
    Expression<String>? licenseNote,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (tafsirId != null) 'tafsir_id': tafsirId,
      if (name != null) 'name': name,
      if (author != null) 'author': author,
      if (language != null) 'language': language,
      if (source != null) 'source': source,
      if (licenseNote != null) 'license_note': licenseNote,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TafsirsMetaCompanion copyWith({
    Value<String>? tafsirId,
    Value<String>? name,
    Value<String>? author,
    Value<String>? language,
    Value<String>? source,
    Value<String>? licenseNote,
    Value<int>? rowid,
  }) {
    return TafsirsMetaCompanion(
      tafsirId: tafsirId ?? this.tafsirId,
      name: name ?? this.name,
      author: author ?? this.author,
      language: language ?? this.language,
      source: source ?? this.source,
      licenseNote: licenseNote ?? this.licenseNote,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (tafsirId.present) {
      map['tafsir_id'] = Variable<String>(tafsirId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (licenseNote.present) {
      map['license_note'] = Variable<String>(licenseNote.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TafsirsMetaCompanion(')
          ..write('tafsirId: $tafsirId, ')
          ..write('name: $name, ')
          ..write('author: $author, ')
          ..write('language: $language, ')
          ..write('source: $source, ')
          ..write('licenseNote: $licenseNote, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TafsirContentTable extends TafsirContent
    with TableInfo<$TafsirContentTable, TafsirContentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TafsirContentTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tafsirIdMeta = const VerificationMeta(
    'tafsirId',
  );
  @override
  late final GeneratedColumn<String> tafsirId = GeneratedColumn<String>(
    'tafsir_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _surahNumberMeta = const VerificationMeta(
    'surahNumber',
  );
  @override
  late final GeneratedColumn<int> surahNumber = GeneratedColumn<int>(
    'surah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startAyahMeta = const VerificationMeta(
    'startAyah',
  );
  @override
  late final GeneratedColumn<int> startAyah = GeneratedColumn<int>(
    'start_ayah',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endAyahMeta = const VerificationMeta(
    'endAyah',
  );
  @override
  late final GeneratedColumn<int> endAyah = GeneratedColumn<int>(
    'end_ayah',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _textContentMeta = const VerificationMeta(
    'textContent',
  );
  @override
  late final GeneratedColumn<String> textContent = GeneratedColumn<String>(
    'text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tafsirId,
    surahNumber,
    startAyah,
    endAyah,
    textContent,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tafsir_content';
  @override
  VerificationContext validateIntegrity(
    Insertable<TafsirContentData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tafsir_id')) {
      context.handle(
        _tafsirIdMeta,
        tafsirId.isAcceptableOrUnknown(data['tafsir_id']!, _tafsirIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tafsirIdMeta);
    }
    if (data.containsKey('surah_number')) {
      context.handle(
        _surahNumberMeta,
        surahNumber.isAcceptableOrUnknown(
          data['surah_number']!,
          _surahNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_surahNumberMeta);
    }
    if (data.containsKey('start_ayah')) {
      context.handle(
        _startAyahMeta,
        startAyah.isAcceptableOrUnknown(data['start_ayah']!, _startAyahMeta),
      );
    } else if (isInserting) {
      context.missing(_startAyahMeta);
    }
    if (data.containsKey('end_ayah')) {
      context.handle(
        _endAyahMeta,
        endAyah.isAcceptableOrUnknown(data['end_ayah']!, _endAyahMeta),
      );
    } else if (isInserting) {
      context.missing(_endAyahMeta);
    }
    if (data.containsKey('text')) {
      context.handle(
        _textContentMeta,
        textContent.isAcceptableOrUnknown(data['text']!, _textContentMeta),
      );
    } else if (isInserting) {
      context.missing(_textContentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TafsirContentData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TafsirContentData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tafsirId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tafsir_id'],
      )!,
      surahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}surah_number'],
      )!,
      startAyah: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_ayah'],
      )!,
      endAyah: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_ayah'],
      )!,
      textContent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text'],
      )!,
    );
  }

  @override
  $TafsirContentTable createAlias(String alias) {
    return $TafsirContentTable(attachedDatabase, alias);
  }
}

class TafsirContentData extends DataClass
    implements Insertable<TafsirContentData> {
  final int id;
  final String tafsirId;
  final int surahNumber;
  final int startAyah;
  final int endAyah;
  final String textContent;
  const TafsirContentData({
    required this.id,
    required this.tafsirId,
    required this.surahNumber,
    required this.startAyah,
    required this.endAyah,
    required this.textContent,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tafsir_id'] = Variable<String>(tafsirId);
    map['surah_number'] = Variable<int>(surahNumber);
    map['start_ayah'] = Variable<int>(startAyah);
    map['end_ayah'] = Variable<int>(endAyah);
    map['text'] = Variable<String>(textContent);
    return map;
  }

  TafsirContentCompanion toCompanion(bool nullToAbsent) {
    return TafsirContentCompanion(
      id: Value(id),
      tafsirId: Value(tafsirId),
      surahNumber: Value(surahNumber),
      startAyah: Value(startAyah),
      endAyah: Value(endAyah),
      textContent: Value(textContent),
    );
  }

  factory TafsirContentData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TafsirContentData(
      id: serializer.fromJson<int>(json['id']),
      tafsirId: serializer.fromJson<String>(json['tafsirId']),
      surahNumber: serializer.fromJson<int>(json['surahNumber']),
      startAyah: serializer.fromJson<int>(json['startAyah']),
      endAyah: serializer.fromJson<int>(json['endAyah']),
      textContent: serializer.fromJson<String>(json['textContent']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tafsirId': serializer.toJson<String>(tafsirId),
      'surahNumber': serializer.toJson<int>(surahNumber),
      'startAyah': serializer.toJson<int>(startAyah),
      'endAyah': serializer.toJson<int>(endAyah),
      'textContent': serializer.toJson<String>(textContent),
    };
  }

  TafsirContentData copyWith({
    int? id,
    String? tafsirId,
    int? surahNumber,
    int? startAyah,
    int? endAyah,
    String? textContent,
  }) => TafsirContentData(
    id: id ?? this.id,
    tafsirId: tafsirId ?? this.tafsirId,
    surahNumber: surahNumber ?? this.surahNumber,
    startAyah: startAyah ?? this.startAyah,
    endAyah: endAyah ?? this.endAyah,
    textContent: textContent ?? this.textContent,
  );
  TafsirContentData copyWithCompanion(TafsirContentCompanion data) {
    return TafsirContentData(
      id: data.id.present ? data.id.value : this.id,
      tafsirId: data.tafsirId.present ? data.tafsirId.value : this.tafsirId,
      surahNumber: data.surahNumber.present
          ? data.surahNumber.value
          : this.surahNumber,
      startAyah: data.startAyah.present ? data.startAyah.value : this.startAyah,
      endAyah: data.endAyah.present ? data.endAyah.value : this.endAyah,
      textContent: data.textContent.present
          ? data.textContent.value
          : this.textContent,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TafsirContentData(')
          ..write('id: $id, ')
          ..write('tafsirId: $tafsirId, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('startAyah: $startAyah, ')
          ..write('endAyah: $endAyah, ')
          ..write('textContent: $textContent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, tafsirId, surahNumber, startAyah, endAyah, textContent);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TafsirContentData &&
          other.id == this.id &&
          other.tafsirId == this.tafsirId &&
          other.surahNumber == this.surahNumber &&
          other.startAyah == this.startAyah &&
          other.endAyah == this.endAyah &&
          other.textContent == this.textContent);
}

class TafsirContentCompanion extends UpdateCompanion<TafsirContentData> {
  final Value<int> id;
  final Value<String> tafsirId;
  final Value<int> surahNumber;
  final Value<int> startAyah;
  final Value<int> endAyah;
  final Value<String> textContent;
  const TafsirContentCompanion({
    this.id = const Value.absent(),
    this.tafsirId = const Value.absent(),
    this.surahNumber = const Value.absent(),
    this.startAyah = const Value.absent(),
    this.endAyah = const Value.absent(),
    this.textContent = const Value.absent(),
  });
  TafsirContentCompanion.insert({
    this.id = const Value.absent(),
    required String tafsirId,
    required int surahNumber,
    required int startAyah,
    required int endAyah,
    required String textContent,
  }) : tafsirId = Value(tafsirId),
       surahNumber = Value(surahNumber),
       startAyah = Value(startAyah),
       endAyah = Value(endAyah),
       textContent = Value(textContent);
  static Insertable<TafsirContentData> custom({
    Expression<int>? id,
    Expression<String>? tafsirId,
    Expression<int>? surahNumber,
    Expression<int>? startAyah,
    Expression<int>? endAyah,
    Expression<String>? textContent,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tafsirId != null) 'tafsir_id': tafsirId,
      if (surahNumber != null) 'surah_number': surahNumber,
      if (startAyah != null) 'start_ayah': startAyah,
      if (endAyah != null) 'end_ayah': endAyah,
      if (textContent != null) 'text': textContent,
    });
  }

  TafsirContentCompanion copyWith({
    Value<int>? id,
    Value<String>? tafsirId,
    Value<int>? surahNumber,
    Value<int>? startAyah,
    Value<int>? endAyah,
    Value<String>? textContent,
  }) {
    return TafsirContentCompanion(
      id: id ?? this.id,
      tafsirId: tafsirId ?? this.tafsirId,
      surahNumber: surahNumber ?? this.surahNumber,
      startAyah: startAyah ?? this.startAyah,
      endAyah: endAyah ?? this.endAyah,
      textContent: textContent ?? this.textContent,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tafsirId.present) {
      map['tafsir_id'] = Variable<String>(tafsirId.value);
    }
    if (surahNumber.present) {
      map['surah_number'] = Variable<int>(surahNumber.value);
    }
    if (startAyah.present) {
      map['start_ayah'] = Variable<int>(startAyah.value);
    }
    if (endAyah.present) {
      map['end_ayah'] = Variable<int>(endAyah.value);
    }
    if (textContent.present) {
      map['text'] = Variable<String>(textContent.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TafsirContentCompanion(')
          ..write('id: $id, ')
          ..write('tafsirId: $tafsirId, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('startAyah: $startAyah, ')
          ..write('endAyah: $endAyah, ')
          ..write('textContent: $textContent')
          ..write(')'))
        .toString();
  }
}

class $TopicsTable extends Topics with TableInfo<$TopicsTable, Topic> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TopicsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _topicIdMeta = const VerificationMeta(
    'topicId',
  );
  @override
  late final GeneratedColumn<String> topicId = GeneratedColumn<String>(
    'topic_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parentTopicIdMeta = const VerificationMeta(
    'parentTopicId',
  );
  @override
  late final GeneratedColumn<String> parentTopicId = GeneratedColumn<String>(
    'parent_topic_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('General'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    topicId,
    name,
    parentTopicId,
    category,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'topics';
  @override
  VerificationContext validateIntegrity(
    Insertable<Topic> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('topic_id')) {
      context.handle(
        _topicIdMeta,
        topicId.isAcceptableOrUnknown(data['topic_id']!, _topicIdMeta),
      );
    } else if (isInserting) {
      context.missing(_topicIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('parent_topic_id')) {
      context.handle(
        _parentTopicIdMeta,
        parentTopicId.isAcceptableOrUnknown(
          data['parent_topic_id']!,
          _parentTopicIdMeta,
        ),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {topicId};
  @override
  Topic map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Topic(
      topicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}topic_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      parentTopicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_topic_id'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
    );
  }

  @override
  $TopicsTable createAlias(String alias) {
    return $TopicsTable(attachedDatabase, alias);
  }
}

class Topic extends DataClass implements Insertable<Topic> {
  final String topicId;
  final String name;
  final String? parentTopicId;
  final String category;
  const Topic({
    required this.topicId,
    required this.name,
    this.parentTopicId,
    required this.category,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['topic_id'] = Variable<String>(topicId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || parentTopicId != null) {
      map['parent_topic_id'] = Variable<String>(parentTopicId);
    }
    map['category'] = Variable<String>(category);
    return map;
  }

  TopicsCompanion toCompanion(bool nullToAbsent) {
    return TopicsCompanion(
      topicId: Value(topicId),
      name: Value(name),
      parentTopicId: parentTopicId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentTopicId),
      category: Value(category),
    );
  }

  factory Topic.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Topic(
      topicId: serializer.fromJson<String>(json['topicId']),
      name: serializer.fromJson<String>(json['name']),
      parentTopicId: serializer.fromJson<String?>(json['parentTopicId']),
      category: serializer.fromJson<String>(json['category']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'topicId': serializer.toJson<String>(topicId),
      'name': serializer.toJson<String>(name),
      'parentTopicId': serializer.toJson<String?>(parentTopicId),
      'category': serializer.toJson<String>(category),
    };
  }

  Topic copyWith({
    String? topicId,
    String? name,
    Value<String?> parentTopicId = const Value.absent(),
    String? category,
  }) => Topic(
    topicId: topicId ?? this.topicId,
    name: name ?? this.name,
    parentTopicId: parentTopicId.present
        ? parentTopicId.value
        : this.parentTopicId,
    category: category ?? this.category,
  );
  Topic copyWithCompanion(TopicsCompanion data) {
    return Topic(
      topicId: data.topicId.present ? data.topicId.value : this.topicId,
      name: data.name.present ? data.name.value : this.name,
      parentTopicId: data.parentTopicId.present
          ? data.parentTopicId.value
          : this.parentTopicId,
      category: data.category.present ? data.category.value : this.category,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Topic(')
          ..write('topicId: $topicId, ')
          ..write('name: $name, ')
          ..write('parentTopicId: $parentTopicId, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(topicId, name, parentTopicId, category);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Topic &&
          other.topicId == this.topicId &&
          other.name == this.name &&
          other.parentTopicId == this.parentTopicId &&
          other.category == this.category);
}

class TopicsCompanion extends UpdateCompanion<Topic> {
  final Value<String> topicId;
  final Value<String> name;
  final Value<String?> parentTopicId;
  final Value<String> category;
  final Value<int> rowid;
  const TopicsCompanion({
    this.topicId = const Value.absent(),
    this.name = const Value.absent(),
    this.parentTopicId = const Value.absent(),
    this.category = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TopicsCompanion.insert({
    required String topicId,
    required String name,
    this.parentTopicId = const Value.absent(),
    this.category = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : topicId = Value(topicId),
       name = Value(name);
  static Insertable<Topic> custom({
    Expression<String>? topicId,
    Expression<String>? name,
    Expression<String>? parentTopicId,
    Expression<String>? category,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (topicId != null) 'topic_id': topicId,
      if (name != null) 'name': name,
      if (parentTopicId != null) 'parent_topic_id': parentTopicId,
      if (category != null) 'category': category,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TopicsCompanion copyWith({
    Value<String>? topicId,
    Value<String>? name,
    Value<String?>? parentTopicId,
    Value<String>? category,
    Value<int>? rowid,
  }) {
    return TopicsCompanion(
      topicId: topicId ?? this.topicId,
      name: name ?? this.name,
      parentTopicId: parentTopicId ?? this.parentTopicId,
      category: category ?? this.category,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (topicId.present) {
      map['topic_id'] = Variable<String>(topicId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (parentTopicId.present) {
      map['parent_topic_id'] = Variable<String>(parentTopicId.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TopicsCompanion(')
          ..write('topicId: $topicId, ')
          ..write('name: $name, ')
          ..write('parentTopicId: $parentTopicId, ')
          ..write('category: $category, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TopicAyahsTable extends TopicAyahs
    with TableInfo<$TopicAyahsTable, TopicAyah> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TopicAyahsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _topicIdMeta = const VerificationMeta(
    'topicId',
  );
  @override
  late final GeneratedColumn<String> topicId = GeneratedColumn<String>(
    'topic_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'REFERENCES topics(topic_id) NOT NULL',
  );
  static const VerificationMeta _surahNumberMeta = const VerificationMeta(
    'surahNumber',
  );
  @override
  late final GeneratedColumn<int> surahNumber = GeneratedColumn<int>(
    'surah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ayahNumberMeta = const VerificationMeta(
    'ayahNumber',
  );
  @override
  late final GeneratedColumn<int> ayahNumber = GeneratedColumn<int>(
    'ayah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [topicId, surahNumber, ayahNumber];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'topic_ayahs';
  @override
  VerificationContext validateIntegrity(
    Insertable<TopicAyah> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('topic_id')) {
      context.handle(
        _topicIdMeta,
        topicId.isAcceptableOrUnknown(data['topic_id']!, _topicIdMeta),
      );
    } else if (isInserting) {
      context.missing(_topicIdMeta);
    }
    if (data.containsKey('surah_number')) {
      context.handle(
        _surahNumberMeta,
        surahNumber.isAcceptableOrUnknown(
          data['surah_number']!,
          _surahNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_surahNumberMeta);
    }
    if (data.containsKey('ayah_number')) {
      context.handle(
        _ayahNumberMeta,
        ayahNumber.isAcceptableOrUnknown(data['ayah_number']!, _ayahNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_ayahNumberMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {topicId, surahNumber, ayahNumber};
  @override
  TopicAyah map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TopicAyah(
      topicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}topic_id'],
      )!,
      surahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}surah_number'],
      )!,
      ayahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ayah_number'],
      )!,
    );
  }

  @override
  $TopicAyahsTable createAlias(String alias) {
    return $TopicAyahsTable(attachedDatabase, alias);
  }
}

class TopicAyah extends DataClass implements Insertable<TopicAyah> {
  final String topicId;
  final int surahNumber;
  final int ayahNumber;
  const TopicAyah({
    required this.topicId,
    required this.surahNumber,
    required this.ayahNumber,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['topic_id'] = Variable<String>(topicId);
    map['surah_number'] = Variable<int>(surahNumber);
    map['ayah_number'] = Variable<int>(ayahNumber);
    return map;
  }

  TopicAyahsCompanion toCompanion(bool nullToAbsent) {
    return TopicAyahsCompanion(
      topicId: Value(topicId),
      surahNumber: Value(surahNumber),
      ayahNumber: Value(ayahNumber),
    );
  }

  factory TopicAyah.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TopicAyah(
      topicId: serializer.fromJson<String>(json['topicId']),
      surahNumber: serializer.fromJson<int>(json['surahNumber']),
      ayahNumber: serializer.fromJson<int>(json['ayahNumber']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'topicId': serializer.toJson<String>(topicId),
      'surahNumber': serializer.toJson<int>(surahNumber),
      'ayahNumber': serializer.toJson<int>(ayahNumber),
    };
  }

  TopicAyah copyWith({String? topicId, int? surahNumber, int? ayahNumber}) =>
      TopicAyah(
        topicId: topicId ?? this.topicId,
        surahNumber: surahNumber ?? this.surahNumber,
        ayahNumber: ayahNumber ?? this.ayahNumber,
      );
  TopicAyah copyWithCompanion(TopicAyahsCompanion data) {
    return TopicAyah(
      topicId: data.topicId.present ? data.topicId.value : this.topicId,
      surahNumber: data.surahNumber.present
          ? data.surahNumber.value
          : this.surahNumber,
      ayahNumber: data.ayahNumber.present
          ? data.ayahNumber.value
          : this.ayahNumber,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TopicAyah(')
          ..write('topicId: $topicId, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(topicId, surahNumber, ayahNumber);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TopicAyah &&
          other.topicId == this.topicId &&
          other.surahNumber == this.surahNumber &&
          other.ayahNumber == this.ayahNumber);
}

class TopicAyahsCompanion extends UpdateCompanion<TopicAyah> {
  final Value<String> topicId;
  final Value<int> surahNumber;
  final Value<int> ayahNumber;
  final Value<int> rowid;
  const TopicAyahsCompanion({
    this.topicId = const Value.absent(),
    this.surahNumber = const Value.absent(),
    this.ayahNumber = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TopicAyahsCompanion.insert({
    required String topicId,
    required int surahNumber,
    required int ayahNumber,
    this.rowid = const Value.absent(),
  }) : topicId = Value(topicId),
       surahNumber = Value(surahNumber),
       ayahNumber = Value(ayahNumber);
  static Insertable<TopicAyah> custom({
    Expression<String>? topicId,
    Expression<int>? surahNumber,
    Expression<int>? ayahNumber,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (topicId != null) 'topic_id': topicId,
      if (surahNumber != null) 'surah_number': surahNumber,
      if (ayahNumber != null) 'ayah_number': ayahNumber,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TopicAyahsCompanion copyWith({
    Value<String>? topicId,
    Value<int>? surahNumber,
    Value<int>? ayahNumber,
    Value<int>? rowid,
  }) {
    return TopicAyahsCompanion(
      topicId: topicId ?? this.topicId,
      surahNumber: surahNumber ?? this.surahNumber,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (topicId.present) {
      map['topic_id'] = Variable<String>(topicId.value);
    }
    if (surahNumber.present) {
      map['surah_number'] = Variable<int>(surahNumber.value);
    }
    if (ayahNumber.present) {
      map['ayah_number'] = Variable<int>(ayahNumber.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TopicAyahsCompanion(')
          ..write('topicId: $topicId, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CrossReferencesTable extends CrossReferences
    with TableInfo<$CrossReferencesTable, CrossReference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CrossReferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _sourceSurahMeta = const VerificationMeta(
    'sourceSurah',
  );
  @override
  late final GeneratedColumn<int> sourceSurah = GeneratedColumn<int>(
    'source_surah',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceAyahMeta = const VerificationMeta(
    'sourceAyah',
  );
  @override
  late final GeneratedColumn<int> sourceAyah = GeneratedColumn<int>(
    'source_ayah',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetSurahMeta = const VerificationMeta(
    'targetSurah',
  );
  @override
  late final GeneratedColumn<int> targetSurah = GeneratedColumn<int>(
    'target_surah',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetAyahMeta = const VerificationMeta(
    'targetAyah',
  );
  @override
  late final GeneratedColumn<int> targetAyah = GeneratedColumn<int>(
    'target_ayah',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _relationshipTypeMeta = const VerificationMeta(
    'relationshipType',
  );
  @override
  late final GeneratedColumn<String> relationshipType = GeneratedColumn<String>(
    'relationship_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sourceSurah,
    sourceAyah,
    targetSurah,
    targetAyah,
    relationshipType,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cross_references';
  @override
  VerificationContext validateIntegrity(
    Insertable<CrossReference> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('source_surah')) {
      context.handle(
        _sourceSurahMeta,
        sourceSurah.isAcceptableOrUnknown(
          data['source_surah']!,
          _sourceSurahMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourceSurahMeta);
    }
    if (data.containsKey('source_ayah')) {
      context.handle(
        _sourceAyahMeta,
        sourceAyah.isAcceptableOrUnknown(data['source_ayah']!, _sourceAyahMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceAyahMeta);
    }
    if (data.containsKey('target_surah')) {
      context.handle(
        _targetSurahMeta,
        targetSurah.isAcceptableOrUnknown(
          data['target_surah']!,
          _targetSurahMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetSurahMeta);
    }
    if (data.containsKey('target_ayah')) {
      context.handle(
        _targetAyahMeta,
        targetAyah.isAcceptableOrUnknown(data['target_ayah']!, _targetAyahMeta),
      );
    } else if (isInserting) {
      context.missing(_targetAyahMeta);
    }
    if (data.containsKey('relationship_type')) {
      context.handle(
        _relationshipTypeMeta,
        relationshipType.isAcceptableOrUnknown(
          data['relationship_type']!,
          _relationshipTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_relationshipTypeMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CrossReference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CrossReference(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sourceSurah: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}source_surah'],
      )!,
      sourceAyah: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}source_ayah'],
      )!,
      targetSurah: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_surah'],
      )!,
      targetAyah: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_ayah'],
      )!,
      relationshipType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relationship_type'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
    );
  }

  @override
  $CrossReferencesTable createAlias(String alias) {
    return $CrossReferencesTable(attachedDatabase, alias);
  }
}

class CrossReference extends DataClass implements Insertable<CrossReference> {
  final int id;
  final int sourceSurah;
  final int sourceAyah;
  final int targetSurah;
  final int targetAyah;
  final String relationshipType;
  final String notes;
  const CrossReference({
    required this.id,
    required this.sourceSurah,
    required this.sourceAyah,
    required this.targetSurah,
    required this.targetAyah,
    required this.relationshipType,
    required this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['source_surah'] = Variable<int>(sourceSurah);
    map['source_ayah'] = Variable<int>(sourceAyah);
    map['target_surah'] = Variable<int>(targetSurah);
    map['target_ayah'] = Variable<int>(targetAyah);
    map['relationship_type'] = Variable<String>(relationshipType);
    map['notes'] = Variable<String>(notes);
    return map;
  }

  CrossReferencesCompanion toCompanion(bool nullToAbsent) {
    return CrossReferencesCompanion(
      id: Value(id),
      sourceSurah: Value(sourceSurah),
      sourceAyah: Value(sourceAyah),
      targetSurah: Value(targetSurah),
      targetAyah: Value(targetAyah),
      relationshipType: Value(relationshipType),
      notes: Value(notes),
    );
  }

  factory CrossReference.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CrossReference(
      id: serializer.fromJson<int>(json['id']),
      sourceSurah: serializer.fromJson<int>(json['sourceSurah']),
      sourceAyah: serializer.fromJson<int>(json['sourceAyah']),
      targetSurah: serializer.fromJson<int>(json['targetSurah']),
      targetAyah: serializer.fromJson<int>(json['targetAyah']),
      relationshipType: serializer.fromJson<String>(json['relationshipType']),
      notes: serializer.fromJson<String>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sourceSurah': serializer.toJson<int>(sourceSurah),
      'sourceAyah': serializer.toJson<int>(sourceAyah),
      'targetSurah': serializer.toJson<int>(targetSurah),
      'targetAyah': serializer.toJson<int>(targetAyah),
      'relationshipType': serializer.toJson<String>(relationshipType),
      'notes': serializer.toJson<String>(notes),
    };
  }

  CrossReference copyWith({
    int? id,
    int? sourceSurah,
    int? sourceAyah,
    int? targetSurah,
    int? targetAyah,
    String? relationshipType,
    String? notes,
  }) => CrossReference(
    id: id ?? this.id,
    sourceSurah: sourceSurah ?? this.sourceSurah,
    sourceAyah: sourceAyah ?? this.sourceAyah,
    targetSurah: targetSurah ?? this.targetSurah,
    targetAyah: targetAyah ?? this.targetAyah,
    relationshipType: relationshipType ?? this.relationshipType,
    notes: notes ?? this.notes,
  );
  CrossReference copyWithCompanion(CrossReferencesCompanion data) {
    return CrossReference(
      id: data.id.present ? data.id.value : this.id,
      sourceSurah: data.sourceSurah.present
          ? data.sourceSurah.value
          : this.sourceSurah,
      sourceAyah: data.sourceAyah.present
          ? data.sourceAyah.value
          : this.sourceAyah,
      targetSurah: data.targetSurah.present
          ? data.targetSurah.value
          : this.targetSurah,
      targetAyah: data.targetAyah.present
          ? data.targetAyah.value
          : this.targetAyah,
      relationshipType: data.relationshipType.present
          ? data.relationshipType.value
          : this.relationshipType,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CrossReference(')
          ..write('id: $id, ')
          ..write('sourceSurah: $sourceSurah, ')
          ..write('sourceAyah: $sourceAyah, ')
          ..write('targetSurah: $targetSurah, ')
          ..write('targetAyah: $targetAyah, ')
          ..write('relationshipType: $relationshipType, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sourceSurah,
    sourceAyah,
    targetSurah,
    targetAyah,
    relationshipType,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CrossReference &&
          other.id == this.id &&
          other.sourceSurah == this.sourceSurah &&
          other.sourceAyah == this.sourceAyah &&
          other.targetSurah == this.targetSurah &&
          other.targetAyah == this.targetAyah &&
          other.relationshipType == this.relationshipType &&
          other.notes == this.notes);
}

class CrossReferencesCompanion extends UpdateCompanion<CrossReference> {
  final Value<int> id;
  final Value<int> sourceSurah;
  final Value<int> sourceAyah;
  final Value<int> targetSurah;
  final Value<int> targetAyah;
  final Value<String> relationshipType;
  final Value<String> notes;
  const CrossReferencesCompanion({
    this.id = const Value.absent(),
    this.sourceSurah = const Value.absent(),
    this.sourceAyah = const Value.absent(),
    this.targetSurah = const Value.absent(),
    this.targetAyah = const Value.absent(),
    this.relationshipType = const Value.absent(),
    this.notes = const Value.absent(),
  });
  CrossReferencesCompanion.insert({
    this.id = const Value.absent(),
    required int sourceSurah,
    required int sourceAyah,
    required int targetSurah,
    required int targetAyah,
    required String relationshipType,
    this.notes = const Value.absent(),
  }) : sourceSurah = Value(sourceSurah),
       sourceAyah = Value(sourceAyah),
       targetSurah = Value(targetSurah),
       targetAyah = Value(targetAyah),
       relationshipType = Value(relationshipType);
  static Insertable<CrossReference> custom({
    Expression<int>? id,
    Expression<int>? sourceSurah,
    Expression<int>? sourceAyah,
    Expression<int>? targetSurah,
    Expression<int>? targetAyah,
    Expression<String>? relationshipType,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceSurah != null) 'source_surah': sourceSurah,
      if (sourceAyah != null) 'source_ayah': sourceAyah,
      if (targetSurah != null) 'target_surah': targetSurah,
      if (targetAyah != null) 'target_ayah': targetAyah,
      if (relationshipType != null) 'relationship_type': relationshipType,
      if (notes != null) 'notes': notes,
    });
  }

  CrossReferencesCompanion copyWith({
    Value<int>? id,
    Value<int>? sourceSurah,
    Value<int>? sourceAyah,
    Value<int>? targetSurah,
    Value<int>? targetAyah,
    Value<String>? relationshipType,
    Value<String>? notes,
  }) {
    return CrossReferencesCompanion(
      id: id ?? this.id,
      sourceSurah: sourceSurah ?? this.sourceSurah,
      sourceAyah: sourceAyah ?? this.sourceAyah,
      targetSurah: targetSurah ?? this.targetSurah,
      targetAyah: targetAyah ?? this.targetAyah,
      relationshipType: relationshipType ?? this.relationshipType,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sourceSurah.present) {
      map['source_surah'] = Variable<int>(sourceSurah.value);
    }
    if (sourceAyah.present) {
      map['source_ayah'] = Variable<int>(sourceAyah.value);
    }
    if (targetSurah.present) {
      map['target_surah'] = Variable<int>(targetSurah.value);
    }
    if (targetAyah.present) {
      map['target_ayah'] = Variable<int>(targetAyah.value);
    }
    if (relationshipType.present) {
      map['relationship_type'] = Variable<String>(relationshipType.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CrossReferencesCompanion(')
          ..write('id: $id, ')
          ..write('sourceSurah: $sourceSurah, ')
          ..write('sourceAyah: $sourceAyah, ')
          ..write('targetSurah: $targetSurah, ')
          ..write('targetAyah: $targetAyah, ')
          ..write('relationshipType: $relationshipType, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $AsbabAlNuzulTable extends AsbabAlNuzul
    with TableInfo<$AsbabAlNuzulTable, AsbabAlNuzulEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AsbabAlNuzulTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _surahNumberMeta = const VerificationMeta(
    'surahNumber',
  );
  @override
  late final GeneratedColumn<int> surahNumber = GeneratedColumn<int>(
    'surah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startAyahMeta = const VerificationMeta(
    'startAyah',
  );
  @override
  late final GeneratedColumn<int> startAyah = GeneratedColumn<int>(
    'start_ayah',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endAyahMeta = const VerificationMeta(
    'endAyah',
  );
  @override
  late final GeneratedColumn<int> endAyah = GeneratedColumn<int>(
    'end_ayah',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _textContentMeta = const VerificationMeta(
    'textContent',
  );
  @override
  late final GeneratedColumn<String> textContent = GeneratedColumn<String>(
    'text_content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceNoteMeta = const VerificationMeta(
    'sourceNote',
  );
  @override
  late final GeneratedColumn<String> sourceNote = GeneratedColumn<String>(
    'source_note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    surahNumber,
    startAyah,
    endAyah,
    textContent,
    sourceNote,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'asbab_al_nuzul';
  @override
  VerificationContext validateIntegrity(
    Insertable<AsbabAlNuzulEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('surah_number')) {
      context.handle(
        _surahNumberMeta,
        surahNumber.isAcceptableOrUnknown(
          data['surah_number']!,
          _surahNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_surahNumberMeta);
    }
    if (data.containsKey('start_ayah')) {
      context.handle(
        _startAyahMeta,
        startAyah.isAcceptableOrUnknown(data['start_ayah']!, _startAyahMeta),
      );
    } else if (isInserting) {
      context.missing(_startAyahMeta);
    }
    if (data.containsKey('end_ayah')) {
      context.handle(
        _endAyahMeta,
        endAyah.isAcceptableOrUnknown(data['end_ayah']!, _endAyahMeta),
      );
    } else if (isInserting) {
      context.missing(_endAyahMeta);
    }
    if (data.containsKey('text_content')) {
      context.handle(
        _textContentMeta,
        textContent.isAcceptableOrUnknown(
          data['text_content']!,
          _textContentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_textContentMeta);
    }
    if (data.containsKey('source_note')) {
      context.handle(
        _sourceNoteMeta,
        sourceNote.isAcceptableOrUnknown(data['source_note']!, _sourceNoteMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceNoteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AsbabAlNuzulEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AsbabAlNuzulEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      surahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}surah_number'],
      )!,
      startAyah: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_ayah'],
      )!,
      endAyah: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_ayah'],
      )!,
      textContent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_content'],
      )!,
      sourceNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_note'],
      )!,
    );
  }

  @override
  $AsbabAlNuzulTable createAlias(String alias) {
    return $AsbabAlNuzulTable(attachedDatabase, alias);
  }
}

class AsbabAlNuzulEntry extends DataClass
    implements Insertable<AsbabAlNuzulEntry> {
  final int id;
  final int surahNumber;
  final int startAyah;
  final int endAyah;
  final String textContent;
  final String sourceNote;
  const AsbabAlNuzulEntry({
    required this.id,
    required this.surahNumber,
    required this.startAyah,
    required this.endAyah,
    required this.textContent,
    required this.sourceNote,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['surah_number'] = Variable<int>(surahNumber);
    map['start_ayah'] = Variable<int>(startAyah);
    map['end_ayah'] = Variable<int>(endAyah);
    map['text_content'] = Variable<String>(textContent);
    map['source_note'] = Variable<String>(sourceNote);
    return map;
  }

  AsbabAlNuzulCompanion toCompanion(bool nullToAbsent) {
    return AsbabAlNuzulCompanion(
      id: Value(id),
      surahNumber: Value(surahNumber),
      startAyah: Value(startAyah),
      endAyah: Value(endAyah),
      textContent: Value(textContent),
      sourceNote: Value(sourceNote),
    );
  }

  factory AsbabAlNuzulEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AsbabAlNuzulEntry(
      id: serializer.fromJson<int>(json['id']),
      surahNumber: serializer.fromJson<int>(json['surahNumber']),
      startAyah: serializer.fromJson<int>(json['startAyah']),
      endAyah: serializer.fromJson<int>(json['endAyah']),
      textContent: serializer.fromJson<String>(json['textContent']),
      sourceNote: serializer.fromJson<String>(json['sourceNote']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'surahNumber': serializer.toJson<int>(surahNumber),
      'startAyah': serializer.toJson<int>(startAyah),
      'endAyah': serializer.toJson<int>(endAyah),
      'textContent': serializer.toJson<String>(textContent),
      'sourceNote': serializer.toJson<String>(sourceNote),
    };
  }

  AsbabAlNuzulEntry copyWith({
    int? id,
    int? surahNumber,
    int? startAyah,
    int? endAyah,
    String? textContent,
    String? sourceNote,
  }) => AsbabAlNuzulEntry(
    id: id ?? this.id,
    surahNumber: surahNumber ?? this.surahNumber,
    startAyah: startAyah ?? this.startAyah,
    endAyah: endAyah ?? this.endAyah,
    textContent: textContent ?? this.textContent,
    sourceNote: sourceNote ?? this.sourceNote,
  );
  AsbabAlNuzulEntry copyWithCompanion(AsbabAlNuzulCompanion data) {
    return AsbabAlNuzulEntry(
      id: data.id.present ? data.id.value : this.id,
      surahNumber: data.surahNumber.present
          ? data.surahNumber.value
          : this.surahNumber,
      startAyah: data.startAyah.present ? data.startAyah.value : this.startAyah,
      endAyah: data.endAyah.present ? data.endAyah.value : this.endAyah,
      textContent: data.textContent.present
          ? data.textContent.value
          : this.textContent,
      sourceNote: data.sourceNote.present
          ? data.sourceNote.value
          : this.sourceNote,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AsbabAlNuzulEntry(')
          ..write('id: $id, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('startAyah: $startAyah, ')
          ..write('endAyah: $endAyah, ')
          ..write('textContent: $textContent, ')
          ..write('sourceNote: $sourceNote')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, surahNumber, startAyah, endAyah, textContent, sourceNote);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AsbabAlNuzulEntry &&
          other.id == this.id &&
          other.surahNumber == this.surahNumber &&
          other.startAyah == this.startAyah &&
          other.endAyah == this.endAyah &&
          other.textContent == this.textContent &&
          other.sourceNote == this.sourceNote);
}

class AsbabAlNuzulCompanion extends UpdateCompanion<AsbabAlNuzulEntry> {
  final Value<int> id;
  final Value<int> surahNumber;
  final Value<int> startAyah;
  final Value<int> endAyah;
  final Value<String> textContent;
  final Value<String> sourceNote;
  const AsbabAlNuzulCompanion({
    this.id = const Value.absent(),
    this.surahNumber = const Value.absent(),
    this.startAyah = const Value.absent(),
    this.endAyah = const Value.absent(),
    this.textContent = const Value.absent(),
    this.sourceNote = const Value.absent(),
  });
  AsbabAlNuzulCompanion.insert({
    this.id = const Value.absent(),
    required int surahNumber,
    required int startAyah,
    required int endAyah,
    required String textContent,
    required String sourceNote,
  }) : surahNumber = Value(surahNumber),
       startAyah = Value(startAyah),
       endAyah = Value(endAyah),
       textContent = Value(textContent),
       sourceNote = Value(sourceNote);
  static Insertable<AsbabAlNuzulEntry> custom({
    Expression<int>? id,
    Expression<int>? surahNumber,
    Expression<int>? startAyah,
    Expression<int>? endAyah,
    Expression<String>? textContent,
    Expression<String>? sourceNote,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surahNumber != null) 'surah_number': surahNumber,
      if (startAyah != null) 'start_ayah': startAyah,
      if (endAyah != null) 'end_ayah': endAyah,
      if (textContent != null) 'text_content': textContent,
      if (sourceNote != null) 'source_note': sourceNote,
    });
  }

  AsbabAlNuzulCompanion copyWith({
    Value<int>? id,
    Value<int>? surahNumber,
    Value<int>? startAyah,
    Value<int>? endAyah,
    Value<String>? textContent,
    Value<String>? sourceNote,
  }) {
    return AsbabAlNuzulCompanion(
      id: id ?? this.id,
      surahNumber: surahNumber ?? this.surahNumber,
      startAyah: startAyah ?? this.startAyah,
      endAyah: endAyah ?? this.endAyah,
      textContent: textContent ?? this.textContent,
      sourceNote: sourceNote ?? this.sourceNote,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (surahNumber.present) {
      map['surah_number'] = Variable<int>(surahNumber.value);
    }
    if (startAyah.present) {
      map['start_ayah'] = Variable<int>(startAyah.value);
    }
    if (endAyah.present) {
      map['end_ayah'] = Variable<int>(endAyah.value);
    }
    if (textContent.present) {
      map['text_content'] = Variable<String>(textContent.value);
    }
    if (sourceNote.present) {
      map['source_note'] = Variable<String>(sourceNote.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AsbabAlNuzulCompanion(')
          ..write('id: $id, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('startAyah: $startAyah, ')
          ..write('endAyah: $endAyah, ')
          ..write('textContent: $textContent, ')
          ..write('sourceNote: $sourceNote')
          ..write(')'))
        .toString();
  }
}

class $CollectionsTable extends Collections
    with TableInfo<$CollectionsTable, WorkspaceCollection> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CollectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _collectionIdMeta = const VerificationMeta(
    'collectionId',
  );
  @override
  late final GeneratedColumn<String> collectionId = GeneratedColumn<String>(
    'collection_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    collectionId,
    name,
    description,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'collections';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkspaceCollection> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('collection_id')) {
      context.handle(
        _collectionIdMeta,
        collectionId.isAcceptableOrUnknown(
          data['collection_id']!,
          _collectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_collectionIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {collectionId};
  @override
  WorkspaceCollection map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkspaceCollection(
      collectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}collection_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CollectionsTable createAlias(String alias) {
    return $CollectionsTable(attachedDatabase, alias);
  }
}

class WorkspaceCollection extends DataClass
    implements Insertable<WorkspaceCollection> {
  final String collectionId;
  final String name;
  final String description;
  final DateTime createdAt;
  const WorkspaceCollection({
    required this.collectionId,
    required this.name,
    required this.description,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['collection_id'] = Variable<String>(collectionId);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CollectionsCompanion toCompanion(bool nullToAbsent) {
    return CollectionsCompanion(
      collectionId: Value(collectionId),
      name: Value(name),
      description: Value(description),
      createdAt: Value(createdAt),
    );
  }

  factory WorkspaceCollection.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkspaceCollection(
      collectionId: serializer.fromJson<String>(json['collectionId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'collectionId': serializer.toJson<String>(collectionId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  WorkspaceCollection copyWith({
    String? collectionId,
    String? name,
    String? description,
    DateTime? createdAt,
  }) => WorkspaceCollection(
    collectionId: collectionId ?? this.collectionId,
    name: name ?? this.name,
    description: description ?? this.description,
    createdAt: createdAt ?? this.createdAt,
  );
  WorkspaceCollection copyWithCompanion(CollectionsCompanion data) {
    return WorkspaceCollection(
      collectionId: data.collectionId.present
          ? data.collectionId.value
          : this.collectionId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkspaceCollection(')
          ..write('collectionId: $collectionId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(collectionId, name, description, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkspaceCollection &&
          other.collectionId == this.collectionId &&
          other.name == this.name &&
          other.description == this.description &&
          other.createdAt == this.createdAt);
}

class CollectionsCompanion extends UpdateCompanion<WorkspaceCollection> {
  final Value<String> collectionId;
  final Value<String> name;
  final Value<String> description;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const CollectionsCompanion({
    this.collectionId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CollectionsCompanion.insert({
    required String collectionId,
    required String name,
    this.description = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : collectionId = Value(collectionId),
       name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<WorkspaceCollection> custom({
    Expression<String>? collectionId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (collectionId != null) 'collection_id': collectionId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CollectionsCompanion copyWith({
    Value<String>? collectionId,
    Value<String>? name,
    Value<String>? description,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return CollectionsCompanion(
      collectionId: collectionId ?? this.collectionId,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (collectionId.present) {
      map['collection_id'] = Variable<String>(collectionId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CollectionsCompanion(')
          ..write('collectionId: $collectionId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BookmarksTable extends Bookmarks
    with TableInfo<$BookmarksTable, Bookmark> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookmarksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _surahNumberMeta = const VerificationMeta(
    'surahNumber',
  );
  @override
  late final GeneratedColumn<int> surahNumber = GeneratedColumn<int>(
    'surah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ayahNumberMeta = const VerificationMeta(
    'ayahNumber',
  );
  @override
  late final GeneratedColumn<int> ayahNumber = GeneratedColumn<int>(
    'ayah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _collectionIdMeta = const VerificationMeta(
    'collectionId',
  );
  @override
  late final GeneratedColumn<String> collectionId = GeneratedColumn<String>(
    'collection_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'REFERENCES collections(collection_id)',
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    surahNumber,
    ayahNumber,
    collectionId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookmarks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Bookmark> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('surah_number')) {
      context.handle(
        _surahNumberMeta,
        surahNumber.isAcceptableOrUnknown(
          data['surah_number']!,
          _surahNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_surahNumberMeta);
    }
    if (data.containsKey('ayah_number')) {
      context.handle(
        _ayahNumberMeta,
        ayahNumber.isAcceptableOrUnknown(data['ayah_number']!, _ayahNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_ayahNumberMeta);
    }
    if (data.containsKey('collection_id')) {
      context.handle(
        _collectionIdMeta,
        collectionId.isAcceptableOrUnknown(
          data['collection_id']!,
          _collectionIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Bookmark map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Bookmark(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      surahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}surah_number'],
      )!,
      ayahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ayah_number'],
      )!,
      collectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}collection_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $BookmarksTable createAlias(String alias) {
    return $BookmarksTable(attachedDatabase, alias);
  }
}

class Bookmark extends DataClass implements Insertable<Bookmark> {
  final int id;
  final int surahNumber;
  final int ayahNumber;
  final String? collectionId;
  final DateTime createdAt;
  const Bookmark({
    required this.id,
    required this.surahNumber,
    required this.ayahNumber,
    this.collectionId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['surah_number'] = Variable<int>(surahNumber);
    map['ayah_number'] = Variable<int>(ayahNumber);
    if (!nullToAbsent || collectionId != null) {
      map['collection_id'] = Variable<String>(collectionId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BookmarksCompanion toCompanion(bool nullToAbsent) {
    return BookmarksCompanion(
      id: Value(id),
      surahNumber: Value(surahNumber),
      ayahNumber: Value(ayahNumber),
      collectionId: collectionId == null && nullToAbsent
          ? const Value.absent()
          : Value(collectionId),
      createdAt: Value(createdAt),
    );
  }

  factory Bookmark.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Bookmark(
      id: serializer.fromJson<int>(json['id']),
      surahNumber: serializer.fromJson<int>(json['surahNumber']),
      ayahNumber: serializer.fromJson<int>(json['ayahNumber']),
      collectionId: serializer.fromJson<String?>(json['collectionId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'surahNumber': serializer.toJson<int>(surahNumber),
      'ayahNumber': serializer.toJson<int>(ayahNumber),
      'collectionId': serializer.toJson<String?>(collectionId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Bookmark copyWith({
    int? id,
    int? surahNumber,
    int? ayahNumber,
    Value<String?> collectionId = const Value.absent(),
    DateTime? createdAt,
  }) => Bookmark(
    id: id ?? this.id,
    surahNumber: surahNumber ?? this.surahNumber,
    ayahNumber: ayahNumber ?? this.ayahNumber,
    collectionId: collectionId.present ? collectionId.value : this.collectionId,
    createdAt: createdAt ?? this.createdAt,
  );
  Bookmark copyWithCompanion(BookmarksCompanion data) {
    return Bookmark(
      id: data.id.present ? data.id.value : this.id,
      surahNumber: data.surahNumber.present
          ? data.surahNumber.value
          : this.surahNumber,
      ayahNumber: data.ayahNumber.present
          ? data.ayahNumber.value
          : this.ayahNumber,
      collectionId: data.collectionId.present
          ? data.collectionId.value
          : this.collectionId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Bookmark(')
          ..write('id: $id, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('collectionId: $collectionId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, surahNumber, ayahNumber, collectionId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bookmark &&
          other.id == this.id &&
          other.surahNumber == this.surahNumber &&
          other.ayahNumber == this.ayahNumber &&
          other.collectionId == this.collectionId &&
          other.createdAt == this.createdAt);
}

class BookmarksCompanion extends UpdateCompanion<Bookmark> {
  final Value<int> id;
  final Value<int> surahNumber;
  final Value<int> ayahNumber;
  final Value<String?> collectionId;
  final Value<DateTime> createdAt;
  const BookmarksCompanion({
    this.id = const Value.absent(),
    this.surahNumber = const Value.absent(),
    this.ayahNumber = const Value.absent(),
    this.collectionId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BookmarksCompanion.insert({
    this.id = const Value.absent(),
    required int surahNumber,
    required int ayahNumber,
    this.collectionId = const Value.absent(),
    required DateTime createdAt,
  }) : surahNumber = Value(surahNumber),
       ayahNumber = Value(ayahNumber),
       createdAt = Value(createdAt);
  static Insertable<Bookmark> custom({
    Expression<int>? id,
    Expression<int>? surahNumber,
    Expression<int>? ayahNumber,
    Expression<String>? collectionId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surahNumber != null) 'surah_number': surahNumber,
      if (ayahNumber != null) 'ayah_number': ayahNumber,
      if (collectionId != null) 'collection_id': collectionId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BookmarksCompanion copyWith({
    Value<int>? id,
    Value<int>? surahNumber,
    Value<int>? ayahNumber,
    Value<String?>? collectionId,
    Value<DateTime>? createdAt,
  }) {
    return BookmarksCompanion(
      id: id ?? this.id,
      surahNumber: surahNumber ?? this.surahNumber,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      collectionId: collectionId ?? this.collectionId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (surahNumber.present) {
      map['surah_number'] = Variable<int>(surahNumber.value);
    }
    if (ayahNumber.present) {
      map['ayah_number'] = Variable<int>(ayahNumber.value);
    }
    if (collectionId.present) {
      map['collection_id'] = Variable<String>(collectionId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookmarksCompanion(')
          ..write('id: $id, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('collectionId: $collectionId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $NotesTable extends Notes with TableInfo<$NotesTable, UserNote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _noteIdMeta = const VerificationMeta('noteId');
  @override
  late final GeneratedColumn<String> noteId = GeneratedColumn<String>(
    'note_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _surahNumberMeta = const VerificationMeta(
    'surahNumber',
  );
  @override
  late final GeneratedColumn<int> surahNumber = GeneratedColumn<int>(
    'surah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startAyahMeta = const VerificationMeta(
    'startAyah',
  );
  @override
  late final GeneratedColumn<int> startAyah = GeneratedColumn<int>(
    'start_ayah',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endAyahMeta = const VerificationMeta(
    'endAyah',
  );
  @override
  late final GeneratedColumn<int> endAyah = GeneratedColumn<int>(
    'end_ayah',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _textContentMeta = const VerificationMeta(
    'textContent',
  );
  @override
  late final GeneratedColumn<String> textContent = GeneratedColumn<String>(
    'text_content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    noteId,
    surahNumber,
    startAyah,
    endAyah,
    textContent,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserNote> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('note_id')) {
      context.handle(
        _noteIdMeta,
        noteId.isAcceptableOrUnknown(data['note_id']!, _noteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_noteIdMeta);
    }
    if (data.containsKey('surah_number')) {
      context.handle(
        _surahNumberMeta,
        surahNumber.isAcceptableOrUnknown(
          data['surah_number']!,
          _surahNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_surahNumberMeta);
    }
    if (data.containsKey('start_ayah')) {
      context.handle(
        _startAyahMeta,
        startAyah.isAcceptableOrUnknown(data['start_ayah']!, _startAyahMeta),
      );
    } else if (isInserting) {
      context.missing(_startAyahMeta);
    }
    if (data.containsKey('end_ayah')) {
      context.handle(
        _endAyahMeta,
        endAyah.isAcceptableOrUnknown(data['end_ayah']!, _endAyahMeta),
      );
    } else if (isInserting) {
      context.missing(_endAyahMeta);
    }
    if (data.containsKey('text_content')) {
      context.handle(
        _textContentMeta,
        textContent.isAcceptableOrUnknown(
          data['text_content']!,
          _textContentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_textContentMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {noteId};
  @override
  UserNote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserNote(
      noteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note_id'],
      )!,
      surahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}surah_number'],
      )!,
      startAyah: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_ayah'],
      )!,
      endAyah: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_ayah'],
      )!,
      textContent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_content'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(attachedDatabase, alias);
  }
}

class UserNote extends DataClass implements Insertable<UserNote> {
  final String noteId;
  final int surahNumber;
  final int startAyah;
  final int endAyah;
  final String textContent;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserNote({
    required this.noteId,
    required this.surahNumber,
    required this.startAyah,
    required this.endAyah,
    required this.textContent,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['note_id'] = Variable<String>(noteId);
    map['surah_number'] = Variable<int>(surahNumber);
    map['start_ayah'] = Variable<int>(startAyah);
    map['end_ayah'] = Variable<int>(endAyah);
    map['text_content'] = Variable<String>(textContent);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  NotesCompanion toCompanion(bool nullToAbsent) {
    return NotesCompanion(
      noteId: Value(noteId),
      surahNumber: Value(surahNumber),
      startAyah: Value(startAyah),
      endAyah: Value(endAyah),
      textContent: Value(textContent),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserNote.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserNote(
      noteId: serializer.fromJson<String>(json['noteId']),
      surahNumber: serializer.fromJson<int>(json['surahNumber']),
      startAyah: serializer.fromJson<int>(json['startAyah']),
      endAyah: serializer.fromJson<int>(json['endAyah']),
      textContent: serializer.fromJson<String>(json['textContent']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'noteId': serializer.toJson<String>(noteId),
      'surahNumber': serializer.toJson<int>(surahNumber),
      'startAyah': serializer.toJson<int>(startAyah),
      'endAyah': serializer.toJson<int>(endAyah),
      'textContent': serializer.toJson<String>(textContent),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserNote copyWith({
    String? noteId,
    int? surahNumber,
    int? startAyah,
    int? endAyah,
    String? textContent,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UserNote(
    noteId: noteId ?? this.noteId,
    surahNumber: surahNumber ?? this.surahNumber,
    startAyah: startAyah ?? this.startAyah,
    endAyah: endAyah ?? this.endAyah,
    textContent: textContent ?? this.textContent,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserNote copyWithCompanion(NotesCompanion data) {
    return UserNote(
      noteId: data.noteId.present ? data.noteId.value : this.noteId,
      surahNumber: data.surahNumber.present
          ? data.surahNumber.value
          : this.surahNumber,
      startAyah: data.startAyah.present ? data.startAyah.value : this.startAyah,
      endAyah: data.endAyah.present ? data.endAyah.value : this.endAyah,
      textContent: data.textContent.present
          ? data.textContent.value
          : this.textContent,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserNote(')
          ..write('noteId: $noteId, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('startAyah: $startAyah, ')
          ..write('endAyah: $endAyah, ')
          ..write('textContent: $textContent, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    noteId,
    surahNumber,
    startAyah,
    endAyah,
    textContent,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserNote &&
          other.noteId == this.noteId &&
          other.surahNumber == this.surahNumber &&
          other.startAyah == this.startAyah &&
          other.endAyah == this.endAyah &&
          other.textContent == this.textContent &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class NotesCompanion extends UpdateCompanion<UserNote> {
  final Value<String> noteId;
  final Value<int> surahNumber;
  final Value<int> startAyah;
  final Value<int> endAyah;
  final Value<String> textContent;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const NotesCompanion({
    this.noteId = const Value.absent(),
    this.surahNumber = const Value.absent(),
    this.startAyah = const Value.absent(),
    this.endAyah = const Value.absent(),
    this.textContent = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotesCompanion.insert({
    required String noteId,
    required int surahNumber,
    required int startAyah,
    required int endAyah,
    required String textContent,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : noteId = Value(noteId),
       surahNumber = Value(surahNumber),
       startAyah = Value(startAyah),
       endAyah = Value(endAyah),
       textContent = Value(textContent),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<UserNote> custom({
    Expression<String>? noteId,
    Expression<int>? surahNumber,
    Expression<int>? startAyah,
    Expression<int>? endAyah,
    Expression<String>? textContent,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (noteId != null) 'note_id': noteId,
      if (surahNumber != null) 'surah_number': surahNumber,
      if (startAyah != null) 'start_ayah': startAyah,
      if (endAyah != null) 'end_ayah': endAyah,
      if (textContent != null) 'text_content': textContent,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotesCompanion copyWith({
    Value<String>? noteId,
    Value<int>? surahNumber,
    Value<int>? startAyah,
    Value<int>? endAyah,
    Value<String>? textContent,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return NotesCompanion(
      noteId: noteId ?? this.noteId,
      surahNumber: surahNumber ?? this.surahNumber,
      startAyah: startAyah ?? this.startAyah,
      endAyah: endAyah ?? this.endAyah,
      textContent: textContent ?? this.textContent,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (noteId.present) {
      map['note_id'] = Variable<String>(noteId.value);
    }
    if (surahNumber.present) {
      map['surah_number'] = Variable<int>(surahNumber.value);
    }
    if (startAyah.present) {
      map['start_ayah'] = Variable<int>(startAyah.value);
    }
    if (endAyah.present) {
      map['end_ayah'] = Variable<int>(endAyah.value);
    }
    if (textContent.present) {
      map['text_content'] = Variable<String>(textContent.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesCompanion(')
          ..write('noteId: $noteId, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('startAyah: $startAyah, ')
          ..write('endAyah: $endAyah, ')
          ..write('textContent: $textContent, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, WorkspaceTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<String> tagId = GeneratedColumn<String>(
    'tag_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorHexMeta = const VerificationMeta(
    'colorHex',
  );
  @override
  late final GeneratedColumn<String> colorHex = GeneratedColumn<String>(
    'color_hex',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('#009688'),
  );
  @override
  List<GeneratedColumn> get $columns => [tagId, name, colorHex];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkspaceTag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('tag_id')) {
      context.handle(
        _tagIdMeta,
        tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color_hex')) {
      context.handle(
        _colorHexMeta,
        colorHex.isAcceptableOrUnknown(data['color_hex']!, _colorHexMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {tagId};
  @override
  WorkspaceTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkspaceTag(
      tagId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tag_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      colorHex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color_hex'],
      )!,
    );
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(attachedDatabase, alias);
  }
}

class WorkspaceTag extends DataClass implements Insertable<WorkspaceTag> {
  final String tagId;
  final String name;
  final String colorHex;
  const WorkspaceTag({
    required this.tagId,
    required this.name,
    required this.colorHex,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['tag_id'] = Variable<String>(tagId);
    map['name'] = Variable<String>(name);
    map['color_hex'] = Variable<String>(colorHex);
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      tagId: Value(tagId),
      name: Value(name),
      colorHex: Value(colorHex),
    );
  }

  factory WorkspaceTag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkspaceTag(
      tagId: serializer.fromJson<String>(json['tagId']),
      name: serializer.fromJson<String>(json['name']),
      colorHex: serializer.fromJson<String>(json['colorHex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'tagId': serializer.toJson<String>(tagId),
      'name': serializer.toJson<String>(name),
      'colorHex': serializer.toJson<String>(colorHex),
    };
  }

  WorkspaceTag copyWith({String? tagId, String? name, String? colorHex}) =>
      WorkspaceTag(
        tagId: tagId ?? this.tagId,
        name: name ?? this.name,
        colorHex: colorHex ?? this.colorHex,
      );
  WorkspaceTag copyWithCompanion(TagsCompanion data) {
    return WorkspaceTag(
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
      name: data.name.present ? data.name.value : this.name,
      colorHex: data.colorHex.present ? data.colorHex.value : this.colorHex,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkspaceTag(')
          ..write('tagId: $tagId, ')
          ..write('name: $name, ')
          ..write('colorHex: $colorHex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(tagId, name, colorHex);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkspaceTag &&
          other.tagId == this.tagId &&
          other.name == this.name &&
          other.colorHex == this.colorHex);
}

class TagsCompanion extends UpdateCompanion<WorkspaceTag> {
  final Value<String> tagId;
  final Value<String> name;
  final Value<String> colorHex;
  final Value<int> rowid;
  const TagsCompanion({
    this.tagId = const Value.absent(),
    this.name = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TagsCompanion.insert({
    required String tagId,
    required String name,
    this.colorHex = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : tagId = Value(tagId),
       name = Value(name);
  static Insertable<WorkspaceTag> custom({
    Expression<String>? tagId,
    Expression<String>? name,
    Expression<String>? colorHex,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (tagId != null) 'tag_id': tagId,
      if (name != null) 'name': name,
      if (colorHex != null) 'color_hex': colorHex,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TagsCompanion copyWith({
    Value<String>? tagId,
    Value<String>? name,
    Value<String>? colorHex,
    Value<int>? rowid,
  }) {
    return TagsCompanion(
      tagId: tagId ?? this.tagId,
      name: name ?? this.name,
      colorHex: colorHex ?? this.colorHex,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (tagId.present) {
      map['tag_id'] = Variable<String>(tagId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (colorHex.present) {
      map['color_hex'] = Variable<String>(colorHex.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('tagId: $tagId, ')
          ..write('name: $name, ')
          ..write('colorHex: $colorHex, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ItemTagsTable extends ItemTags with TableInfo<$ItemTagsTable, ItemTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _itemTypeMeta = const VerificationMeta(
    'itemType',
  );
  @override
  late final GeneratedColumn<String> itemType = GeneratedColumn<String>(
    'item_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<String> tagId = GeneratedColumn<String>(
    'tag_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'REFERENCES tags(tag_id) NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [itemType, itemId, tagId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'item_tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<ItemTag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('item_type')) {
      context.handle(
        _itemTypeMeta,
        itemType.isAcceptableOrUnknown(data['item_type']!, _itemTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_itemTypeMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
        _tagIdMeta,
        tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {itemType, itemId, tagId};
  @override
  ItemTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ItemTag(
      itemType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_type'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      )!,
      tagId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tag_id'],
      )!,
    );
  }

  @override
  $ItemTagsTable createAlias(String alias) {
    return $ItemTagsTable(attachedDatabase, alias);
  }
}

class ItemTag extends DataClass implements Insertable<ItemTag> {
  final String itemType;
  final String itemId;
  final String tagId;
  const ItemTag({
    required this.itemType,
    required this.itemId,
    required this.tagId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['item_type'] = Variable<String>(itemType);
    map['item_id'] = Variable<String>(itemId);
    map['tag_id'] = Variable<String>(tagId);
    return map;
  }

  ItemTagsCompanion toCompanion(bool nullToAbsent) {
    return ItemTagsCompanion(
      itemType: Value(itemType),
      itemId: Value(itemId),
      tagId: Value(tagId),
    );
  }

  factory ItemTag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItemTag(
      itemType: serializer.fromJson<String>(json['itemType']),
      itemId: serializer.fromJson<String>(json['itemId']),
      tagId: serializer.fromJson<String>(json['tagId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'itemType': serializer.toJson<String>(itemType),
      'itemId': serializer.toJson<String>(itemId),
      'tagId': serializer.toJson<String>(tagId),
    };
  }

  ItemTag copyWith({String? itemType, String? itemId, String? tagId}) =>
      ItemTag(
        itemType: itemType ?? this.itemType,
        itemId: itemId ?? this.itemId,
        tagId: tagId ?? this.tagId,
      );
  ItemTag copyWithCompanion(ItemTagsCompanion data) {
    return ItemTag(
      itemType: data.itemType.present ? data.itemType.value : this.itemType,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ItemTag(')
          ..write('itemType: $itemType, ')
          ..write('itemId: $itemId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(itemType, itemId, tagId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemTag &&
          other.itemType == this.itemType &&
          other.itemId == this.itemId &&
          other.tagId == this.tagId);
}

class ItemTagsCompanion extends UpdateCompanion<ItemTag> {
  final Value<String> itemType;
  final Value<String> itemId;
  final Value<String> tagId;
  final Value<int> rowid;
  const ItemTagsCompanion({
    this.itemType = const Value.absent(),
    this.itemId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ItemTagsCompanion.insert({
    required String itemType,
    required String itemId,
    required String tagId,
    this.rowid = const Value.absent(),
  }) : itemType = Value(itemType),
       itemId = Value(itemId),
       tagId = Value(tagId);
  static Insertable<ItemTag> custom({
    Expression<String>? itemType,
    Expression<String>? itemId,
    Expression<String>? tagId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (itemType != null) 'item_type': itemType,
      if (itemId != null) 'item_id': itemId,
      if (tagId != null) 'tag_id': tagId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ItemTagsCompanion copyWith({
    Value<String>? itemType,
    Value<String>? itemId,
    Value<String>? tagId,
    Value<int>? rowid,
  }) {
    return ItemTagsCompanion(
      itemType: itemType ?? this.itemType,
      itemId: itemId ?? this.itemId,
      tagId: tagId ?? this.tagId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (itemType.present) {
      map['item_type'] = Variable<String>(itemType.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<String>(tagId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemTagsCompanion(')
          ..write('itemType: $itemType, ')
          ..write('itemId: $itemId, ')
          ..write('tagId: $tagId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AiHistoryTable extends AiHistory
    with TableInfo<$AiHistoryTable, AiHistoryEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AiHistoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _sessionTypeMeta = const VerificationMeta(
    'sessionType',
  );
  @override
  late final GeneratedColumn<String> sessionType = GeneratedColumn<String>(
    'session_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contextLabelMeta = const VerificationMeta(
    'contextLabel',
  );
  @override
  late final GeneratedColumn<String> contextLabel = GeneratedColumn<String>(
    'context_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _promptSentMeta = const VerificationMeta(
    'promptSent',
  );
  @override
  late final GeneratedColumn<String> promptSent = GeneratedColumn<String>(
    'prompt_sent',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _responseReceivedMeta = const VerificationMeta(
    'responseReceived',
  );
  @override
  late final GeneratedColumn<String> responseReceived = GeneratedColumn<String>(
    'response_received',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionType,
    contextLabel,
    promptSent,
    responseReceived,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ai_history';
  @override
  VerificationContext validateIntegrity(
    Insertable<AiHistoryEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_type')) {
      context.handle(
        _sessionTypeMeta,
        sessionType.isAcceptableOrUnknown(
          data['session_type']!,
          _sessionTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sessionTypeMeta);
    }
    if (data.containsKey('context_label')) {
      context.handle(
        _contextLabelMeta,
        contextLabel.isAcceptableOrUnknown(
          data['context_label']!,
          _contextLabelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contextLabelMeta);
    }
    if (data.containsKey('prompt_sent')) {
      context.handle(
        _promptSentMeta,
        promptSent.isAcceptableOrUnknown(data['prompt_sent']!, _promptSentMeta),
      );
    } else if (isInserting) {
      context.missing(_promptSentMeta);
    }
    if (data.containsKey('response_received')) {
      context.handle(
        _responseReceivedMeta,
        responseReceived.isAcceptableOrUnknown(
          data['response_received']!,
          _responseReceivedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_responseReceivedMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AiHistoryEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AiHistoryEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sessionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_type'],
      )!,
      contextLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}context_label'],
      )!,
      promptSent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prompt_sent'],
      )!,
      responseReceived: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}response_received'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AiHistoryTable createAlias(String alias) {
    return $AiHistoryTable(attachedDatabase, alias);
  }
}

class AiHistoryEntry extends DataClass implements Insertable<AiHistoryEntry> {
  final int id;
  final String sessionType;
  final String contextLabel;
  final String promptSent;
  final String responseReceived;
  final DateTime createdAt;
  const AiHistoryEntry({
    required this.id,
    required this.sessionType,
    required this.contextLabel,
    required this.promptSent,
    required this.responseReceived,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_type'] = Variable<String>(sessionType);
    map['context_label'] = Variable<String>(contextLabel);
    map['prompt_sent'] = Variable<String>(promptSent);
    map['response_received'] = Variable<String>(responseReceived);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AiHistoryCompanion toCompanion(bool nullToAbsent) {
    return AiHistoryCompanion(
      id: Value(id),
      sessionType: Value(sessionType),
      contextLabel: Value(contextLabel),
      promptSent: Value(promptSent),
      responseReceived: Value(responseReceived),
      createdAt: Value(createdAt),
    );
  }

  factory AiHistoryEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AiHistoryEntry(
      id: serializer.fromJson<int>(json['id']),
      sessionType: serializer.fromJson<String>(json['sessionType']),
      contextLabel: serializer.fromJson<String>(json['contextLabel']),
      promptSent: serializer.fromJson<String>(json['promptSent']),
      responseReceived: serializer.fromJson<String>(json['responseReceived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionType': serializer.toJson<String>(sessionType),
      'contextLabel': serializer.toJson<String>(contextLabel),
      'promptSent': serializer.toJson<String>(promptSent),
      'responseReceived': serializer.toJson<String>(responseReceived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AiHistoryEntry copyWith({
    int? id,
    String? sessionType,
    String? contextLabel,
    String? promptSent,
    String? responseReceived,
    DateTime? createdAt,
  }) => AiHistoryEntry(
    id: id ?? this.id,
    sessionType: sessionType ?? this.sessionType,
    contextLabel: contextLabel ?? this.contextLabel,
    promptSent: promptSent ?? this.promptSent,
    responseReceived: responseReceived ?? this.responseReceived,
    createdAt: createdAt ?? this.createdAt,
  );
  AiHistoryEntry copyWithCompanion(AiHistoryCompanion data) {
    return AiHistoryEntry(
      id: data.id.present ? data.id.value : this.id,
      sessionType: data.sessionType.present
          ? data.sessionType.value
          : this.sessionType,
      contextLabel: data.contextLabel.present
          ? data.contextLabel.value
          : this.contextLabel,
      promptSent: data.promptSent.present
          ? data.promptSent.value
          : this.promptSent,
      responseReceived: data.responseReceived.present
          ? data.responseReceived.value
          : this.responseReceived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AiHistoryEntry(')
          ..write('id: $id, ')
          ..write('sessionType: $sessionType, ')
          ..write('contextLabel: $contextLabel, ')
          ..write('promptSent: $promptSent, ')
          ..write('responseReceived: $responseReceived, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionType,
    contextLabel,
    promptSent,
    responseReceived,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AiHistoryEntry &&
          other.id == this.id &&
          other.sessionType == this.sessionType &&
          other.contextLabel == this.contextLabel &&
          other.promptSent == this.promptSent &&
          other.responseReceived == this.responseReceived &&
          other.createdAt == this.createdAt);
}

class AiHistoryCompanion extends UpdateCompanion<AiHistoryEntry> {
  final Value<int> id;
  final Value<String> sessionType;
  final Value<String> contextLabel;
  final Value<String> promptSent;
  final Value<String> responseReceived;
  final Value<DateTime> createdAt;
  const AiHistoryCompanion({
    this.id = const Value.absent(),
    this.sessionType = const Value.absent(),
    this.contextLabel = const Value.absent(),
    this.promptSent = const Value.absent(),
    this.responseReceived = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AiHistoryCompanion.insert({
    this.id = const Value.absent(),
    required String sessionType,
    required String contextLabel,
    required String promptSent,
    required String responseReceived,
    required DateTime createdAt,
  }) : sessionType = Value(sessionType),
       contextLabel = Value(contextLabel),
       promptSent = Value(promptSent),
       responseReceived = Value(responseReceived),
       createdAt = Value(createdAt);
  static Insertable<AiHistoryEntry> custom({
    Expression<int>? id,
    Expression<String>? sessionType,
    Expression<String>? contextLabel,
    Expression<String>? promptSent,
    Expression<String>? responseReceived,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionType != null) 'session_type': sessionType,
      if (contextLabel != null) 'context_label': contextLabel,
      if (promptSent != null) 'prompt_sent': promptSent,
      if (responseReceived != null) 'response_received': responseReceived,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AiHistoryCompanion copyWith({
    Value<int>? id,
    Value<String>? sessionType,
    Value<String>? contextLabel,
    Value<String>? promptSent,
    Value<String>? responseReceived,
    Value<DateTime>? createdAt,
  }) {
    return AiHistoryCompanion(
      id: id ?? this.id,
      sessionType: sessionType ?? this.sessionType,
      contextLabel: contextLabel ?? this.contextLabel,
      promptSent: promptSent ?? this.promptSent,
      responseReceived: responseReceived ?? this.responseReceived,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionType.present) {
      map['session_type'] = Variable<String>(sessionType.value);
    }
    if (contextLabel.present) {
      map['context_label'] = Variable<String>(contextLabel.value);
    }
    if (promptSent.present) {
      map['prompt_sent'] = Variable<String>(promptSent.value);
    }
    if (responseReceived.present) {
      map['response_received'] = Variable<String>(responseReceived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AiHistoryCompanion(')
          ..write('id: $id, ')
          ..write('sessionType: $sessionType, ')
          ..write('contextLabel: $contextLabel, ')
          ..write('promptSent: $promptSent, ')
          ..write('responseReceived: $responseReceived, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SurahsTable surahs = $SurahsTable(this);
  late final $AyahsTable ayahs = $AyahsTable(this);
  late final $TranslationsMetaTable translationsMeta = $TranslationsMetaTable(
    this,
  );
  late final $AyahTranslationsTable ayahTranslations = $AyahTranslationsTable(
    this,
  );
  late final $RootsTable roots = $RootsTable(this);
  late final $WordsTable words = $WordsTable(this);
  late final $ContentPacksTable contentPacks = $ContentPacksTable(this);
  late final $TafsirsMetaTable tafsirsMeta = $TafsirsMetaTable(this);
  late final $TafsirContentTable tafsirContent = $TafsirContentTable(this);
  late final $TopicsTable topics = $TopicsTable(this);
  late final $TopicAyahsTable topicAyahs = $TopicAyahsTable(this);
  late final $CrossReferencesTable crossReferences = $CrossReferencesTable(
    this,
  );
  late final $AsbabAlNuzulTable asbabAlNuzul = $AsbabAlNuzulTable(this);
  late final $CollectionsTable collections = $CollectionsTable(this);
  late final $BookmarksTable bookmarks = $BookmarksTable(this);
  late final $NotesTable notes = $NotesTable(this);
  late final $TagsTable tags = $TagsTable(this);
  late final $ItemTagsTable itemTags = $ItemTagsTable(this);
  late final $AiHistoryTable aiHistory = $AiHistoryTable(this);
  late final QuranDao quranDao = QuranDao(this as AppDatabase);
  late final SearchDao searchDao = SearchDao(this as AppDatabase);
  late final ContentPackDao contentPackDao = ContentPackDao(
    this as AppDatabase,
  );
  late final TafsirDao tafsirDao = TafsirDao(this as AppDatabase);
  late final ThematicDao thematicDao = ThematicDao(this as AppDatabase);
  late final WorkspaceDao workspaceDao = WorkspaceDao(this as AppDatabase);
  late final AiHistoryDao aiHistoryDao = AiHistoryDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    surahs,
    ayahs,
    translationsMeta,
    ayahTranslations,
    roots,
    words,
    contentPacks,
    tafsirsMeta,
    tafsirContent,
    topics,
    topicAyahs,
    crossReferences,
    asbabAlNuzul,
    collections,
    bookmarks,
    notes,
    tags,
    itemTags,
    aiHistory,
  ];
}

typedef $$SurahsTableCreateCompanionBuilder =
    SurahsCompanion Function({
      Value<int> number,
      required String nameArabic,
      required String nameTranslit,
      required String nameTranslation,
      required String revelationPlace,
      required int ayahCount,
    });
typedef $$SurahsTableUpdateCompanionBuilder =
    SurahsCompanion Function({
      Value<int> number,
      Value<String> nameArabic,
      Value<String> nameTranslit,
      Value<String> nameTranslation,
      Value<String> revelationPlace,
      Value<int> ayahCount,
    });

class $$SurahsTableFilterComposer
    extends Composer<_$AppDatabase, $SurahsTable> {
  $$SurahsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameArabic => $composableBuilder(
    column: $table.nameArabic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameTranslit => $composableBuilder(
    column: $table.nameTranslit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameTranslation => $composableBuilder(
    column: $table.nameTranslation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get revelationPlace => $composableBuilder(
    column: $table.revelationPlace,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ayahCount => $composableBuilder(
    column: $table.ayahCount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SurahsTableOrderingComposer
    extends Composer<_$AppDatabase, $SurahsTable> {
  $$SurahsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameArabic => $composableBuilder(
    column: $table.nameArabic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameTranslit => $composableBuilder(
    column: $table.nameTranslit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameTranslation => $composableBuilder(
    column: $table.nameTranslation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get revelationPlace => $composableBuilder(
    column: $table.revelationPlace,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ayahCount => $composableBuilder(
    column: $table.ayahCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SurahsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SurahsTable> {
  $$SurahsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<String> get nameArabic => $composableBuilder(
    column: $table.nameArabic,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nameTranslit => $composableBuilder(
    column: $table.nameTranslit,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nameTranslation => $composableBuilder(
    column: $table.nameTranslation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get revelationPlace => $composableBuilder(
    column: $table.revelationPlace,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ayahCount =>
      $composableBuilder(column: $table.ayahCount, builder: (column) => column);
}

class $$SurahsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SurahsTable,
          Surah,
          $$SurahsTableFilterComposer,
          $$SurahsTableOrderingComposer,
          $$SurahsTableAnnotationComposer,
          $$SurahsTableCreateCompanionBuilder,
          $$SurahsTableUpdateCompanionBuilder,
          (Surah, BaseReferences<_$AppDatabase, $SurahsTable, Surah>),
          Surah,
          PrefetchHooks Function()
        > {
  $$SurahsTableTableManager(_$AppDatabase db, $SurahsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SurahsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SurahsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SurahsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> number = const Value.absent(),
                Value<String> nameArabic = const Value.absent(),
                Value<String> nameTranslit = const Value.absent(),
                Value<String> nameTranslation = const Value.absent(),
                Value<String> revelationPlace = const Value.absent(),
                Value<int> ayahCount = const Value.absent(),
              }) => SurahsCompanion(
                number: number,
                nameArabic: nameArabic,
                nameTranslit: nameTranslit,
                nameTranslation: nameTranslation,
                revelationPlace: revelationPlace,
                ayahCount: ayahCount,
              ),
          createCompanionCallback:
              ({
                Value<int> number = const Value.absent(),
                required String nameArabic,
                required String nameTranslit,
                required String nameTranslation,
                required String revelationPlace,
                required int ayahCount,
              }) => SurahsCompanion.insert(
                number: number,
                nameArabic: nameArabic,
                nameTranslit: nameTranslit,
                nameTranslation: nameTranslation,
                revelationPlace: revelationPlace,
                ayahCount: ayahCount,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SurahsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SurahsTable,
      Surah,
      $$SurahsTableFilterComposer,
      $$SurahsTableOrderingComposer,
      $$SurahsTableAnnotationComposer,
      $$SurahsTableCreateCompanionBuilder,
      $$SurahsTableUpdateCompanionBuilder,
      (Surah, BaseReferences<_$AppDatabase, $SurahsTable, Surah>),
      Surah,
      PrefetchHooks Function()
    >;
typedef $$AyahsTableCreateCompanionBuilder =
    AyahsCompanion Function({
      Value<int> globalAyahIndex,
      required int surahNumber,
      required int ayahNumber,
      required String arabicTextUthmani,
      required int juz,
      required int page,
    });
typedef $$AyahsTableUpdateCompanionBuilder =
    AyahsCompanion Function({
      Value<int> globalAyahIndex,
      Value<int> surahNumber,
      Value<int> ayahNumber,
      Value<String> arabicTextUthmani,
      Value<int> juz,
      Value<int> page,
    });

class $$AyahsTableFilterComposer extends Composer<_$AppDatabase, $AyahsTable> {
  $$AyahsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get globalAyahIndex => $composableBuilder(
    column: $table.globalAyahIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get arabicTextUthmani => $composableBuilder(
    column: $table.arabicTextUthmani,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get juz => $composableBuilder(
    column: $table.juz,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get page => $composableBuilder(
    column: $table.page,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AyahsTableOrderingComposer
    extends Composer<_$AppDatabase, $AyahsTable> {
  $$AyahsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get globalAyahIndex => $composableBuilder(
    column: $table.globalAyahIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get arabicTextUthmani => $composableBuilder(
    column: $table.arabicTextUthmani,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get juz => $composableBuilder(
    column: $table.juz,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get page => $composableBuilder(
    column: $table.page,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AyahsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AyahsTable> {
  $$AyahsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get globalAyahIndex => $composableBuilder(
    column: $table.globalAyahIndex,
    builder: (column) => column,
  );

  GeneratedColumn<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get arabicTextUthmani => $composableBuilder(
    column: $table.arabicTextUthmani,
    builder: (column) => column,
  );

  GeneratedColumn<int> get juz =>
      $composableBuilder(column: $table.juz, builder: (column) => column);

  GeneratedColumn<int> get page =>
      $composableBuilder(column: $table.page, builder: (column) => column);
}

class $$AyahsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AyahsTable,
          Ayah,
          $$AyahsTableFilterComposer,
          $$AyahsTableOrderingComposer,
          $$AyahsTableAnnotationComposer,
          $$AyahsTableCreateCompanionBuilder,
          $$AyahsTableUpdateCompanionBuilder,
          (Ayah, BaseReferences<_$AppDatabase, $AyahsTable, Ayah>),
          Ayah,
          PrefetchHooks Function()
        > {
  $$AyahsTableTableManager(_$AppDatabase db, $AyahsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AyahsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AyahsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AyahsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> globalAyahIndex = const Value.absent(),
                Value<int> surahNumber = const Value.absent(),
                Value<int> ayahNumber = const Value.absent(),
                Value<String> arabicTextUthmani = const Value.absent(),
                Value<int> juz = const Value.absent(),
                Value<int> page = const Value.absent(),
              }) => AyahsCompanion(
                globalAyahIndex: globalAyahIndex,
                surahNumber: surahNumber,
                ayahNumber: ayahNumber,
                arabicTextUthmani: arabicTextUthmani,
                juz: juz,
                page: page,
              ),
          createCompanionCallback:
              ({
                Value<int> globalAyahIndex = const Value.absent(),
                required int surahNumber,
                required int ayahNumber,
                required String arabicTextUthmani,
                required int juz,
                required int page,
              }) => AyahsCompanion.insert(
                globalAyahIndex: globalAyahIndex,
                surahNumber: surahNumber,
                ayahNumber: ayahNumber,
                arabicTextUthmani: arabicTextUthmani,
                juz: juz,
                page: page,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AyahsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AyahsTable,
      Ayah,
      $$AyahsTableFilterComposer,
      $$AyahsTableOrderingComposer,
      $$AyahsTableAnnotationComposer,
      $$AyahsTableCreateCompanionBuilder,
      $$AyahsTableUpdateCompanionBuilder,
      (Ayah, BaseReferences<_$AppDatabase, $AyahsTable, Ayah>),
      Ayah,
      PrefetchHooks Function()
    >;
typedef $$TranslationsMetaTableCreateCompanionBuilder =
    TranslationsMetaCompanion Function({
      required String translationId,
      required String language,
      required String translatorName,
      required String source,
      required String licenseNote,
      Value<int> rowid,
    });
typedef $$TranslationsMetaTableUpdateCompanionBuilder =
    TranslationsMetaCompanion Function({
      Value<String> translationId,
      Value<String> language,
      Value<String> translatorName,
      Value<String> source,
      Value<String> licenseNote,
      Value<int> rowid,
    });

class $$TranslationsMetaTableFilterComposer
    extends Composer<_$AppDatabase, $TranslationsMetaTable> {
  $$TranslationsMetaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get translationId => $composableBuilder(
    column: $table.translationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get translatorName => $composableBuilder(
    column: $table.translatorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get licenseNote => $composableBuilder(
    column: $table.licenseNote,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TranslationsMetaTableOrderingComposer
    extends Composer<_$AppDatabase, $TranslationsMetaTable> {
  $$TranslationsMetaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get translationId => $composableBuilder(
    column: $table.translationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get translatorName => $composableBuilder(
    column: $table.translatorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get licenseNote => $composableBuilder(
    column: $table.licenseNote,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TranslationsMetaTableAnnotationComposer
    extends Composer<_$AppDatabase, $TranslationsMetaTable> {
  $$TranslationsMetaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get translationId => $composableBuilder(
    column: $table.translationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<String> get translatorName => $composableBuilder(
    column: $table.translatorName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get licenseNote => $composableBuilder(
    column: $table.licenseNote,
    builder: (column) => column,
  );
}

class $$TranslationsMetaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TranslationsMetaTable,
          TranslationMeta,
          $$TranslationsMetaTableFilterComposer,
          $$TranslationsMetaTableOrderingComposer,
          $$TranslationsMetaTableAnnotationComposer,
          $$TranslationsMetaTableCreateCompanionBuilder,
          $$TranslationsMetaTableUpdateCompanionBuilder,
          (
            TranslationMeta,
            BaseReferences<
              _$AppDatabase,
              $TranslationsMetaTable,
              TranslationMeta
            >,
          ),
          TranslationMeta,
          PrefetchHooks Function()
        > {
  $$TranslationsMetaTableTableManager(
    _$AppDatabase db,
    $TranslationsMetaTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TranslationsMetaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TranslationsMetaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TranslationsMetaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> translationId = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<String> translatorName = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String> licenseNote = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TranslationsMetaCompanion(
                translationId: translationId,
                language: language,
                translatorName: translatorName,
                source: source,
                licenseNote: licenseNote,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String translationId,
                required String language,
                required String translatorName,
                required String source,
                required String licenseNote,
                Value<int> rowid = const Value.absent(),
              }) => TranslationsMetaCompanion.insert(
                translationId: translationId,
                language: language,
                translatorName: translatorName,
                source: source,
                licenseNote: licenseNote,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TranslationsMetaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TranslationsMetaTable,
      TranslationMeta,
      $$TranslationsMetaTableFilterComposer,
      $$TranslationsMetaTableOrderingComposer,
      $$TranslationsMetaTableAnnotationComposer,
      $$TranslationsMetaTableCreateCompanionBuilder,
      $$TranslationsMetaTableUpdateCompanionBuilder,
      (
        TranslationMeta,
        BaseReferences<_$AppDatabase, $TranslationsMetaTable, TranslationMeta>,
      ),
      TranslationMeta,
      PrefetchHooks Function()
    >;
typedef $$AyahTranslationsTableCreateCompanionBuilder =
    AyahTranslationsCompanion Function({
      required String translationId,
      required int surahNumber,
      required int ayahNumber,
      required String textContent,
      Value<int> rowid,
    });
typedef $$AyahTranslationsTableUpdateCompanionBuilder =
    AyahTranslationsCompanion Function({
      Value<String> translationId,
      Value<int> surahNumber,
      Value<int> ayahNumber,
      Value<String> textContent,
      Value<int> rowid,
    });

class $$AyahTranslationsTableFilterComposer
    extends Composer<_$AppDatabase, $AyahTranslationsTable> {
  $$AyahTranslationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get translationId => $composableBuilder(
    column: $table.translationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AyahTranslationsTableOrderingComposer
    extends Composer<_$AppDatabase, $AyahTranslationsTable> {
  $$AyahTranslationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get translationId => $composableBuilder(
    column: $table.translationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AyahTranslationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AyahTranslationsTable> {
  $$AyahTranslationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get translationId => $composableBuilder(
    column: $table.translationId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => column,
  );
}

class $$AyahTranslationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AyahTranslationsTable,
          AyahTranslation,
          $$AyahTranslationsTableFilterComposer,
          $$AyahTranslationsTableOrderingComposer,
          $$AyahTranslationsTableAnnotationComposer,
          $$AyahTranslationsTableCreateCompanionBuilder,
          $$AyahTranslationsTableUpdateCompanionBuilder,
          (
            AyahTranslation,
            BaseReferences<
              _$AppDatabase,
              $AyahTranslationsTable,
              AyahTranslation
            >,
          ),
          AyahTranslation,
          PrefetchHooks Function()
        > {
  $$AyahTranslationsTableTableManager(
    _$AppDatabase db,
    $AyahTranslationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AyahTranslationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AyahTranslationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AyahTranslationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> translationId = const Value.absent(),
                Value<int> surahNumber = const Value.absent(),
                Value<int> ayahNumber = const Value.absent(),
                Value<String> textContent = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AyahTranslationsCompanion(
                translationId: translationId,
                surahNumber: surahNumber,
                ayahNumber: ayahNumber,
                textContent: textContent,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String translationId,
                required int surahNumber,
                required int ayahNumber,
                required String textContent,
                Value<int> rowid = const Value.absent(),
              }) => AyahTranslationsCompanion.insert(
                translationId: translationId,
                surahNumber: surahNumber,
                ayahNumber: ayahNumber,
                textContent: textContent,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AyahTranslationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AyahTranslationsTable,
      AyahTranslation,
      $$AyahTranslationsTableFilterComposer,
      $$AyahTranslationsTableOrderingComposer,
      $$AyahTranslationsTableAnnotationComposer,
      $$AyahTranslationsTableCreateCompanionBuilder,
      $$AyahTranslationsTableUpdateCompanionBuilder,
      (
        AyahTranslation,
        BaseReferences<_$AppDatabase, $AyahTranslationsTable, AyahTranslation>,
      ),
      AyahTranslation,
      PrefetchHooks Function()
    >;
typedef $$RootsTableCreateCompanionBuilder =
    RootsCompanion Function({
      Value<int> rootId,
      required String rootArabic,
      required String rootTranslit,
      Value<String> meaningsSummary,
      Value<int> occurrenceCount,
    });
typedef $$RootsTableUpdateCompanionBuilder =
    RootsCompanion Function({
      Value<int> rootId,
      Value<String> rootArabic,
      Value<String> rootTranslit,
      Value<String> meaningsSummary,
      Value<int> occurrenceCount,
    });

final class $$RootsTableReferences
    extends BaseReferences<_$AppDatabase, $RootsTable, Root> {
  $$RootsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WordsTable, List<Word>> _wordsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.words,
    aliasName: $_aliasNameGenerator(db.roots.rootId, db.words.rootId),
  );

  $$WordsTableProcessedTableManager get wordsRefs {
    final manager = $$WordsTableTableManager(
      $_db,
      $_db.words,
    ).filter((f) => f.rootId.rootId.sqlEquals($_itemColumn<int>('root_id')!));

    final cache = $_typedResult.readTableOrNull(_wordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RootsTableFilterComposer extends Composer<_$AppDatabase, $RootsTable> {
  $$RootsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get rootId => $composableBuilder(
    column: $table.rootId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rootArabic => $composableBuilder(
    column: $table.rootArabic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rootTranslit => $composableBuilder(
    column: $table.rootTranslit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get meaningsSummary => $composableBuilder(
    column: $table.meaningsSummary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get occurrenceCount => $composableBuilder(
    column: $table.occurrenceCount,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> wordsRefs(
    Expression<bool> Function($$WordsTableFilterComposer f) f,
  ) {
    final $$WordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rootId,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.rootId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableFilterComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RootsTableOrderingComposer
    extends Composer<_$AppDatabase, $RootsTable> {
  $$RootsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get rootId => $composableBuilder(
    column: $table.rootId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rootArabic => $composableBuilder(
    column: $table.rootArabic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rootTranslit => $composableBuilder(
    column: $table.rootTranslit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get meaningsSummary => $composableBuilder(
    column: $table.meaningsSummary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get occurrenceCount => $composableBuilder(
    column: $table.occurrenceCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RootsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RootsTable> {
  $$RootsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get rootId =>
      $composableBuilder(column: $table.rootId, builder: (column) => column);

  GeneratedColumn<String> get rootArabic => $composableBuilder(
    column: $table.rootArabic,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rootTranslit => $composableBuilder(
    column: $table.rootTranslit,
    builder: (column) => column,
  );

  GeneratedColumn<String> get meaningsSummary => $composableBuilder(
    column: $table.meaningsSummary,
    builder: (column) => column,
  );

  GeneratedColumn<int> get occurrenceCount => $composableBuilder(
    column: $table.occurrenceCount,
    builder: (column) => column,
  );

  Expression<T> wordsRefs<T extends Object>(
    Expression<T> Function($$WordsTableAnnotationComposer a) f,
  ) {
    final $$WordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rootId,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.rootId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableAnnotationComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RootsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RootsTable,
          Root,
          $$RootsTableFilterComposer,
          $$RootsTableOrderingComposer,
          $$RootsTableAnnotationComposer,
          $$RootsTableCreateCompanionBuilder,
          $$RootsTableUpdateCompanionBuilder,
          (Root, $$RootsTableReferences),
          Root,
          PrefetchHooks Function({bool wordsRefs})
        > {
  $$RootsTableTableManager(_$AppDatabase db, $RootsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RootsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RootsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RootsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> rootId = const Value.absent(),
                Value<String> rootArabic = const Value.absent(),
                Value<String> rootTranslit = const Value.absent(),
                Value<String> meaningsSummary = const Value.absent(),
                Value<int> occurrenceCount = const Value.absent(),
              }) => RootsCompanion(
                rootId: rootId,
                rootArabic: rootArabic,
                rootTranslit: rootTranslit,
                meaningsSummary: meaningsSummary,
                occurrenceCount: occurrenceCount,
              ),
          createCompanionCallback:
              ({
                Value<int> rootId = const Value.absent(),
                required String rootArabic,
                required String rootTranslit,
                Value<String> meaningsSummary = const Value.absent(),
                Value<int> occurrenceCount = const Value.absent(),
              }) => RootsCompanion.insert(
                rootId: rootId,
                rootArabic: rootArabic,
                rootTranslit: rootTranslit,
                meaningsSummary: meaningsSummary,
                occurrenceCount: occurrenceCount,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$RootsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({wordsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (wordsRefs) db.words],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (wordsRefs)
                    await $_getPrefetchedData<Root, $RootsTable, Word>(
                      currentTable: table,
                      referencedTable: $$RootsTableReferences._wordsRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$RootsTableReferences(db, table, p0).wordsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.rootId == item.rootId),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$RootsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RootsTable,
      Root,
      $$RootsTableFilterComposer,
      $$RootsTableOrderingComposer,
      $$RootsTableAnnotationComposer,
      $$RootsTableCreateCompanionBuilder,
      $$RootsTableUpdateCompanionBuilder,
      (Root, $$RootsTableReferences),
      Root,
      PrefetchHooks Function({bool wordsRefs})
    >;
typedef $$WordsTableCreateCompanionBuilder =
    WordsCompanion Function({
      Value<int> id,
      required int surahNumber,
      required int ayahNumber,
      required int position,
      required String arabicText,
      required String transliteration,
      Value<String> translationGloss,
      Value<String> partOfSpeech,
      Value<String> grammarDetails,
      Value<int?> rootId,
    });
typedef $$WordsTableUpdateCompanionBuilder =
    WordsCompanion Function({
      Value<int> id,
      Value<int> surahNumber,
      Value<int> ayahNumber,
      Value<int> position,
      Value<String> arabicText,
      Value<String> transliteration,
      Value<String> translationGloss,
      Value<String> partOfSpeech,
      Value<String> grammarDetails,
      Value<int?> rootId,
    });

final class $$WordsTableReferences
    extends BaseReferences<_$AppDatabase, $WordsTable, Word> {
  $$WordsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RootsTable _rootIdTable(_$AppDatabase db) => db.roots.createAlias(
    $_aliasNameGenerator(db.words.rootId, db.roots.rootId),
  );

  $$RootsTableProcessedTableManager? get rootId {
    final $_column = $_itemColumn<int>('root_id');
    if ($_column == null) return null;
    final manager = $$RootsTableTableManager(
      $_db,
      $_db.roots,
    ).filter((f) => f.rootId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_rootIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WordsTableFilterComposer extends Composer<_$AppDatabase, $WordsTable> {
  $$WordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get arabicText => $composableBuilder(
    column: $table.arabicText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transliteration => $composableBuilder(
    column: $table.transliteration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get translationGloss => $composableBuilder(
    column: $table.translationGloss,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grammarDetails => $composableBuilder(
    column: $table.grammarDetails,
    builder: (column) => ColumnFilters(column),
  );

  $$RootsTableFilterComposer get rootId {
    final $$RootsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rootId,
      referencedTable: $db.roots,
      getReferencedColumn: (t) => t.rootId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RootsTableFilterComposer(
            $db: $db,
            $table: $db.roots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordsTableOrderingComposer
    extends Composer<_$AppDatabase, $WordsTable> {
  $$WordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get arabicText => $composableBuilder(
    column: $table.arabicText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transliteration => $composableBuilder(
    column: $table.transliteration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get translationGloss => $composableBuilder(
    column: $table.translationGloss,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grammarDetails => $composableBuilder(
    column: $table.grammarDetails,
    builder: (column) => ColumnOrderings(column),
  );

  $$RootsTableOrderingComposer get rootId {
    final $$RootsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rootId,
      referencedTable: $db.roots,
      getReferencedColumn: (t) => t.rootId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RootsTableOrderingComposer(
            $db: $db,
            $table: $db.roots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordsTable> {
  $$WordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get arabicText => $composableBuilder(
    column: $table.arabicText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get transliteration => $composableBuilder(
    column: $table.transliteration,
    builder: (column) => column,
  );

  GeneratedColumn<String> get translationGloss => $composableBuilder(
    column: $table.translationGloss,
    builder: (column) => column,
  );

  GeneratedColumn<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => column,
  );

  GeneratedColumn<String> get grammarDetails => $composableBuilder(
    column: $table.grammarDetails,
    builder: (column) => column,
  );

  $$RootsTableAnnotationComposer get rootId {
    final $$RootsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rootId,
      referencedTable: $db.roots,
      getReferencedColumn: (t) => t.rootId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RootsTableAnnotationComposer(
            $db: $db,
            $table: $db.roots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WordsTable,
          Word,
          $$WordsTableFilterComposer,
          $$WordsTableOrderingComposer,
          $$WordsTableAnnotationComposer,
          $$WordsTableCreateCompanionBuilder,
          $$WordsTableUpdateCompanionBuilder,
          (Word, $$WordsTableReferences),
          Word,
          PrefetchHooks Function({bool rootId})
        > {
  $$WordsTableTableManager(_$AppDatabase db, $WordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> surahNumber = const Value.absent(),
                Value<int> ayahNumber = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<String> arabicText = const Value.absent(),
                Value<String> transliteration = const Value.absent(),
                Value<String> translationGloss = const Value.absent(),
                Value<String> partOfSpeech = const Value.absent(),
                Value<String> grammarDetails = const Value.absent(),
                Value<int?> rootId = const Value.absent(),
              }) => WordsCompanion(
                id: id,
                surahNumber: surahNumber,
                ayahNumber: ayahNumber,
                position: position,
                arabicText: arabicText,
                transliteration: transliteration,
                translationGloss: translationGloss,
                partOfSpeech: partOfSpeech,
                grammarDetails: grammarDetails,
                rootId: rootId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int surahNumber,
                required int ayahNumber,
                required int position,
                required String arabicText,
                required String transliteration,
                Value<String> translationGloss = const Value.absent(),
                Value<String> partOfSpeech = const Value.absent(),
                Value<String> grammarDetails = const Value.absent(),
                Value<int?> rootId = const Value.absent(),
              }) => WordsCompanion.insert(
                id: id,
                surahNumber: surahNumber,
                ayahNumber: ayahNumber,
                position: position,
                arabicText: arabicText,
                transliteration: transliteration,
                translationGloss: translationGloss,
                partOfSpeech: partOfSpeech,
                grammarDetails: grammarDetails,
                rootId: rootId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$WordsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({rootId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (rootId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.rootId,
                                referencedTable: $$WordsTableReferences
                                    ._rootIdTable(db),
                                referencedColumn: $$WordsTableReferences
                                    ._rootIdTable(db)
                                    .rootId,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WordsTable,
      Word,
      $$WordsTableFilterComposer,
      $$WordsTableOrderingComposer,
      $$WordsTableAnnotationComposer,
      $$WordsTableCreateCompanionBuilder,
      $$WordsTableUpdateCompanionBuilder,
      (Word, $$WordsTableReferences),
      Word,
      PrefetchHooks Function({bool rootId})
    >;
typedef $$ContentPacksTableCreateCompanionBuilder =
    ContentPacksCompanion Function({
      required String packId,
      required String type,
      required String name,
      required String version,
      Value<bool> downloaded,
      required String downloadUrl,
      required int sizeBytes,
      required String licenseNote,
      Value<int> rowid,
    });
typedef $$ContentPacksTableUpdateCompanionBuilder =
    ContentPacksCompanion Function({
      Value<String> packId,
      Value<String> type,
      Value<String> name,
      Value<String> version,
      Value<bool> downloaded,
      Value<String> downloadUrl,
      Value<int> sizeBytes,
      Value<String> licenseNote,
      Value<int> rowid,
    });

class $$ContentPacksTableFilterComposer
    extends Composer<_$AppDatabase, $ContentPacksTable> {
  $$ContentPacksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get packId => $composableBuilder(
    column: $table.packId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get downloaded => $composableBuilder(
    column: $table.downloaded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get downloadUrl => $composableBuilder(
    column: $table.downloadUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get licenseNote => $composableBuilder(
    column: $table.licenseNote,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ContentPacksTableOrderingComposer
    extends Composer<_$AppDatabase, $ContentPacksTable> {
  $$ContentPacksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get packId => $composableBuilder(
    column: $table.packId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get downloaded => $composableBuilder(
    column: $table.downloaded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get downloadUrl => $composableBuilder(
    column: $table.downloadUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get licenseNote => $composableBuilder(
    column: $table.licenseNote,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ContentPacksTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContentPacksTable> {
  $$ContentPacksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get packId =>
      $composableBuilder(column: $table.packId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<bool> get downloaded => $composableBuilder(
    column: $table.downloaded,
    builder: (column) => column,
  );

  GeneratedColumn<String> get downloadUrl => $composableBuilder(
    column: $table.downloadUrl,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sizeBytes =>
      $composableBuilder(column: $table.sizeBytes, builder: (column) => column);

  GeneratedColumn<String> get licenseNote => $composableBuilder(
    column: $table.licenseNote,
    builder: (column) => column,
  );
}

class $$ContentPacksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ContentPacksTable,
          ContentPack,
          $$ContentPacksTableFilterComposer,
          $$ContentPacksTableOrderingComposer,
          $$ContentPacksTableAnnotationComposer,
          $$ContentPacksTableCreateCompanionBuilder,
          $$ContentPacksTableUpdateCompanionBuilder,
          (
            ContentPack,
            BaseReferences<_$AppDatabase, $ContentPacksTable, ContentPack>,
          ),
          ContentPack,
          PrefetchHooks Function()
        > {
  $$ContentPacksTableTableManager(_$AppDatabase db, $ContentPacksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContentPacksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContentPacksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContentPacksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> packId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> version = const Value.absent(),
                Value<bool> downloaded = const Value.absent(),
                Value<String> downloadUrl = const Value.absent(),
                Value<int> sizeBytes = const Value.absent(),
                Value<String> licenseNote = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ContentPacksCompanion(
                packId: packId,
                type: type,
                name: name,
                version: version,
                downloaded: downloaded,
                downloadUrl: downloadUrl,
                sizeBytes: sizeBytes,
                licenseNote: licenseNote,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String packId,
                required String type,
                required String name,
                required String version,
                Value<bool> downloaded = const Value.absent(),
                required String downloadUrl,
                required int sizeBytes,
                required String licenseNote,
                Value<int> rowid = const Value.absent(),
              }) => ContentPacksCompanion.insert(
                packId: packId,
                type: type,
                name: name,
                version: version,
                downloaded: downloaded,
                downloadUrl: downloadUrl,
                sizeBytes: sizeBytes,
                licenseNote: licenseNote,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ContentPacksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ContentPacksTable,
      ContentPack,
      $$ContentPacksTableFilterComposer,
      $$ContentPacksTableOrderingComposer,
      $$ContentPacksTableAnnotationComposer,
      $$ContentPacksTableCreateCompanionBuilder,
      $$ContentPacksTableUpdateCompanionBuilder,
      (
        ContentPack,
        BaseReferences<_$AppDatabase, $ContentPacksTable, ContentPack>,
      ),
      ContentPack,
      PrefetchHooks Function()
    >;
typedef $$TafsirsMetaTableCreateCompanionBuilder =
    TafsirsMetaCompanion Function({
      required String tafsirId,
      required String name,
      required String author,
      required String language,
      required String source,
      required String licenseNote,
      Value<int> rowid,
    });
typedef $$TafsirsMetaTableUpdateCompanionBuilder =
    TafsirsMetaCompanion Function({
      Value<String> tafsirId,
      Value<String> name,
      Value<String> author,
      Value<String> language,
      Value<String> source,
      Value<String> licenseNote,
      Value<int> rowid,
    });

class $$TafsirsMetaTableFilterComposer
    extends Composer<_$AppDatabase, $TafsirsMetaTable> {
  $$TafsirsMetaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get tafsirId => $composableBuilder(
    column: $table.tafsirId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get licenseNote => $composableBuilder(
    column: $table.licenseNote,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TafsirsMetaTableOrderingComposer
    extends Composer<_$AppDatabase, $TafsirsMetaTable> {
  $$TafsirsMetaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get tafsirId => $composableBuilder(
    column: $table.tafsirId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get licenseNote => $composableBuilder(
    column: $table.licenseNote,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TafsirsMetaTableAnnotationComposer
    extends Composer<_$AppDatabase, $TafsirsMetaTable> {
  $$TafsirsMetaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get tafsirId =>
      $composableBuilder(column: $table.tafsirId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get licenseNote => $composableBuilder(
    column: $table.licenseNote,
    builder: (column) => column,
  );
}

class $$TafsirsMetaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TafsirsMetaTable,
          TafsirMeta,
          $$TafsirsMetaTableFilterComposer,
          $$TafsirsMetaTableOrderingComposer,
          $$TafsirsMetaTableAnnotationComposer,
          $$TafsirsMetaTableCreateCompanionBuilder,
          $$TafsirsMetaTableUpdateCompanionBuilder,
          (
            TafsirMeta,
            BaseReferences<_$AppDatabase, $TafsirsMetaTable, TafsirMeta>,
          ),
          TafsirMeta,
          PrefetchHooks Function()
        > {
  $$TafsirsMetaTableTableManager(_$AppDatabase db, $TafsirsMetaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TafsirsMetaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TafsirsMetaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TafsirsMetaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> tafsirId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> author = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String> licenseNote = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TafsirsMetaCompanion(
                tafsirId: tafsirId,
                name: name,
                author: author,
                language: language,
                source: source,
                licenseNote: licenseNote,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String tafsirId,
                required String name,
                required String author,
                required String language,
                required String source,
                required String licenseNote,
                Value<int> rowid = const Value.absent(),
              }) => TafsirsMetaCompanion.insert(
                tafsirId: tafsirId,
                name: name,
                author: author,
                language: language,
                source: source,
                licenseNote: licenseNote,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TafsirsMetaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TafsirsMetaTable,
      TafsirMeta,
      $$TafsirsMetaTableFilterComposer,
      $$TafsirsMetaTableOrderingComposer,
      $$TafsirsMetaTableAnnotationComposer,
      $$TafsirsMetaTableCreateCompanionBuilder,
      $$TafsirsMetaTableUpdateCompanionBuilder,
      (
        TafsirMeta,
        BaseReferences<_$AppDatabase, $TafsirsMetaTable, TafsirMeta>,
      ),
      TafsirMeta,
      PrefetchHooks Function()
    >;
typedef $$TafsirContentTableCreateCompanionBuilder =
    TafsirContentCompanion Function({
      Value<int> id,
      required String tafsirId,
      required int surahNumber,
      required int startAyah,
      required int endAyah,
      required String textContent,
    });
typedef $$TafsirContentTableUpdateCompanionBuilder =
    TafsirContentCompanion Function({
      Value<int> id,
      Value<String> tafsirId,
      Value<int> surahNumber,
      Value<int> startAyah,
      Value<int> endAyah,
      Value<String> textContent,
    });

class $$TafsirContentTableFilterComposer
    extends Composer<_$AppDatabase, $TafsirContentTable> {
  $$TafsirContentTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tafsirId => $composableBuilder(
    column: $table.tafsirId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startAyah => $composableBuilder(
    column: $table.startAyah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endAyah => $composableBuilder(
    column: $table.endAyah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TafsirContentTableOrderingComposer
    extends Composer<_$AppDatabase, $TafsirContentTable> {
  $$TafsirContentTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tafsirId => $composableBuilder(
    column: $table.tafsirId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startAyah => $composableBuilder(
    column: $table.startAyah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endAyah => $composableBuilder(
    column: $table.endAyah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TafsirContentTableAnnotationComposer
    extends Composer<_$AppDatabase, $TafsirContentTable> {
  $$TafsirContentTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tafsirId =>
      $composableBuilder(column: $table.tafsirId, builder: (column) => column);

  GeneratedColumn<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get startAyah =>
      $composableBuilder(column: $table.startAyah, builder: (column) => column);

  GeneratedColumn<int> get endAyah =>
      $composableBuilder(column: $table.endAyah, builder: (column) => column);

  GeneratedColumn<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => column,
  );
}

class $$TafsirContentTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TafsirContentTable,
          TafsirContentData,
          $$TafsirContentTableFilterComposer,
          $$TafsirContentTableOrderingComposer,
          $$TafsirContentTableAnnotationComposer,
          $$TafsirContentTableCreateCompanionBuilder,
          $$TafsirContentTableUpdateCompanionBuilder,
          (
            TafsirContentData,
            BaseReferences<
              _$AppDatabase,
              $TafsirContentTable,
              TafsirContentData
            >,
          ),
          TafsirContentData,
          PrefetchHooks Function()
        > {
  $$TafsirContentTableTableManager(_$AppDatabase db, $TafsirContentTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TafsirContentTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TafsirContentTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TafsirContentTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> tafsirId = const Value.absent(),
                Value<int> surahNumber = const Value.absent(),
                Value<int> startAyah = const Value.absent(),
                Value<int> endAyah = const Value.absent(),
                Value<String> textContent = const Value.absent(),
              }) => TafsirContentCompanion(
                id: id,
                tafsirId: tafsirId,
                surahNumber: surahNumber,
                startAyah: startAyah,
                endAyah: endAyah,
                textContent: textContent,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String tafsirId,
                required int surahNumber,
                required int startAyah,
                required int endAyah,
                required String textContent,
              }) => TafsirContentCompanion.insert(
                id: id,
                tafsirId: tafsirId,
                surahNumber: surahNumber,
                startAyah: startAyah,
                endAyah: endAyah,
                textContent: textContent,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TafsirContentTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TafsirContentTable,
      TafsirContentData,
      $$TafsirContentTableFilterComposer,
      $$TafsirContentTableOrderingComposer,
      $$TafsirContentTableAnnotationComposer,
      $$TafsirContentTableCreateCompanionBuilder,
      $$TafsirContentTableUpdateCompanionBuilder,
      (
        TafsirContentData,
        BaseReferences<_$AppDatabase, $TafsirContentTable, TafsirContentData>,
      ),
      TafsirContentData,
      PrefetchHooks Function()
    >;
typedef $$TopicsTableCreateCompanionBuilder =
    TopicsCompanion Function({
      required String topicId,
      required String name,
      Value<String?> parentTopicId,
      Value<String> category,
      Value<int> rowid,
    });
typedef $$TopicsTableUpdateCompanionBuilder =
    TopicsCompanion Function({
      Value<String> topicId,
      Value<String> name,
      Value<String?> parentTopicId,
      Value<String> category,
      Value<int> rowid,
    });

final class $$TopicsTableReferences
    extends BaseReferences<_$AppDatabase, $TopicsTable, Topic> {
  $$TopicsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TopicAyahsTable, List<TopicAyah>>
  _topicAyahsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.topicAyahs,
    aliasName: $_aliasNameGenerator(db.topics.topicId, db.topicAyahs.topicId),
  );

  $$TopicAyahsTableProcessedTableManager get topicAyahsRefs {
    final manager = $$TopicAyahsTableTableManager($_db, $_db.topicAyahs).filter(
      (f) => f.topicId.topicId.sqlEquals($_itemColumn<String>('topic_id')!),
    );

    final cache = $_typedResult.readTableOrNull(_topicAyahsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TopicsTableFilterComposer
    extends Composer<_$AppDatabase, $TopicsTable> {
  $$TopicsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get topicId => $composableBuilder(
    column: $table.topicId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parentTopicId => $composableBuilder(
    column: $table.parentTopicId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> topicAyahsRefs(
    Expression<bool> Function($$TopicAyahsTableFilterComposer f) f,
  ) {
    final $$TopicAyahsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topicAyahs,
      getReferencedColumn: (t) => t.topicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicAyahsTableFilterComposer(
            $db: $db,
            $table: $db.topicAyahs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TopicsTableOrderingComposer
    extends Composer<_$AppDatabase, $TopicsTable> {
  $$TopicsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get topicId => $composableBuilder(
    column: $table.topicId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parentTopicId => $composableBuilder(
    column: $table.parentTopicId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TopicsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TopicsTable> {
  $$TopicsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get topicId =>
      $composableBuilder(column: $table.topicId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get parentTopicId => $composableBuilder(
    column: $table.parentTopicId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  Expression<T> topicAyahsRefs<T extends Object>(
    Expression<T> Function($$TopicAyahsTableAnnotationComposer a) f,
  ) {
    final $$TopicAyahsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topicAyahs,
      getReferencedColumn: (t) => t.topicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicAyahsTableAnnotationComposer(
            $db: $db,
            $table: $db.topicAyahs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TopicsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TopicsTable,
          Topic,
          $$TopicsTableFilterComposer,
          $$TopicsTableOrderingComposer,
          $$TopicsTableAnnotationComposer,
          $$TopicsTableCreateCompanionBuilder,
          $$TopicsTableUpdateCompanionBuilder,
          (Topic, $$TopicsTableReferences),
          Topic,
          PrefetchHooks Function({bool topicAyahsRefs})
        > {
  $$TopicsTableTableManager(_$AppDatabase db, $TopicsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TopicsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TopicsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TopicsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> topicId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> parentTopicId = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TopicsCompanion(
                topicId: topicId,
                name: name,
                parentTopicId: parentTopicId,
                category: category,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String topicId,
                required String name,
                Value<String?> parentTopicId = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TopicsCompanion.insert(
                topicId: topicId,
                name: name,
                parentTopicId: parentTopicId,
                category: category,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TopicsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({topicAyahsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (topicAyahsRefs) db.topicAyahs],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (topicAyahsRefs)
                    await $_getPrefetchedData<Topic, $TopicsTable, TopicAyah>(
                      currentTable: table,
                      referencedTable: $$TopicsTableReferences
                          ._topicAyahsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$TopicsTableReferences(db, table, p0).topicAyahsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.topicId == item.topicId,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TopicsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TopicsTable,
      Topic,
      $$TopicsTableFilterComposer,
      $$TopicsTableOrderingComposer,
      $$TopicsTableAnnotationComposer,
      $$TopicsTableCreateCompanionBuilder,
      $$TopicsTableUpdateCompanionBuilder,
      (Topic, $$TopicsTableReferences),
      Topic,
      PrefetchHooks Function({bool topicAyahsRefs})
    >;
typedef $$TopicAyahsTableCreateCompanionBuilder =
    TopicAyahsCompanion Function({
      required String topicId,
      required int surahNumber,
      required int ayahNumber,
      Value<int> rowid,
    });
typedef $$TopicAyahsTableUpdateCompanionBuilder =
    TopicAyahsCompanion Function({
      Value<String> topicId,
      Value<int> surahNumber,
      Value<int> ayahNumber,
      Value<int> rowid,
    });

final class $$TopicAyahsTableReferences
    extends BaseReferences<_$AppDatabase, $TopicAyahsTable, TopicAyah> {
  $$TopicAyahsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TopicsTable _topicIdTable(_$AppDatabase db) => db.topics.createAlias(
    $_aliasNameGenerator(db.topicAyahs.topicId, db.topics.topicId),
  );

  $$TopicsTableProcessedTableManager get topicId {
    final $_column = $_itemColumn<String>('topic_id')!;

    final manager = $$TopicsTableTableManager(
      $_db,
      $_db.topics,
    ).filter((f) => f.topicId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_topicIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TopicAyahsTableFilterComposer
    extends Composer<_$AppDatabase, $TopicAyahsTable> {
  $$TopicAyahsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnFilters(column),
  );

  $$TopicsTableFilterComposer get topicId {
    final $$TopicsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.topicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableFilterComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TopicAyahsTableOrderingComposer
    extends Composer<_$AppDatabase, $TopicAyahsTable> {
  $$TopicAyahsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  $$TopicsTableOrderingComposer get topicId {
    final $$TopicsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.topicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableOrderingComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TopicAyahsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TopicAyahsTable> {
  $$TopicAyahsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => column,
  );

  $$TopicsTableAnnotationComposer get topicId {
    final $$TopicsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.topicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableAnnotationComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TopicAyahsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TopicAyahsTable,
          TopicAyah,
          $$TopicAyahsTableFilterComposer,
          $$TopicAyahsTableOrderingComposer,
          $$TopicAyahsTableAnnotationComposer,
          $$TopicAyahsTableCreateCompanionBuilder,
          $$TopicAyahsTableUpdateCompanionBuilder,
          (TopicAyah, $$TopicAyahsTableReferences),
          TopicAyah,
          PrefetchHooks Function({bool topicId})
        > {
  $$TopicAyahsTableTableManager(_$AppDatabase db, $TopicAyahsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TopicAyahsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TopicAyahsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TopicAyahsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> topicId = const Value.absent(),
                Value<int> surahNumber = const Value.absent(),
                Value<int> ayahNumber = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TopicAyahsCompanion(
                topicId: topicId,
                surahNumber: surahNumber,
                ayahNumber: ayahNumber,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String topicId,
                required int surahNumber,
                required int ayahNumber,
                Value<int> rowid = const Value.absent(),
              }) => TopicAyahsCompanion.insert(
                topicId: topicId,
                surahNumber: surahNumber,
                ayahNumber: ayahNumber,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TopicAyahsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({topicId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (topicId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.topicId,
                                referencedTable: $$TopicAyahsTableReferences
                                    ._topicIdTable(db),
                                referencedColumn: $$TopicAyahsTableReferences
                                    ._topicIdTable(db)
                                    .topicId,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TopicAyahsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TopicAyahsTable,
      TopicAyah,
      $$TopicAyahsTableFilterComposer,
      $$TopicAyahsTableOrderingComposer,
      $$TopicAyahsTableAnnotationComposer,
      $$TopicAyahsTableCreateCompanionBuilder,
      $$TopicAyahsTableUpdateCompanionBuilder,
      (TopicAyah, $$TopicAyahsTableReferences),
      TopicAyah,
      PrefetchHooks Function({bool topicId})
    >;
typedef $$CrossReferencesTableCreateCompanionBuilder =
    CrossReferencesCompanion Function({
      Value<int> id,
      required int sourceSurah,
      required int sourceAyah,
      required int targetSurah,
      required int targetAyah,
      required String relationshipType,
      Value<String> notes,
    });
typedef $$CrossReferencesTableUpdateCompanionBuilder =
    CrossReferencesCompanion Function({
      Value<int> id,
      Value<int> sourceSurah,
      Value<int> sourceAyah,
      Value<int> targetSurah,
      Value<int> targetAyah,
      Value<String> relationshipType,
      Value<String> notes,
    });

class $$CrossReferencesTableFilterComposer
    extends Composer<_$AppDatabase, $CrossReferencesTable> {
  $$CrossReferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sourceSurah => $composableBuilder(
    column: $table.sourceSurah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sourceAyah => $composableBuilder(
    column: $table.sourceAyah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetSurah => $composableBuilder(
    column: $table.targetSurah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetAyah => $composableBuilder(
    column: $table.targetAyah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relationshipType => $composableBuilder(
    column: $table.relationshipType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CrossReferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $CrossReferencesTable> {
  $$CrossReferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sourceSurah => $composableBuilder(
    column: $table.sourceSurah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sourceAyah => $composableBuilder(
    column: $table.sourceAyah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetSurah => $composableBuilder(
    column: $table.targetSurah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetAyah => $composableBuilder(
    column: $table.targetAyah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relationshipType => $composableBuilder(
    column: $table.relationshipType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CrossReferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CrossReferencesTable> {
  $$CrossReferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sourceSurah => $composableBuilder(
    column: $table.sourceSurah,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sourceAyah => $composableBuilder(
    column: $table.sourceAyah,
    builder: (column) => column,
  );

  GeneratedColumn<int> get targetSurah => $composableBuilder(
    column: $table.targetSurah,
    builder: (column) => column,
  );

  GeneratedColumn<int> get targetAyah => $composableBuilder(
    column: $table.targetAyah,
    builder: (column) => column,
  );

  GeneratedColumn<String> get relationshipType => $composableBuilder(
    column: $table.relationshipType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$CrossReferencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CrossReferencesTable,
          CrossReference,
          $$CrossReferencesTableFilterComposer,
          $$CrossReferencesTableOrderingComposer,
          $$CrossReferencesTableAnnotationComposer,
          $$CrossReferencesTableCreateCompanionBuilder,
          $$CrossReferencesTableUpdateCompanionBuilder,
          (
            CrossReference,
            BaseReferences<
              _$AppDatabase,
              $CrossReferencesTable,
              CrossReference
            >,
          ),
          CrossReference,
          PrefetchHooks Function()
        > {
  $$CrossReferencesTableTableManager(
    _$AppDatabase db,
    $CrossReferencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CrossReferencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CrossReferencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CrossReferencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> sourceSurah = const Value.absent(),
                Value<int> sourceAyah = const Value.absent(),
                Value<int> targetSurah = const Value.absent(),
                Value<int> targetAyah = const Value.absent(),
                Value<String> relationshipType = const Value.absent(),
                Value<String> notes = const Value.absent(),
              }) => CrossReferencesCompanion(
                id: id,
                sourceSurah: sourceSurah,
                sourceAyah: sourceAyah,
                targetSurah: targetSurah,
                targetAyah: targetAyah,
                relationshipType: relationshipType,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int sourceSurah,
                required int sourceAyah,
                required int targetSurah,
                required int targetAyah,
                required String relationshipType,
                Value<String> notes = const Value.absent(),
              }) => CrossReferencesCompanion.insert(
                id: id,
                sourceSurah: sourceSurah,
                sourceAyah: sourceAyah,
                targetSurah: targetSurah,
                targetAyah: targetAyah,
                relationshipType: relationshipType,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CrossReferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CrossReferencesTable,
      CrossReference,
      $$CrossReferencesTableFilterComposer,
      $$CrossReferencesTableOrderingComposer,
      $$CrossReferencesTableAnnotationComposer,
      $$CrossReferencesTableCreateCompanionBuilder,
      $$CrossReferencesTableUpdateCompanionBuilder,
      (
        CrossReference,
        BaseReferences<_$AppDatabase, $CrossReferencesTable, CrossReference>,
      ),
      CrossReference,
      PrefetchHooks Function()
    >;
typedef $$AsbabAlNuzulTableCreateCompanionBuilder =
    AsbabAlNuzulCompanion Function({
      Value<int> id,
      required int surahNumber,
      required int startAyah,
      required int endAyah,
      required String textContent,
      required String sourceNote,
    });
typedef $$AsbabAlNuzulTableUpdateCompanionBuilder =
    AsbabAlNuzulCompanion Function({
      Value<int> id,
      Value<int> surahNumber,
      Value<int> startAyah,
      Value<int> endAyah,
      Value<String> textContent,
      Value<String> sourceNote,
    });

class $$AsbabAlNuzulTableFilterComposer
    extends Composer<_$AppDatabase, $AsbabAlNuzulTable> {
  $$AsbabAlNuzulTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startAyah => $composableBuilder(
    column: $table.startAyah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endAyah => $composableBuilder(
    column: $table.endAyah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceNote => $composableBuilder(
    column: $table.sourceNote,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AsbabAlNuzulTableOrderingComposer
    extends Composer<_$AppDatabase, $AsbabAlNuzulTable> {
  $$AsbabAlNuzulTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startAyah => $composableBuilder(
    column: $table.startAyah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endAyah => $composableBuilder(
    column: $table.endAyah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceNote => $composableBuilder(
    column: $table.sourceNote,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AsbabAlNuzulTableAnnotationComposer
    extends Composer<_$AppDatabase, $AsbabAlNuzulTable> {
  $$AsbabAlNuzulTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get startAyah =>
      $composableBuilder(column: $table.startAyah, builder: (column) => column);

  GeneratedColumn<int> get endAyah =>
      $composableBuilder(column: $table.endAyah, builder: (column) => column);

  GeneratedColumn<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceNote => $composableBuilder(
    column: $table.sourceNote,
    builder: (column) => column,
  );
}

class $$AsbabAlNuzulTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AsbabAlNuzulTable,
          AsbabAlNuzulEntry,
          $$AsbabAlNuzulTableFilterComposer,
          $$AsbabAlNuzulTableOrderingComposer,
          $$AsbabAlNuzulTableAnnotationComposer,
          $$AsbabAlNuzulTableCreateCompanionBuilder,
          $$AsbabAlNuzulTableUpdateCompanionBuilder,
          (
            AsbabAlNuzulEntry,
            BaseReferences<
              _$AppDatabase,
              $AsbabAlNuzulTable,
              AsbabAlNuzulEntry
            >,
          ),
          AsbabAlNuzulEntry,
          PrefetchHooks Function()
        > {
  $$AsbabAlNuzulTableTableManager(_$AppDatabase db, $AsbabAlNuzulTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AsbabAlNuzulTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AsbabAlNuzulTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AsbabAlNuzulTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> surahNumber = const Value.absent(),
                Value<int> startAyah = const Value.absent(),
                Value<int> endAyah = const Value.absent(),
                Value<String> textContent = const Value.absent(),
                Value<String> sourceNote = const Value.absent(),
              }) => AsbabAlNuzulCompanion(
                id: id,
                surahNumber: surahNumber,
                startAyah: startAyah,
                endAyah: endAyah,
                textContent: textContent,
                sourceNote: sourceNote,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int surahNumber,
                required int startAyah,
                required int endAyah,
                required String textContent,
                required String sourceNote,
              }) => AsbabAlNuzulCompanion.insert(
                id: id,
                surahNumber: surahNumber,
                startAyah: startAyah,
                endAyah: endAyah,
                textContent: textContent,
                sourceNote: sourceNote,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AsbabAlNuzulTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AsbabAlNuzulTable,
      AsbabAlNuzulEntry,
      $$AsbabAlNuzulTableFilterComposer,
      $$AsbabAlNuzulTableOrderingComposer,
      $$AsbabAlNuzulTableAnnotationComposer,
      $$AsbabAlNuzulTableCreateCompanionBuilder,
      $$AsbabAlNuzulTableUpdateCompanionBuilder,
      (
        AsbabAlNuzulEntry,
        BaseReferences<_$AppDatabase, $AsbabAlNuzulTable, AsbabAlNuzulEntry>,
      ),
      AsbabAlNuzulEntry,
      PrefetchHooks Function()
    >;
typedef $$CollectionsTableCreateCompanionBuilder =
    CollectionsCompanion Function({
      required String collectionId,
      required String name,
      Value<String> description,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$CollectionsTableUpdateCompanionBuilder =
    CollectionsCompanion Function({
      Value<String> collectionId,
      Value<String> name,
      Value<String> description,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$CollectionsTableReferences
    extends
        BaseReferences<_$AppDatabase, $CollectionsTable, WorkspaceCollection> {
  $$CollectionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BookmarksTable, List<Bookmark>>
  _bookmarksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.bookmarks,
    aliasName: $_aliasNameGenerator(
      db.collections.collectionId,
      db.bookmarks.collectionId,
    ),
  );

  $$BookmarksTableProcessedTableManager get bookmarksRefs {
    final manager = $$BookmarksTableTableManager($_db, $_db.bookmarks).filter(
      (f) => f.collectionId.collectionId.sqlEquals(
        $_itemColumn<String>('collection_id')!,
      ),
    );

    final cache = $_typedResult.readTableOrNull(_bookmarksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CollectionsTableFilterComposer
    extends Composer<_$AppDatabase, $CollectionsTable> {
  $$CollectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> bookmarksRefs(
    Expression<bool> Function($$BookmarksTableFilterComposer f) f,
  ) {
    final $$BookmarksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.bookmarks,
      getReferencedColumn: (t) => t.collectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookmarksTableFilterComposer(
            $db: $db,
            $table: $db.bookmarks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CollectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $CollectionsTable> {
  $$CollectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CollectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CollectionsTable> {
  $$CollectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> bookmarksRefs<T extends Object>(
    Expression<T> Function($$BookmarksTableAnnotationComposer a) f,
  ) {
    final $$BookmarksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.bookmarks,
      getReferencedColumn: (t) => t.collectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookmarksTableAnnotationComposer(
            $db: $db,
            $table: $db.bookmarks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CollectionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CollectionsTable,
          WorkspaceCollection,
          $$CollectionsTableFilterComposer,
          $$CollectionsTableOrderingComposer,
          $$CollectionsTableAnnotationComposer,
          $$CollectionsTableCreateCompanionBuilder,
          $$CollectionsTableUpdateCompanionBuilder,
          (WorkspaceCollection, $$CollectionsTableReferences),
          WorkspaceCollection,
          PrefetchHooks Function({bool bookmarksRefs})
        > {
  $$CollectionsTableTableManager(_$AppDatabase db, $CollectionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CollectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CollectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CollectionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> collectionId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CollectionsCompanion(
                collectionId: collectionId,
                name: name,
                description: description,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String collectionId,
                required String name,
                Value<String> description = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => CollectionsCompanion.insert(
                collectionId: collectionId,
                name: name,
                description: description,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CollectionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({bookmarksRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (bookmarksRefs) db.bookmarks],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (bookmarksRefs)
                    await $_getPrefetchedData<
                      WorkspaceCollection,
                      $CollectionsTable,
                      Bookmark
                    >(
                      currentTable: table,
                      referencedTable: $$CollectionsTableReferences
                          ._bookmarksRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CollectionsTableReferences(
                            db,
                            table,
                            p0,
                          ).bookmarksRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.collectionId == item.collectionId,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CollectionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CollectionsTable,
      WorkspaceCollection,
      $$CollectionsTableFilterComposer,
      $$CollectionsTableOrderingComposer,
      $$CollectionsTableAnnotationComposer,
      $$CollectionsTableCreateCompanionBuilder,
      $$CollectionsTableUpdateCompanionBuilder,
      (WorkspaceCollection, $$CollectionsTableReferences),
      WorkspaceCollection,
      PrefetchHooks Function({bool bookmarksRefs})
    >;
typedef $$BookmarksTableCreateCompanionBuilder =
    BookmarksCompanion Function({
      Value<int> id,
      required int surahNumber,
      required int ayahNumber,
      Value<String?> collectionId,
      required DateTime createdAt,
    });
typedef $$BookmarksTableUpdateCompanionBuilder =
    BookmarksCompanion Function({
      Value<int> id,
      Value<int> surahNumber,
      Value<int> ayahNumber,
      Value<String?> collectionId,
      Value<DateTime> createdAt,
    });

final class $$BookmarksTableReferences
    extends BaseReferences<_$AppDatabase, $BookmarksTable, Bookmark> {
  $$BookmarksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CollectionsTable _collectionIdTable(_$AppDatabase db) =>
      db.collections.createAlias(
        $_aliasNameGenerator(
          db.bookmarks.collectionId,
          db.collections.collectionId,
        ),
      );

  $$CollectionsTableProcessedTableManager? get collectionId {
    final $_column = $_itemColumn<String>('collection_id');
    if ($_column == null) return null;
    final manager = $$CollectionsTableTableManager(
      $_db,
      $_db.collections,
    ).filter((f) => f.collectionId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_collectionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BookmarksTableFilterComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CollectionsTableFilterComposer get collectionId {
    final $$CollectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.collections,
      getReferencedColumn: (t) => t.collectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionsTableFilterComposer(
            $db: $db,
            $table: $db.collections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BookmarksTableOrderingComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CollectionsTableOrderingComposer get collectionId {
    final $$CollectionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.collections,
      getReferencedColumn: (t) => t.collectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionsTableOrderingComposer(
            $db: $db,
            $table: $db.collections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BookmarksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CollectionsTableAnnotationComposer get collectionId {
    final $$CollectionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.collections,
      getReferencedColumn: (t) => t.collectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionsTableAnnotationComposer(
            $db: $db,
            $table: $db.collections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BookmarksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BookmarksTable,
          Bookmark,
          $$BookmarksTableFilterComposer,
          $$BookmarksTableOrderingComposer,
          $$BookmarksTableAnnotationComposer,
          $$BookmarksTableCreateCompanionBuilder,
          $$BookmarksTableUpdateCompanionBuilder,
          (Bookmark, $$BookmarksTableReferences),
          Bookmark,
          PrefetchHooks Function({bool collectionId})
        > {
  $$BookmarksTableTableManager(_$AppDatabase db, $BookmarksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BookmarksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BookmarksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BookmarksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> surahNumber = const Value.absent(),
                Value<int> ayahNumber = const Value.absent(),
                Value<String?> collectionId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => BookmarksCompanion(
                id: id,
                surahNumber: surahNumber,
                ayahNumber: ayahNumber,
                collectionId: collectionId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int surahNumber,
                required int ayahNumber,
                Value<String?> collectionId = const Value.absent(),
                required DateTime createdAt,
              }) => BookmarksCompanion.insert(
                id: id,
                surahNumber: surahNumber,
                ayahNumber: ayahNumber,
                collectionId: collectionId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BookmarksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({collectionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (collectionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.collectionId,
                                referencedTable: $$BookmarksTableReferences
                                    ._collectionIdTable(db),
                                referencedColumn: $$BookmarksTableReferences
                                    ._collectionIdTable(db)
                                    .collectionId,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$BookmarksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BookmarksTable,
      Bookmark,
      $$BookmarksTableFilterComposer,
      $$BookmarksTableOrderingComposer,
      $$BookmarksTableAnnotationComposer,
      $$BookmarksTableCreateCompanionBuilder,
      $$BookmarksTableUpdateCompanionBuilder,
      (Bookmark, $$BookmarksTableReferences),
      Bookmark,
      PrefetchHooks Function({bool collectionId})
    >;
typedef $$NotesTableCreateCompanionBuilder =
    NotesCompanion Function({
      required String noteId,
      required int surahNumber,
      required int startAyah,
      required int endAyah,
      required String textContent,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$NotesTableUpdateCompanionBuilder =
    NotesCompanion Function({
      Value<String> noteId,
      Value<int> surahNumber,
      Value<int> startAyah,
      Value<int> endAyah,
      Value<String> textContent,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$NotesTableFilterComposer extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get noteId => $composableBuilder(
    column: $table.noteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startAyah => $composableBuilder(
    column: $table.startAyah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endAyah => $composableBuilder(
    column: $table.endAyah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotesTableOrderingComposer
    extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get noteId => $composableBuilder(
    column: $table.noteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startAyah => $composableBuilder(
    column: $table.startAyah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endAyah => $composableBuilder(
    column: $table.endAyah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get noteId =>
      $composableBuilder(column: $table.noteId, builder: (column) => column);

  GeneratedColumn<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get startAyah =>
      $composableBuilder(column: $table.startAyah, builder: (column) => column);

  GeneratedColumn<int> get endAyah =>
      $composableBuilder(column: $table.endAyah, builder: (column) => column);

  GeneratedColumn<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$NotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotesTable,
          UserNote,
          $$NotesTableFilterComposer,
          $$NotesTableOrderingComposer,
          $$NotesTableAnnotationComposer,
          $$NotesTableCreateCompanionBuilder,
          $$NotesTableUpdateCompanionBuilder,
          (UserNote, BaseReferences<_$AppDatabase, $NotesTable, UserNote>),
          UserNote,
          PrefetchHooks Function()
        > {
  $$NotesTableTableManager(_$AppDatabase db, $NotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> noteId = const Value.absent(),
                Value<int> surahNumber = const Value.absent(),
                Value<int> startAyah = const Value.absent(),
                Value<int> endAyah = const Value.absent(),
                Value<String> textContent = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotesCompanion(
                noteId: noteId,
                surahNumber: surahNumber,
                startAyah: startAyah,
                endAyah: endAyah,
                textContent: textContent,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String noteId,
                required int surahNumber,
                required int startAyah,
                required int endAyah,
                required String textContent,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => NotesCompanion.insert(
                noteId: noteId,
                surahNumber: surahNumber,
                startAyah: startAyah,
                endAyah: endAyah,
                textContent: textContent,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotesTable,
      UserNote,
      $$NotesTableFilterComposer,
      $$NotesTableOrderingComposer,
      $$NotesTableAnnotationComposer,
      $$NotesTableCreateCompanionBuilder,
      $$NotesTableUpdateCompanionBuilder,
      (UserNote, BaseReferences<_$AppDatabase, $NotesTable, UserNote>),
      UserNote,
      PrefetchHooks Function()
    >;
typedef $$TagsTableCreateCompanionBuilder =
    TagsCompanion Function({
      required String tagId,
      required String name,
      Value<String> colorHex,
      Value<int> rowid,
    });
typedef $$TagsTableUpdateCompanionBuilder =
    TagsCompanion Function({
      Value<String> tagId,
      Value<String> name,
      Value<String> colorHex,
      Value<int> rowid,
    });

final class $$TagsTableReferences
    extends BaseReferences<_$AppDatabase, $TagsTable, WorkspaceTag> {
  $$TagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ItemTagsTable, List<ItemTag>> _itemTagsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.itemTags,
    aliasName: $_aliasNameGenerator(db.tags.tagId, db.itemTags.tagId),
  );

  $$ItemTagsTableProcessedTableManager get itemTagsRefs {
    final manager = $$ItemTagsTableTableManager(
      $_db,
      $_db.itemTags,
    ).filter((f) => f.tagId.tagId.sqlEquals($_itemColumn<String>('tag_id')!));

    final cache = $_typedResult.readTableOrNull(_itemTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TagsTableFilterComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get tagId => $composableBuilder(
    column: $table.tagId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colorHex => $composableBuilder(
    column: $table.colorHex,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> itemTagsRefs(
    Expression<bool> Function($$ItemTagsTableFilterComposer f) f,
  ) {
    final $$ItemTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.itemTags,
      getReferencedColumn: (t) => t.tagId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemTagsTableFilterComposer(
            $db: $db,
            $table: $db.itemTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TagsTableOrderingComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get tagId => $composableBuilder(
    column: $table.tagId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colorHex => $composableBuilder(
    column: $table.colorHex,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get tagId =>
      $composableBuilder(column: $table.tagId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get colorHex =>
      $composableBuilder(column: $table.colorHex, builder: (column) => column);

  Expression<T> itemTagsRefs<T extends Object>(
    Expression<T> Function($$ItemTagsTableAnnotationComposer a) f,
  ) {
    final $$ItemTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.itemTags,
      getReferencedColumn: (t) => t.tagId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.itemTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TagsTable,
          WorkspaceTag,
          $$TagsTableFilterComposer,
          $$TagsTableOrderingComposer,
          $$TagsTableAnnotationComposer,
          $$TagsTableCreateCompanionBuilder,
          $$TagsTableUpdateCompanionBuilder,
          (WorkspaceTag, $$TagsTableReferences),
          WorkspaceTag,
          PrefetchHooks Function({bool itemTagsRefs})
        > {
  $$TagsTableTableManager(_$AppDatabase db, $TagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> tagId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> colorHex = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TagsCompanion(
                tagId: tagId,
                name: name,
                colorHex: colorHex,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String tagId,
                required String name,
                Value<String> colorHex = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TagsCompanion.insert(
                tagId: tagId,
                name: name,
                colorHex: colorHex,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TagsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({itemTagsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (itemTagsRefs) db.itemTags],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (itemTagsRefs)
                    await $_getPrefetchedData<
                      WorkspaceTag,
                      $TagsTable,
                      ItemTag
                    >(
                      currentTable: table,
                      referencedTable: $$TagsTableReferences._itemTagsRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$TagsTableReferences(db, table, p0).itemTagsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.tagId == item.tagId),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TagsTable,
      WorkspaceTag,
      $$TagsTableFilterComposer,
      $$TagsTableOrderingComposer,
      $$TagsTableAnnotationComposer,
      $$TagsTableCreateCompanionBuilder,
      $$TagsTableUpdateCompanionBuilder,
      (WorkspaceTag, $$TagsTableReferences),
      WorkspaceTag,
      PrefetchHooks Function({bool itemTagsRefs})
    >;
typedef $$ItemTagsTableCreateCompanionBuilder =
    ItemTagsCompanion Function({
      required String itemType,
      required String itemId,
      required String tagId,
      Value<int> rowid,
    });
typedef $$ItemTagsTableUpdateCompanionBuilder =
    ItemTagsCompanion Function({
      Value<String> itemType,
      Value<String> itemId,
      Value<String> tagId,
      Value<int> rowid,
    });

final class $$ItemTagsTableReferences
    extends BaseReferences<_$AppDatabase, $ItemTagsTable, ItemTag> {
  $$ItemTagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TagsTable _tagIdTable(_$AppDatabase db) => db.tags.createAlias(
    $_aliasNameGenerator(db.itemTags.tagId, db.tags.tagId),
  );

  $$TagsTableProcessedTableManager get tagId {
    final $_column = $_itemColumn<String>('tag_id')!;

    final manager = $$TagsTableTableManager(
      $_db,
      $_db.tags,
    ).filter((f) => f.tagId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tagIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ItemTagsTableFilterComposer
    extends Composer<_$AppDatabase, $ItemTagsTable> {
  $$ItemTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get itemType => $composableBuilder(
    column: $table.itemType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnFilters(column),
  );

  $$TagsTableFilterComposer get tagId {
    final $$TagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.tagId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableFilterComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ItemTagsTableOrderingComposer
    extends Composer<_$AppDatabase, $ItemTagsTable> {
  $$ItemTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get itemType => $composableBuilder(
    column: $table.itemType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnOrderings(column),
  );

  $$TagsTableOrderingComposer get tagId {
    final $$TagsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.tagId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableOrderingComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ItemTagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ItemTagsTable> {
  $$ItemTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get itemType =>
      $composableBuilder(column: $table.itemType, builder: (column) => column);

  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  $$TagsTableAnnotationComposer get tagId {
    final $$TagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.tagId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableAnnotationComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ItemTagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ItemTagsTable,
          ItemTag,
          $$ItemTagsTableFilterComposer,
          $$ItemTagsTableOrderingComposer,
          $$ItemTagsTableAnnotationComposer,
          $$ItemTagsTableCreateCompanionBuilder,
          $$ItemTagsTableUpdateCompanionBuilder,
          (ItemTag, $$ItemTagsTableReferences),
          ItemTag,
          PrefetchHooks Function({bool tagId})
        > {
  $$ItemTagsTableTableManager(_$AppDatabase db, $ItemTagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItemTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ItemTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ItemTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> itemType = const Value.absent(),
                Value<String> itemId = const Value.absent(),
                Value<String> tagId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ItemTagsCompanion(
                itemType: itemType,
                itemId: itemId,
                tagId: tagId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String itemType,
                required String itemId,
                required String tagId,
                Value<int> rowid = const Value.absent(),
              }) => ItemTagsCompanion.insert(
                itemType: itemType,
                itemId: itemId,
                tagId: tagId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ItemTagsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({tagId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (tagId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.tagId,
                                referencedTable: $$ItemTagsTableReferences
                                    ._tagIdTable(db),
                                referencedColumn: $$ItemTagsTableReferences
                                    ._tagIdTable(db)
                                    .tagId,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ItemTagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ItemTagsTable,
      ItemTag,
      $$ItemTagsTableFilterComposer,
      $$ItemTagsTableOrderingComposer,
      $$ItemTagsTableAnnotationComposer,
      $$ItemTagsTableCreateCompanionBuilder,
      $$ItemTagsTableUpdateCompanionBuilder,
      (ItemTag, $$ItemTagsTableReferences),
      ItemTag,
      PrefetchHooks Function({bool tagId})
    >;
typedef $$AiHistoryTableCreateCompanionBuilder =
    AiHistoryCompanion Function({
      Value<int> id,
      required String sessionType,
      required String contextLabel,
      required String promptSent,
      required String responseReceived,
      required DateTime createdAt,
    });
typedef $$AiHistoryTableUpdateCompanionBuilder =
    AiHistoryCompanion Function({
      Value<int> id,
      Value<String> sessionType,
      Value<String> contextLabel,
      Value<String> promptSent,
      Value<String> responseReceived,
      Value<DateTime> createdAt,
    });

class $$AiHistoryTableFilterComposer
    extends Composer<_$AppDatabase, $AiHistoryTable> {
  $$AiHistoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sessionType => $composableBuilder(
    column: $table.sessionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contextLabel => $composableBuilder(
    column: $table.contextLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get promptSent => $composableBuilder(
    column: $table.promptSent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get responseReceived => $composableBuilder(
    column: $table.responseReceived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AiHistoryTableOrderingComposer
    extends Composer<_$AppDatabase, $AiHistoryTable> {
  $$AiHistoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sessionType => $composableBuilder(
    column: $table.sessionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contextLabel => $composableBuilder(
    column: $table.contextLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get promptSent => $composableBuilder(
    column: $table.promptSent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get responseReceived => $composableBuilder(
    column: $table.responseReceived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AiHistoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $AiHistoryTable> {
  $$AiHistoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessionType => $composableBuilder(
    column: $table.sessionType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contextLabel => $composableBuilder(
    column: $table.contextLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get promptSent => $composableBuilder(
    column: $table.promptSent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get responseReceived => $composableBuilder(
    column: $table.responseReceived,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AiHistoryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AiHistoryTable,
          AiHistoryEntry,
          $$AiHistoryTableFilterComposer,
          $$AiHistoryTableOrderingComposer,
          $$AiHistoryTableAnnotationComposer,
          $$AiHistoryTableCreateCompanionBuilder,
          $$AiHistoryTableUpdateCompanionBuilder,
          (
            AiHistoryEntry,
            BaseReferences<_$AppDatabase, $AiHistoryTable, AiHistoryEntry>,
          ),
          AiHistoryEntry,
          PrefetchHooks Function()
        > {
  $$AiHistoryTableTableManager(_$AppDatabase db, $AiHistoryTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AiHistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AiHistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AiHistoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> sessionType = const Value.absent(),
                Value<String> contextLabel = const Value.absent(),
                Value<String> promptSent = const Value.absent(),
                Value<String> responseReceived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AiHistoryCompanion(
                id: id,
                sessionType: sessionType,
                contextLabel: contextLabel,
                promptSent: promptSent,
                responseReceived: responseReceived,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String sessionType,
                required String contextLabel,
                required String promptSent,
                required String responseReceived,
                required DateTime createdAt,
              }) => AiHistoryCompanion.insert(
                id: id,
                sessionType: sessionType,
                contextLabel: contextLabel,
                promptSent: promptSent,
                responseReceived: responseReceived,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AiHistoryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AiHistoryTable,
      AiHistoryEntry,
      $$AiHistoryTableFilterComposer,
      $$AiHistoryTableOrderingComposer,
      $$AiHistoryTableAnnotationComposer,
      $$AiHistoryTableCreateCompanionBuilder,
      $$AiHistoryTableUpdateCompanionBuilder,
      (
        AiHistoryEntry,
        BaseReferences<_$AppDatabase, $AiHistoryTable, AiHistoryEntry>,
      ),
      AiHistoryEntry,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SurahsTableTableManager get surahs =>
      $$SurahsTableTableManager(_db, _db.surahs);
  $$AyahsTableTableManager get ayahs =>
      $$AyahsTableTableManager(_db, _db.ayahs);
  $$TranslationsMetaTableTableManager get translationsMeta =>
      $$TranslationsMetaTableTableManager(_db, _db.translationsMeta);
  $$AyahTranslationsTableTableManager get ayahTranslations =>
      $$AyahTranslationsTableTableManager(_db, _db.ayahTranslations);
  $$RootsTableTableManager get roots =>
      $$RootsTableTableManager(_db, _db.roots);
  $$WordsTableTableManager get words =>
      $$WordsTableTableManager(_db, _db.words);
  $$ContentPacksTableTableManager get contentPacks =>
      $$ContentPacksTableTableManager(_db, _db.contentPacks);
  $$TafsirsMetaTableTableManager get tafsirsMeta =>
      $$TafsirsMetaTableTableManager(_db, _db.tafsirsMeta);
  $$TafsirContentTableTableManager get tafsirContent =>
      $$TafsirContentTableTableManager(_db, _db.tafsirContent);
  $$TopicsTableTableManager get topics =>
      $$TopicsTableTableManager(_db, _db.topics);
  $$TopicAyahsTableTableManager get topicAyahs =>
      $$TopicAyahsTableTableManager(_db, _db.topicAyahs);
  $$CrossReferencesTableTableManager get crossReferences =>
      $$CrossReferencesTableTableManager(_db, _db.crossReferences);
  $$AsbabAlNuzulTableTableManager get asbabAlNuzul =>
      $$AsbabAlNuzulTableTableManager(_db, _db.asbabAlNuzul);
  $$CollectionsTableTableManager get collections =>
      $$CollectionsTableTableManager(_db, _db.collections);
  $$BookmarksTableTableManager get bookmarks =>
      $$BookmarksTableTableManager(_db, _db.bookmarks);
  $$NotesTableTableManager get notes =>
      $$NotesTableTableManager(_db, _db.notes);
  $$TagsTableTableManager get tags => $$TagsTableTableManager(_db, _db.tags);
  $$ItemTagsTableTableManager get itemTags =>
      $$ItemTagsTableTableManager(_db, _db.itemTags);
  $$AiHistoryTableTableManager get aiHistory =>
      $$AiHistoryTableTableManager(_db, _db.aiHistory);
}
