// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_ai/firebase_ai.dart' as _i187;
import 'package:firebase_ai_friendly_meals/core/di/firebase_module.dart'
    as _i890;
import 'package:firebase_ai_friendly_meals/data/datasource/ai_remote_data_source.dart'
    as _i601;
import 'package:firebase_ai_friendly_meals/data/repository/ai_repository.dart'
    as _i2;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final firebaseModule = _$FirebaseModule();
    gh.singleton<_i187.GenerativeModel>(
      () => firebaseModule.provideGenerativeModel(),
    );
    gh.singleton<_i187.ImagenModel>(() => firebaseModule.provideImagenModel());
    gh.factory<_i601.AIRemoteDataSource>(
      () => _i601.AIRemoteDataSource(
        generativeModel: gh<_i187.GenerativeModel>(),
        imagenModel: gh<_i187.ImagenModel>(),
      ),
    );
    gh.factory<_i2.AIRepository>(
      () => _i2.AIRepository(gh<_i601.AIRemoteDataSource>()),
    );
    return this;
  }
}

class _$FirebaseModule extends _i890.FirebaseModule {}
