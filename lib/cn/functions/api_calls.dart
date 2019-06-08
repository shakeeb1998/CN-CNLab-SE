import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:on_day/SString.dart';
import 'package:shared_preferences/shared_preferences.dart';

void enterUserdata({@required String name,
  @required String email,
  @required String uid,
  @required String fcm_id}) {
  print('posting');
  Dio dio = new Dio();
  dio.options =
      BaseOptions(baseUrl: "http://3.210.82.253:8000/", connectTimeout: 10000);
  dio.post('cn/enterdata', data: {
    CnApis.uid: uid,
    CnApis.name: name,
    CnApis.email: email,
    CnApis.fcm_id: fcm_id,
  }).then((resp) {
//todo add method if fcm token updates


  print(fcm_id);
  Dio dio1 = new Dio();
  dio1.options =
      BaseOptions(baseUrl: "http://3.210.82.253:8000/", connectTimeout: 10000);

  dio.get("cn/updatefcm/?uid=${uid}&fcm=${fcm_id}");
    print('update');

    print(resp.data);
  });
}

void enterLocationdata(
    {@required SharedPreferences preferences, @required Position position}) {
  Geolocator()
      .placemarkFromCoordinates(position.latitude, position.longitude)
      .then((placemark) {
    DateTime date = DateTime.now();
//    print("weekday is ${date.weekday}");

        var place = placemark.first;
//        print(place.name);
        if(preferences.getString(LocationDataModel.place)==null)
          {
            preferences.setString(LocationDataModel.place,place.name);
            Dio dio = new Dio();

            dio.options =
                BaseOptions(baseUrl: "http://3.210.82.253:8000/", connectTimeout: 10000);

            dio.post('cn/enterlocationdata',data: {
              LocationDataModel.place:place.name,
              LocationDataModel.lon:position.longitude,
              LocationDataModel.lat:position.latitude,
              LocationDataModel.uid:preferences.getString(CnString.uid),
              LocationDataModel.day:date.weekday,
              LocationDataModel.month:date.month,
              LocationDataModel.date:date.toIso8601String(),
              LocationDataModel.time:date.hour            });
          }
          else
            {
              if(place.name!=preferences.getString(LocationDataModel.place))
                {
//                  print("hello");

                  preferences.setString(LocationDataModel.place,place.name);

                  Dio dio = new Dio();

                  dio.options =
                      BaseOptions(baseUrl: "http://3.210.82.253:8000/", connectTimeout: 10000);

                  dio.post('cn/enterlocationdata',data: {
                  LocationDataModel.place:place.name,
                    LocationDataModel.lon:position.longitude,
                    LocationDataModel.lat:position.latitude,
                    LocationDataModel.uid:preferences.getString(CnString.uid),
                    LocationDataModel.day:date.weekday,
                    LocationDataModel.month:date.month,
                    LocationDataModel.date:date.toIso8601String(),
                    LocationDataModel.time:date.hour


                  });
                }
            }

  }

  );
}

void addParent({String parentUid,String childUid})
{
  Dio dio = new Dio();

  print('here');
  dio.options =
      BaseOptions(baseUrl: "http://3.210.82.253:8000/", connectTimeout: 10000);
  dio.post('cn/addparent',data: {
    'parent':parentUid,
    'child':childUid
  });

}



