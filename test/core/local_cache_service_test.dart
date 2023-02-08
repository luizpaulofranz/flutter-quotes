import 'package:flutter_test/flutter_test.dart';
import 'package:quotes/core/local_cache/local_cache_service_impl.dart';

void main() {
  final localCache = LocalCacheServiceImpl();

  setUp(() => localCache.clearCache());

  test('Check if local cache is correctly storing and clearing Data', () {
    final testMap = {'complex': 'object', 'under': 'test', 'dynamicType': 1};
    const testKey = 'myKey';
    localCache.setCacheData(key: testKey, value: testMap);
    expect(
        localCache.getCacheData<Map<String, dynamic>>(key: testKey), testMap);
    localCache.clearCache();
    expect(localCache.getCacheData<Map<String, dynamic>>(key: testKey), null);
  });
}
