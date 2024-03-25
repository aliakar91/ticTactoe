import 'package:ak_sandik/app/data/models/ballot_box.dart';
import 'package:ak_sandik/app/data/providers/ballot_box_provider.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class BallotBoxRepository {
  final _ballotBoxProvider = MainProvider();

  Future<List<BallotBox>> getBallotBoxes() async {
    var response = await _ballotBoxProvider.getBallotBoxes();
    if (response.statusCode == HttpStatus.ok) {
      return response.body
          .map<BallotBox>((element) => BallotBox.fromJson(element))
          .toList();
    }
    return <BallotBox>[];
  }
}
