import 'package:flutter/material.dart';
import 'package:party_proje_deneme/app/data/models/candidate.dart';

class AdaylarSonuclarCardWidget extends StatelessWidget {
  final Candidate candidate;

  const AdaylarSonuclarCardWidget({required this.candidate, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              candidate.image != ""
                  ? CircleAvatar(
                      radius: 23,
                      backgroundImage: NetworkImage(candidate.image),
                    )
                  : const SizedBox(),
              Text(
                candidate.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              Text(
                candidate.type.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                ),
              ),
            ],
          ),
          const Divider(color: Colors.black,thickness: 0.1,),
        ],
      ),
    );
  }
}
