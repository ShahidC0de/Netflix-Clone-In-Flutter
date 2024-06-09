import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// ignore: non_constant_identifier_names
final API_key = dotenv.env['API_KEY'] ?? "";

String apiKey = API_key;
const Color kbackgroundColor = Color.fromRGBO(0, 0, 0, 1);
const imageUrl = "http://image.tmdb.org/t/p/w500/";
