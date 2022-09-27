import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:PARTIU/screens/add_post_screen.dart';
import 'package:PARTIU/screens/feed_screen.dart';
import 'package:PARTIU/screens/profile_screen.dart';
import 'package:PARTIU/screens/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddEventoScreen(),
  const Text('notificações'),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
