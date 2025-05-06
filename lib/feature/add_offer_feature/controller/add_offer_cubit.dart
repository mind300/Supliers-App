import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:supplies/feature/add_offer_feature/data/repo/add_offer_repo.dart';

part 'add_offer_state.dart';

class AddOfferCubit extends Cubit<AddOfferState> {
  AddOfferCubit(this.addOfferRepo) : super(AddOfferInitial());
  final AddOfferRepo addOfferRepo;
  final ImagePicker _picker = ImagePicker();
  List<XFile>? selectedImages = [];

  Future<void> pickMultipleImages() async {
    try {
      final List<XFile>? images = await _picker.pickMultiImage();
      if (images != null && images.isNotEmpty) {
        selectedImages = images;
        emit(AddOfferImagePicked());
      }
    } catch (e) {
      print("Error picking images: $e");
    }
  }
}
