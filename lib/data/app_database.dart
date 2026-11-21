import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class Tareas extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get titulo => text().withLength(min: 1)();
  BoolColumn get completada => boolean().withDefault(const Constant(false))();
}

@DriftDatabase(tables: [Tareas])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  AppDatabase.defaults()
      : super(
          driftDatabase(
            name: 'tareas',
            web: DriftWebOptions(
              sqlite3Wasm: Uri.parse('sqlite3.wasm'),
              driftWorker: Uri.parse('drift_worker.js'),
            ),
          ),
        );

  @override
  int get schemaVersion => 1;

  Future<List<Tarea>> obtenerTareas() => select(tareas).get();

  Future<int> agregarTarea(String titulo) =>
      into(tareas).insert(TareasCompanion.insert(titulo: titulo));

  Future<int> cambiarEstado(int id, bool completada) =>
    (update(tareas)..where((t) => t.id.equals(id)))
        .write(TareasCompanion(completada: Value(completada)));

  Future<int> eliminarTarea(int id) =>
    (delete(tareas)..where((t) => t.id.equals(id))).go();

  Future<int> editarTitulo(int id, String titulo) =>
    (update(tareas)..where((t) => t.id.equals(id)))
      .write(TareasCompanion(titulo: Value(titulo)));
}