abstract class LocalCacheService {
  void setCacheData({required String key, required dynamic value});
  T? getCacheData<T>({required String key});
  void clearCache();
}

const quotesKey = 'quotes';
