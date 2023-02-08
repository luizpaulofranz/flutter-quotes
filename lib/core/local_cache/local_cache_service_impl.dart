import 'package:quotes/core/local_cache/local_cache_service.dart';

class LocalCacheServiceImpl implements LocalCacheService {
  ///
  static final Map<String, Object> _cacheData = {};

  @override
  void setCacheData({required String key, required dynamic value}) {
    _cacheData.addAll({key: value});
  }

  @override
  void clearCache() => _cacheData.clear();

  @override
  T? getCacheData<T>({required String key}) {
    if (_cacheData.containsKey(key) && _cacheData[key] is T) {
      return _cacheData[key] as T;
    }
    return null;
  }
}
