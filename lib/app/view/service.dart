import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:mokpos/app/view/file_utils.dart';

import '../../util/firebase/firebase.dart';

class Service {
  Future<String> uploadImage(Reference ref, File file) async {
    String ext = FileUtils.getFileExtension(file);
    Reference storageReference = ref.child("${uuid.v4()}.$ext");
    UploadTask uploadTask = storageReference.putFile(file);
    await uploadTask.whenComplete(() => null);
    String fileUrl = await storageReference.getDownloadURL();
    return fileUrl;
  }

  // Future<List<String>> uploadFiles(List<File>images)async{
  //   var imageUrls = await Future.wait(images.map((image) => uploadImage(posts, image)));
  //   print('====================> This is the URL $imageUrls');
  //   return imageUrls;
  // }
}
