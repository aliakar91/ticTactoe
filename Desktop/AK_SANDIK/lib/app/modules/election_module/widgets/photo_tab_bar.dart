import 'package:ak_sandik/app/modules/election_module/election_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//ignore: must_be_immutable
class PhotoTabBar extends StatelessWidget {
  String text;
  String type;
  bool isIconActive;
  bool isSelected;
  final controller = Get.find<ElectionController>();

  PhotoTabBar({
    required this.text,
    required this.type,
    required this.isIconActive,
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final box = controller.linkedBallotBox.getBoxType(type);
    bool isPhotoExistOnApi = isIconActive || box.reportImage != null;
    return Container(
      color: isSelected && isPhotoExistOnApi
          ? Colors.blue
          : isPhotoExistOnApi
              ? Colors.green
              : null,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 9),
      child: Row(
        children: [
          isPhotoExistOnApi
              ? const Padding(
                  padding: EdgeInsets.only(right: 6.0, left: 2),
                  child: Icon(
                    FontAwesomeIcons.check,
                    size: 15,
                    color: Colors.white,
                  ),
                )
              : const SizedBox(),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
