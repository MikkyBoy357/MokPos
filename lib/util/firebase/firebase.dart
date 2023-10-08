import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
// FirebaseStorage storage = FirebaseStorage.instance;
final Uuid uuid = Uuid();

// Collection refs
CollectionReference usersRef = firestore.collection('users');
CollectionReference customersRef = firestore.collection('customers');
CollectionReference postsRef = firestore.collection('posts');
CollectionReference followersRef = firestore.collection('followers');
CollectionReference followingRef = firestore.collection('following');
CollectionReference likesRef = firestore.collection('likes');
CollectionReference commentsRef = firestore.collection('comments');
CollectionReference notificationsRef = firestore.collection('notifications');
CollectionReference savedPostsRef = firestore.collection("savedPost");
CollectionReference journalRef = firestore.collection('journals');

// Storage refs
// Reference profilePic = storage.ref().child('profilePic');
// Reference journals = storage.ref().child('journals');
// Reference posts = storage.ref().child('posts');
