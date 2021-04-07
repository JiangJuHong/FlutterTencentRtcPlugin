import 'entity/video_enc_param_entity.dart';

class EntityFactory {
  static T? generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "VideoEncParamEntity") {
      return VideoEncParamEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}
