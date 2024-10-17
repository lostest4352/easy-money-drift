// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $TransactionModelDriftTable extends TransactionModelDrift
    with TableInfo<$TransactionModelDriftTable, TransactionModelDriftData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionModelDriftTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateAndTimeMeta =
      const VerificationMeta('dateAndTime');
  @override
  late final GeneratedColumn<String> dateAndTime = GeneratedColumn<String>(
      'date_and_time', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _categoryModelMeta =
      const VerificationMeta('categoryModel');
  @override
  late final GeneratedColumnWithTypeConverter<CategoryModel, String>
      categoryModel = GeneratedColumn<String>(
              'category_model', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<CategoryModel>(
              $TransactionModelDriftTable.$convertercategoryModel);
  @override
  List<GeneratedColumn> get $columns =>
      [id, dateAndTime, amount, note, categoryModel];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transaction_model_drift';
  @override
  VerificationContext validateIntegrity(
      Insertable<TransactionModelDriftData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date_and_time')) {
      context.handle(
          _dateAndTimeMeta,
          dateAndTime.isAcceptableOrUnknown(
              data['date_and_time']!, _dateAndTimeMeta));
    } else if (isInserting) {
      context.missing(_dateAndTimeMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    context.handle(_categoryModelMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionModelDriftData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionModelDriftData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      dateAndTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date_and_time'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      categoryModel: $TransactionModelDriftTable.$convertercategoryModel
          .fromSql(attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}category_model'])!),
    );
  }

  @override
  $TransactionModelDriftTable createAlias(String alias) {
    return $TransactionModelDriftTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CategoryModel, String, String>
      $convertercategoryModel = const CategoryConverter();
}

class TransactionModelDriftData extends DataClass
    implements Insertable<TransactionModelDriftData> {
  final int id;
  final String dateAndTime;
  final int amount;
  final String? note;
  final CategoryModel categoryModel;
  const TransactionModelDriftData(
      {required this.id,
      required this.dateAndTime,
      required this.amount,
      this.note,
      required this.categoryModel});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date_and_time'] = Variable<String>(dateAndTime);
    map['amount'] = Variable<int>(amount);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    {
      map['category_model'] = Variable<String>($TransactionModelDriftTable
          .$convertercategoryModel
          .toSql(categoryModel));
    }
    return map;
  }

  TransactionModelDriftCompanion toCompanion(bool nullToAbsent) {
    return TransactionModelDriftCompanion(
      id: Value(id),
      dateAndTime: Value(dateAndTime),
      amount: Value(amount),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      categoryModel: Value(categoryModel),
    );
  }

  factory TransactionModelDriftData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionModelDriftData(
      id: serializer.fromJson<int>(json['id']),
      dateAndTime: serializer.fromJson<String>(json['dateAndTime']),
      amount: serializer.fromJson<int>(json['amount']),
      note: serializer.fromJson<String?>(json['note']),
      categoryModel: $TransactionModelDriftTable.$convertercategoryModel
          .fromJson(serializer.fromJson<String>(json['categoryModel'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dateAndTime': serializer.toJson<String>(dateAndTime),
      'amount': serializer.toJson<int>(amount),
      'note': serializer.toJson<String?>(note),
      'categoryModel': serializer.toJson<String>($TransactionModelDriftTable
          .$convertercategoryModel
          .toJson(categoryModel)),
    };
  }

  TransactionModelDriftData copyWith(
          {int? id,
          String? dateAndTime,
          int? amount,
          Value<String?> note = const Value.absent(),
          CategoryModel? categoryModel}) =>
      TransactionModelDriftData(
        id: id ?? this.id,
        dateAndTime: dateAndTime ?? this.dateAndTime,
        amount: amount ?? this.amount,
        note: note.present ? note.value : this.note,
        categoryModel: categoryModel ?? this.categoryModel,
      );
  TransactionModelDriftData copyWithCompanion(
      TransactionModelDriftCompanion data) {
    return TransactionModelDriftData(
      id: data.id.present ? data.id.value : this.id,
      dateAndTime:
          data.dateAndTime.present ? data.dateAndTime.value : this.dateAndTime,
      amount: data.amount.present ? data.amount.value : this.amount,
      note: data.note.present ? data.note.value : this.note,
      categoryModel: data.categoryModel.present
          ? data.categoryModel.value
          : this.categoryModel,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionModelDriftData(')
          ..write('id: $id, ')
          ..write('dateAndTime: $dateAndTime, ')
          ..write('amount: $amount, ')
          ..write('note: $note, ')
          ..write('categoryModel: $categoryModel')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, dateAndTime, amount, note, categoryModel);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionModelDriftData &&
          other.id == this.id &&
          other.dateAndTime == this.dateAndTime &&
          other.amount == this.amount &&
          other.note == this.note &&
          other.categoryModel == this.categoryModel);
}

class TransactionModelDriftCompanion
    extends UpdateCompanion<TransactionModelDriftData> {
  final Value<int> id;
  final Value<String> dateAndTime;
  final Value<int> amount;
  final Value<String?> note;
  final Value<CategoryModel> categoryModel;
  const TransactionModelDriftCompanion({
    this.id = const Value.absent(),
    this.dateAndTime = const Value.absent(),
    this.amount = const Value.absent(),
    this.note = const Value.absent(),
    this.categoryModel = const Value.absent(),
  });
  TransactionModelDriftCompanion.insert({
    this.id = const Value.absent(),
    required String dateAndTime,
    required int amount,
    this.note = const Value.absent(),
    required CategoryModel categoryModel,
  })  : dateAndTime = Value(dateAndTime),
        amount = Value(amount),
        categoryModel = Value(categoryModel);
  static Insertable<TransactionModelDriftData> custom({
    Expression<int>? id,
    Expression<String>? dateAndTime,
    Expression<int>? amount,
    Expression<String>? note,
    Expression<String>? categoryModel,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dateAndTime != null) 'date_and_time': dateAndTime,
      if (amount != null) 'amount': amount,
      if (note != null) 'note': note,
      if (categoryModel != null) 'category_model': categoryModel,
    });
  }

  TransactionModelDriftCompanion copyWith(
      {Value<int>? id,
      Value<String>? dateAndTime,
      Value<int>? amount,
      Value<String?>? note,
      Value<CategoryModel>? categoryModel}) {
    return TransactionModelDriftCompanion(
      id: id ?? this.id,
      dateAndTime: dateAndTime ?? this.dateAndTime,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      categoryModel: categoryModel ?? this.categoryModel,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dateAndTime.present) {
      map['date_and_time'] = Variable<String>(dateAndTime.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (categoryModel.present) {
      map['category_model'] = Variable<String>($TransactionModelDriftTable
          .$convertercategoryModel
          .toSql(categoryModel.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionModelDriftCompanion(')
          ..write('id: $id, ')
          ..write('dateAndTime: $dateAndTime, ')
          ..write('amount: $amount, ')
          ..write('note: $note, ')
          ..write('categoryModel: $categoryModel')
          ..write(')'))
        .toString();
  }
}

class $CategoryModelDriftTable extends CategoryModelDrift
    with TableInfo<$CategoryModelDriftTable, CategoryModelDriftData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryModelDriftTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _categoryModelMeta =
      const VerificationMeta('categoryModel');
  @override
  late final GeneratedColumnWithTypeConverter<CategoryModel, String>
      categoryModel = GeneratedColumn<String>(
              'category_model', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<CategoryModel>(
              $CategoryModelDriftTable.$convertercategoryModel);
  @override
  List<GeneratedColumn> get $columns => [id, categoryModel];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'category_model_drift';
  @override
  VerificationContext validateIntegrity(
      Insertable<CategoryModelDriftData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    context.handle(_categoryModelMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryModelDriftData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryModelDriftData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      categoryModel: $CategoryModelDriftTable.$convertercategoryModel.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}category_model'])!),
    );
  }

  @override
  $CategoryModelDriftTable createAlias(String alias) {
    return $CategoryModelDriftTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CategoryModel, String, String>
      $convertercategoryModel = const CategoryConverter();
}

class CategoryModelDriftData extends DataClass
    implements Insertable<CategoryModelDriftData> {
  final int id;
  final CategoryModel categoryModel;
  const CategoryModelDriftData({required this.id, required this.categoryModel});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['category_model'] = Variable<String>($CategoryModelDriftTable
          .$convertercategoryModel
          .toSql(categoryModel));
    }
    return map;
  }

  CategoryModelDriftCompanion toCompanion(bool nullToAbsent) {
    return CategoryModelDriftCompanion(
      id: Value(id),
      categoryModel: Value(categoryModel),
    );
  }

  factory CategoryModelDriftData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryModelDriftData(
      id: serializer.fromJson<int>(json['id']),
      categoryModel: $CategoryModelDriftTable.$convertercategoryModel
          .fromJson(serializer.fromJson<String>(json['categoryModel'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'categoryModel': serializer.toJson<String>($CategoryModelDriftTable
          .$convertercategoryModel
          .toJson(categoryModel)),
    };
  }

  CategoryModelDriftData copyWith({int? id, CategoryModel? categoryModel}) =>
      CategoryModelDriftData(
        id: id ?? this.id,
        categoryModel: categoryModel ?? this.categoryModel,
      );
  CategoryModelDriftData copyWithCompanion(CategoryModelDriftCompanion data) {
    return CategoryModelDriftData(
      id: data.id.present ? data.id.value : this.id,
      categoryModel: data.categoryModel.present
          ? data.categoryModel.value
          : this.categoryModel,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryModelDriftData(')
          ..write('id: $id, ')
          ..write('categoryModel: $categoryModel')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, categoryModel);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryModelDriftData &&
          other.id == this.id &&
          other.categoryModel == this.categoryModel);
}

class CategoryModelDriftCompanion
    extends UpdateCompanion<CategoryModelDriftData> {
  final Value<int> id;
  final Value<CategoryModel> categoryModel;
  const CategoryModelDriftCompanion({
    this.id = const Value.absent(),
    this.categoryModel = const Value.absent(),
  });
  CategoryModelDriftCompanion.insert({
    this.id = const Value.absent(),
    required CategoryModel categoryModel,
  }) : categoryModel = Value(categoryModel);
  static Insertable<CategoryModelDriftData> custom({
    Expression<int>? id,
    Expression<String>? categoryModel,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryModel != null) 'category_model': categoryModel,
    });
  }

  CategoryModelDriftCompanion copyWith(
      {Value<int>? id, Value<CategoryModel>? categoryModel}) {
    return CategoryModelDriftCompanion(
      id: id ?? this.id,
      categoryModel: categoryModel ?? this.categoryModel,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryModel.present) {
      map['category_model'] = Variable<String>($CategoryModelDriftTable
          .$convertercategoryModel
          .toSql(categoryModel.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryModelDriftCompanion(')
          ..write('id: $id, ')
          ..write('categoryModel: $categoryModel')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TransactionModelDriftTable transactionModelDrift =
      $TransactionModelDriftTable(this);
  late final $CategoryModelDriftTable categoryModelDrift =
      $CategoryModelDriftTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [transactionModelDrift, categoryModelDrift];
}

typedef $$TransactionModelDriftTableCreateCompanionBuilder
    = TransactionModelDriftCompanion Function({
  Value<int> id,
  required String dateAndTime,
  required int amount,
  Value<String?> note,
  required CategoryModel categoryModel,
});
typedef $$TransactionModelDriftTableUpdateCompanionBuilder
    = TransactionModelDriftCompanion Function({
  Value<int> id,
  Value<String> dateAndTime,
  Value<int> amount,
  Value<String?> note,
  Value<CategoryModel> categoryModel,
});

class $$TransactionModelDriftTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionModelDriftTable> {
  $$TransactionModelDriftTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dateAndTime => $composableBuilder(
      column: $table.dateAndTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<CategoryModel, CategoryModel, String>
      get categoryModel => $composableBuilder(
          column: $table.categoryModel,
          builder: (column) => ColumnWithTypeConverterFilters(column));
}

class $$TransactionModelDriftTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionModelDriftTable> {
  $$TransactionModelDriftTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dateAndTime => $composableBuilder(
      column: $table.dateAndTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get categoryModel => $composableBuilder(
      column: $table.categoryModel,
      builder: (column) => ColumnOrderings(column));
}

class $$TransactionModelDriftTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionModelDriftTable> {
  $$TransactionModelDriftTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get dateAndTime => $composableBuilder(
      column: $table.dateAndTime, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CategoryModel, String> get categoryModel =>
      $composableBuilder(
          column: $table.categoryModel, builder: (column) => column);
}

class $$TransactionModelDriftTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TransactionModelDriftTable,
    TransactionModelDriftData,
    $$TransactionModelDriftTableFilterComposer,
    $$TransactionModelDriftTableOrderingComposer,
    $$TransactionModelDriftTableAnnotationComposer,
    $$TransactionModelDriftTableCreateCompanionBuilder,
    $$TransactionModelDriftTableUpdateCompanionBuilder,
    (
      TransactionModelDriftData,
      BaseReferences<_$AppDatabase, $TransactionModelDriftTable,
          TransactionModelDriftData>
    ),
    TransactionModelDriftData,
    PrefetchHooks Function()> {
  $$TransactionModelDriftTableTableManager(
      _$AppDatabase db, $TransactionModelDriftTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionModelDriftTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionModelDriftTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionModelDriftTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> dateAndTime = const Value.absent(),
            Value<int> amount = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<CategoryModel> categoryModel = const Value.absent(),
          }) =>
              TransactionModelDriftCompanion(
            id: id,
            dateAndTime: dateAndTime,
            amount: amount,
            note: note,
            categoryModel: categoryModel,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String dateAndTime,
            required int amount,
            Value<String?> note = const Value.absent(),
            required CategoryModel categoryModel,
          }) =>
              TransactionModelDriftCompanion.insert(
            id: id,
            dateAndTime: dateAndTime,
            amount: amount,
            note: note,
            categoryModel: categoryModel,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TransactionModelDriftTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $TransactionModelDriftTable,
        TransactionModelDriftData,
        $$TransactionModelDriftTableFilterComposer,
        $$TransactionModelDriftTableOrderingComposer,
        $$TransactionModelDriftTableAnnotationComposer,
        $$TransactionModelDriftTableCreateCompanionBuilder,
        $$TransactionModelDriftTableUpdateCompanionBuilder,
        (
          TransactionModelDriftData,
          BaseReferences<_$AppDatabase, $TransactionModelDriftTable,
              TransactionModelDriftData>
        ),
        TransactionModelDriftData,
        PrefetchHooks Function()>;
typedef $$CategoryModelDriftTableCreateCompanionBuilder
    = CategoryModelDriftCompanion Function({
  Value<int> id,
  required CategoryModel categoryModel,
});
typedef $$CategoryModelDriftTableUpdateCompanionBuilder
    = CategoryModelDriftCompanion Function({
  Value<int> id,
  Value<CategoryModel> categoryModel,
});

class $$CategoryModelDriftTableFilterComposer
    extends Composer<_$AppDatabase, $CategoryModelDriftTable> {
  $$CategoryModelDriftTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<CategoryModel, CategoryModel, String>
      get categoryModel => $composableBuilder(
          column: $table.categoryModel,
          builder: (column) => ColumnWithTypeConverterFilters(column));
}

class $$CategoryModelDriftTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoryModelDriftTable> {
  $$CategoryModelDriftTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get categoryModel => $composableBuilder(
      column: $table.categoryModel,
      builder: (column) => ColumnOrderings(column));
}

class $$CategoryModelDriftTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoryModelDriftTable> {
  $$CategoryModelDriftTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CategoryModel, String> get categoryModel =>
      $composableBuilder(
          column: $table.categoryModel, builder: (column) => column);
}

class $$CategoryModelDriftTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CategoryModelDriftTable,
    CategoryModelDriftData,
    $$CategoryModelDriftTableFilterComposer,
    $$CategoryModelDriftTableOrderingComposer,
    $$CategoryModelDriftTableAnnotationComposer,
    $$CategoryModelDriftTableCreateCompanionBuilder,
    $$CategoryModelDriftTableUpdateCompanionBuilder,
    (
      CategoryModelDriftData,
      BaseReferences<_$AppDatabase, $CategoryModelDriftTable,
          CategoryModelDriftData>
    ),
    CategoryModelDriftData,
    PrefetchHooks Function()> {
  $$CategoryModelDriftTableTableManager(
      _$AppDatabase db, $CategoryModelDriftTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoryModelDriftTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoryModelDriftTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoryModelDriftTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<CategoryModel> categoryModel = const Value.absent(),
          }) =>
              CategoryModelDriftCompanion(
            id: id,
            categoryModel: categoryModel,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required CategoryModel categoryModel,
          }) =>
              CategoryModelDriftCompanion.insert(
            id: id,
            categoryModel: categoryModel,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CategoryModelDriftTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CategoryModelDriftTable,
    CategoryModelDriftData,
    $$CategoryModelDriftTableFilterComposer,
    $$CategoryModelDriftTableOrderingComposer,
    $$CategoryModelDriftTableAnnotationComposer,
    $$CategoryModelDriftTableCreateCompanionBuilder,
    $$CategoryModelDriftTableUpdateCompanionBuilder,
    (
      CategoryModelDriftData,
      BaseReferences<_$AppDatabase, $CategoryModelDriftTable,
          CategoryModelDriftData>
    ),
    CategoryModelDriftData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TransactionModelDriftTableTableManager get transactionModelDrift =>
      $$TransactionModelDriftTableTableManager(_db, _db.transactionModelDrift);
  $$CategoryModelDriftTableTableManager get categoryModelDrift =>
      $$CategoryModelDriftTableTableManager(_db, _db.categoryModelDrift);
}
