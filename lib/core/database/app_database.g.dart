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
  @override
  List<GeneratedColumn> get $columns => [rootId, rootArabic, rootTranslit];
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
  const Root({
    required this.rootId,
    required this.rootArabic,
    required this.rootTranslit,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['root_id'] = Variable<int>(rootId);
    map['root_arabic'] = Variable<String>(rootArabic);
    map['root_translit'] = Variable<String>(rootTranslit);
    return map;
  }

  RootsCompanion toCompanion(bool nullToAbsent) {
    return RootsCompanion(
      rootId: Value(rootId),
      rootArabic: Value(rootArabic),
      rootTranslit: Value(rootTranslit),
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
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'rootId': serializer.toJson<int>(rootId),
      'rootArabic': serializer.toJson<String>(rootArabic),
      'rootTranslit': serializer.toJson<String>(rootTranslit),
    };
  }

  Root copyWith({int? rootId, String? rootArabic, String? rootTranslit}) =>
      Root(
        rootId: rootId ?? this.rootId,
        rootArabic: rootArabic ?? this.rootArabic,
        rootTranslit: rootTranslit ?? this.rootTranslit,
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
    );
  }

  @override
  String toString() {
    return (StringBuffer('Root(')
          ..write('rootId: $rootId, ')
          ..write('rootArabic: $rootArabic, ')
          ..write('rootTranslit: $rootTranslit')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(rootId, rootArabic, rootTranslit);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Root &&
          other.rootId == this.rootId &&
          other.rootArabic == this.rootArabic &&
          other.rootTranslit == this.rootTranslit);
}

class RootsCompanion extends UpdateCompanion<Root> {
  final Value<int> rootId;
  final Value<String> rootArabic;
  final Value<String> rootTranslit;
  const RootsCompanion({
    this.rootId = const Value.absent(),
    this.rootArabic = const Value.absent(),
    this.rootTranslit = const Value.absent(),
  });
  RootsCompanion.insert({
    this.rootId = const Value.absent(),
    required String rootArabic,
    required String rootTranslit,
  }) : rootArabic = Value(rootArabic),
       rootTranslit = Value(rootTranslit);
  static Insertable<Root> custom({
    Expression<int>? rootId,
    Expression<String>? rootArabic,
    Expression<String>? rootTranslit,
  }) {
    return RawValuesInsertable({
      if (rootId != null) 'root_id': rootId,
      if (rootArabic != null) 'root_arabic': rootArabic,
      if (rootTranslit != null) 'root_translit': rootTranslit,
    });
  }

  RootsCompanion copyWith({
    Value<int>? rootId,
    Value<String>? rootArabic,
    Value<String>? rootTranslit,
  }) {
    return RootsCompanion(
      rootId: rootId ?? this.rootId,
      rootArabic: rootArabic ?? this.rootArabic,
      rootTranslit: rootTranslit ?? this.rootTranslit,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RootsCompanion(')
          ..write('rootId: $rootId, ')
          ..write('rootArabic: $rootArabic, ')
          ..write('rootTranslit: $rootTranslit')
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
  final int? rootId;
  const Word({
    required this.id,
    required this.surahNumber,
    required this.ayahNumber,
    required this.position,
    required this.arabicText,
    required this.transliteration,
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
    Value<int?> rootId = const Value.absent(),
  }) => Word(
    id: id ?? this.id,
    surahNumber: surahNumber ?? this.surahNumber,
    ayahNumber: ayahNumber ?? this.ayahNumber,
    position: position ?? this.position,
    arabicText: arabicText ?? this.arabicText,
    transliteration: transliteration ?? this.transliteration,
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
          other.rootId == this.rootId);
}

class WordsCompanion extends UpdateCompanion<Word> {
  final Value<int> id;
  final Value<int> surahNumber;
  final Value<int> ayahNumber;
  final Value<int> position;
  final Value<String> arabicText;
  final Value<String> transliteration;
  final Value<int?> rootId;
  const WordsCompanion({
    this.id = const Value.absent(),
    this.surahNumber = const Value.absent(),
    this.ayahNumber = const Value.absent(),
    this.position = const Value.absent(),
    this.arabicText = const Value.absent(),
    this.transliteration = const Value.absent(),
    this.rootId = const Value.absent(),
  });
  WordsCompanion.insert({
    this.id = const Value.absent(),
    required int surahNumber,
    required int ayahNumber,
    required int position,
    required String arabicText,
    required String transliteration,
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
    Expression<int>? rootId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surahNumber != null) 'surah_number': surahNumber,
      if (ayahNumber != null) 'ayah_number': ayahNumber,
      if (position != null) 'position': position,
      if (arabicText != null) 'arabic_text': arabicText,
      if (transliteration != null) 'transliteration': transliteration,
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
    Value<int?>? rootId,
  }) {
    return WordsCompanion(
      id: id ?? this.id,
      surahNumber: surahNumber ?? this.surahNumber,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      position: position ?? this.position,
      arabicText: arabicText ?? this.arabicText,
      transliteration: transliteration ?? this.transliteration,
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
  late final QuranDao quranDao = QuranDao(this as AppDatabase);
  late final SearchDao searchDao = SearchDao(this as AppDatabase);
  late final ContentPackDao contentPackDao = ContentPackDao(
    this as AppDatabase,
  );
  late final TafsirDao tafsirDao = TafsirDao(this as AppDatabase);
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
    });
typedef $$RootsTableUpdateCompanionBuilder =
    RootsCompanion Function({
      Value<int> rootId,
      Value<String> rootArabic,
      Value<String> rootTranslit,
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
              }) => RootsCompanion(
                rootId: rootId,
                rootArabic: rootArabic,
                rootTranslit: rootTranslit,
              ),
          createCompanionCallback:
              ({
                Value<int> rootId = const Value.absent(),
                required String rootArabic,
                required String rootTranslit,
              }) => RootsCompanion.insert(
                rootId: rootId,
                rootArabic: rootArabic,
                rootTranslit: rootTranslit,
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
                Value<int?> rootId = const Value.absent(),
              }) => WordsCompanion(
                id: id,
                surahNumber: surahNumber,
                ayahNumber: ayahNumber,
                position: position,
                arabicText: arabicText,
                transliteration: transliteration,
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
                Value<int?> rootId = const Value.absent(),
              }) => WordsCompanion.insert(
                id: id,
                surahNumber: surahNumber,
                ayahNumber: ayahNumber,
                position: position,
                arabicText: arabicText,
                transliteration: transliteration,
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
}
