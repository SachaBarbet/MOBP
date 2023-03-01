class DatabaseTable {
  final String tableName;
  final Map<String, dynamic> columns;
  const DatabaseTable(this.tableName, this.columns);

  Map<String, dynamic> toMap() {
    return columns;
  }

  @override
  String toString() {
    String line = '${tableName.substring(0, tableName.length - 2)}{';
    columns.forEach((key, value) {
      line += '$key: $value, ';
    });
    return '${line.substring(0, line.length - 3)}}';
  }
}