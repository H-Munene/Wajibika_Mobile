//**IMAGES ASSETS CLASS BELOW *//

// provides unified access to images
class AppImages {
  // *NOTE*
  //images are 1500 * 1000
  //if image is unable to load, especially in web, try: ↓↓↓↓↓↓
  // static const String _imagesPath = 'images';
  static const String _imagesPath = 'assets/images';

  // TODO: create logo for app icon and splash screen, https://github.com/H-Munene/bloc_CleanArch/issues/13
  static const fullLogo = '$_imagesPath';
  static const blankProfilePicture = '$_imagesPath/no_profile_picture.jpg';
  static const cleanup = '$_imagesPath/cleanup.jpg';
  static const cleanup2 = '$_imagesPath/cleanup2.jpg';
  static const team = '$_imagesPath/team.jpg';
  static const clogged = '$_imagesPath/clogged.jpg';
  static const volunteer = '$_imagesPath/volunteer.jpg';
  static const bin = '$_imagesPath/bin.jpg';
  static const report = '$_imagesPath/report.jpg';
  static const neighbourhood = '$_imagesPath/neighbourhood.jpg';
}

//**VECTOR ASSETS CLASS BELOW *//

// provides unified access to svgs
class AppVectors {
  // *NOTE*
  //if svg is unable to load, especially in web, try: ↓↓↓↓↓↓
  // static const String _vectorsPath = 'vectors';

  static const String _vectorsPath = 'assets/vectors';
}
