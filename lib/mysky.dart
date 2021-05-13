import 'package:simple_observable/simple_observable.dart';
import 'package:skynet/skynet.dart';

class MySkyService {
  final mySky = MySky();

  final profileDAC = ProfileDAC();

  final feedDAC = FeedDAC();
  // final socialDAC = SocialDAC();

  final isLoggedIn = Observable<bool>(initialValue: null);

  String userId;
  final String dataDomain = 'skymessage-dac.hns';
  // final String dataDomain = 'localhost';

  Future<void> init() async {
    print('init');
    print('DATA_DOMAIN $dataDomain');
    await mySky.load(
      dataDomain,
      portal: 'https://${SkynetConfig.host}/',
    );

    print('loaded MySky');

    await mySky.loadDACs([/* socialDAC */]);

    print('loaded DACs');

    while (true) {
      // print('check...');
      try {
        final loggedIn = await mySky.checkLogin();

        print('loggedIn $loggedIn');

        if (loggedIn) {
          userId = await mySky.userId();
          print('userId $userId');
        }

        isLoggedIn.setValue(loggedIn);
        break;
      } catch (e) {
        // print(e);
      }
      await Future.delayed(Duration(milliseconds: 200));
    }
  }

// Only do when checkLogin is false and user presses button
  Future<void> requestLoginAccess() async {
    final res = await mySky.requestLoginAccess();

    if (res == true) {
      userId = await mySky.userId();
      isLoggedIn.setValue(true);
    }
  }
}
