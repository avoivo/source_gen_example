import 'package:build_runner/build_runner.dart';

import 'package:source_gen/source_gen.dart';
import 'package:source_gen_example/generators/json_serializable_generator2.dart';

final PhaseGroup phases = new PhaseGroup.singleAction(
    new GeneratorBuilder(const [const JsonSerializableGenerator2()]),
    new InputSet('source_gen_example', const ['lib/models/*.dart']));
