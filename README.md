# gestor_tareas_local

Aplicación Flutter para administrar tareas con una base de datos SQLite local, sin servidor ni conexión a internet, diseñada para Android, iOS, Windows, Linux, macOS y web.

## Tecnología de persistencia

Para elegir la tecnología a utilizar se analizaron dos opciones: sqflite y drift con drift_flutter.

- sqflite no soporta web, y para Windows y Linux requiere paquetes adicionales.
- drift_flutter soporta las seis plataformas con el mismo código.

Por ello se optó por Drift + drift_flutter, ya que nos ahorra escribir código aparte para cada plataforma: con una sola llamada a driftDatabase(name: ...) la base de datos se abre en la ubicación adecuada de cada una. En web requiere los archivos sqlite3.wasm y drift_worker.js dentro de la carpeta web/.

## Diseño de la tabla

Posteriormente, para el diseño de la tabla se consultó la documentación existente y a partir de ahí se definió la siguiente estructura (tabla tareas):

 Columna    | Tipo      | Reglas |

id          | INTEGER   | PRIMARY KEY, se autoincrementa |
titulo      | TEXT      | NOT NULL; la app rechaza vacíos o solo espacios |
completada  | INTEGER   | 0 = pendiente, 1 = completada; DEFAULT 0 |

SQLite no tiene un tipo booleano, por lo que completada se guarda como entero (0/1). Drift lo maneja como bool en Dart.

## Cómo ejecutar

    flutter pub get
    flutter test
    flutter run -d chrome