import 'dart:io';

String asset(String name) => File('test/assets/$name').readAsStringSync();