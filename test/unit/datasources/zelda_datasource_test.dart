import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'dart:convert';
import 'package:tarea_api_app/src/data/datasources/zelda_datasource.dart';

void main() {
  group('ZeldaDatasource Tests', () {
    test('should have correct base URL', () {
      final datasource = ZeldaDatasource();

      expect(datasource.baseUrl, 'https://zelda.fanapis.com/api/items');
    });

    test('fetchZeldaItems should return list of items on success', () async {
      final mockResponse = jsonEncode({
        'data': [
          {
            'id': 'master-sword',
            'name': 'Master Sword',
            'description': 'The legendary sword',
          },
          {
            'id': 'hylian-shield',
            'name': 'Hylian Shield',
            'description': 'A sturdy shield',
          },
        ]
      });

      final client = MockClient((request) async {
        return http.Response(mockResponse, 200);
      });

      final datasource = ZeldaDatasource(client: client);

      final items = await datasource.fetchZeldaItems(10);

      expect(items, hasLength(2));
      expect(items[0].id, 'master-sword');
      expect(items[0].name, 'Master Sword');
      expect(items[0].description, 'The legendary sword');
      expect(items[1].id, 'hylian-shield');
      expect(items[1].name, 'Hylian Shield');
    });

    test('fetchZeldaItems should throw exception on 404 error', () async {
      final client = MockClient((request) async {
        return http.Response('Not Found', 404);
      });

      final datasource = ZeldaDatasource(client: client);

      expect(
        () => datasource.fetchZeldaItems(10),
        throwsA(isA<Exception>()),
      );
    });

    test('fetchZeldaItems should throw exception on 500 error', () async {
      final client = MockClient((request) async {
        return http.Response('Server Error', 500);
      });

      final datasource = ZeldaDatasource(client: client);

      expect(
        () => datasource.fetchZeldaItems(10),
        throwsA(isA<Exception>()),
      );
    });

    test('fetchZeldaItems should include correct limit in URL', () async {
      Uri? capturedUrl;

      final client = MockClient((request) async {
        capturedUrl = request.url;
        return http.Response(
          jsonEncode({'data': []}),
          200,
        );
      });

      final datasource = ZeldaDatasource(client: client);

      await datasource.fetchZeldaItems(25);

      expect(capturedUrl.toString(), contains('limit=25'));
      expect(capturedUrl.toString(), contains('https://zelda.fanapis.com/api/items'));
    });

    test('fetchZeldaItems should handle empty data array', () async {
      final mockResponse = jsonEncode({'data': []});

      final client = MockClient((request) async {
        return http.Response(mockResponse, 200);
      });

      final datasource = ZeldaDatasource(client: client);

      final items = await datasource.fetchZeldaItems(10);

      expect(items, isEmpty);
    });

    test('fetchZeldaItems should parse special characters correctly', () async {
      final mockResponse = jsonEncode({
        'data': [
          {
            'id': 'test-id',
            'name': 'Ítem Especial™',
            'description': 'Descripción con ñ, á, é, í, ó, ú',
          },
        ]
      });

      final client = MockClient((request) async {
        return http.Response(mockResponse, 200, headers: {
          'content-type': 'application/json; charset=utf-8'
        });
      });

      final datasource = ZeldaDatasource(client: client);

      final items = await datasource.fetchZeldaItems(1);

      expect(items[0].name, 'Ítem Especial™');
      expect(items[0].description, contains('ñ'));
      expect(items[0].description, contains('á'));
    });

    test('fetchZeldaItems should handle large limit values', () async {
      Uri? capturedUrl;

      final client = MockClient((request) async {
        capturedUrl = request.url;
        return http.Response(
          jsonEncode({'data': []}),
          200,
        );
      });

      final datasource = ZeldaDatasource(client: client);

      await datasource.fetchZeldaItems(100);

      expect(capturedUrl.toString(), contains('limit=100'));
    });

    test('fetchZeldaItems should map all fields correctly', () async {
      final mockResponse = jsonEncode({
        'data': [
          {
            'id': 'complete-item',
            'name': 'Complete Item Name',
            'description': 'This is a complete description with all fields',
          },
        ]
      });

      final client = MockClient((request) async {
        return http.Response(mockResponse, 200);
      });

      final datasource = ZeldaDatasource(client: client);

      final items = await datasource.fetchZeldaItems(1);

      expect(items[0].id, isNotEmpty);
      expect(items[0].name, isNotEmpty);
      expect(items[0].description, isNotEmpty);
      expect(items[0].id, 'complete-item');
      expect(items[0].name, 'Complete Item Name');
      expect(items[0].description, contains('complete description'));
    });
  });
}