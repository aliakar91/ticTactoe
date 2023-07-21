import 'package:flutter/material.dart';
import 'package:party_proje_deneme/app/globals/styles/app_text_styles.dart';

class SandikSayiBilgileri extends StatelessWidget {
  const SandikSayiBilgileri({
    required this.sandikNo,
    required this.sehirIsmi,
    required this.secmenSayisi,
    required this.sayilanOy,
    required this.gecerliOy,
    required this.gecersizOy,
    required this.kullanilmayanOy,
    Key? key,
  }) : super(key: key);
  final String sandikNo;
  final String sehirIsmi;
  final String secmenSayisi;
  final String sayilanOy;
  final String gecerliOy;
  final String gecersizOy;
  final String kullanilmayanOy;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text(
                  "Sandık: ",
                  style: AppTextStyle.voteAndVoterText,
                ),
                Text(
                  sandikNo,
                  style: AppTextStyle.voteAndVoterNumber,
                ),
              ],
            ),
            Text(
              sehirIsmi,
              style: AppTextStyle.voteAndVoterText,
            ),
          ],
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: secmenSayisi,
                      style: AppTextStyle.voteAndVoterNumber,
                    ),
                    const TextSpan(
                      text: ' Seçmen Sayısı',
                      style: AppTextStyle.voteAndVoterText,
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: sayilanOy,
                      style: AppTextStyle.voteAndVoterNumber,
                    ),
                    const TextSpan(
                      text: ' Sayılan Oy',
                      style: AppTextStyle.voteAndVoterText,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: gecerliOy,
                    style: AppTextStyle.voteAndVoterNumber,
                  ),
                  const TextSpan(
                    text: ' Geçerli Oy',
                    style: AppTextStyle.voteAndVoterText,
                  ),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: gecersizOy,
                    style: AppTextStyle.voteAndVoterNumber,
                  ),
                  const TextSpan(
                    text: ' Geçersiz Oy',
                    style: AppTextStyle.voteAndVoterText,
                  ),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: kullanilmayanOy,
                    style: AppTextStyle.voteAndVoterNumber,
                  ),
                  const TextSpan(
                    text: ' Kullanılmayan Oy',
                    style: AppTextStyle.voteAndVoterText,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
