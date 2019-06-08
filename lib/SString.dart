import 'package:flutter/material.dart';



class SString{
  SString._();
  static const String  cnlLablogin='Login';


}


class CnString{
  CnString._();
  static const String  email='email';
  static const String  name='name';
  static const String  number='number';
  static const String  photourl='photourl';
  static const String  uid='uid';
  static const String  home='Home';
  static const String  search='Search';
  static const String  fusercollectiom='user';
  static const String  frequests='request';
  static const String  requests='Request';
  static const String  ffrens='frens';
  static const String  noNotavailable='Number not available';
  static const String  loading='loading';
  static const String  lastKnownlocation='Last known Location';
  static const String  lat='lat';
  static const String  coordinates='Co Ordinates';

  static const String  lng='long';

  static const String  alerts='Alerts';

  static const String  distance='Distance';
  static const String restID='restID';

  static const String baseUrl='127.0.0.1:8000/';
  static const String enterdata='enterdata/';





}
class ModelResturants{
  ModelResturants._();
  static const String shortDescription='shortDescription';
  static const String deliveryTime="deliveryTime";
  static const String free='free';
  static const String image='image';
  static const String minOrder='minOrder';
  static const String name = 'name';
  static const String ownerEmail='ownerEmail';
  static const String cuisinesList='cuisinesList';
  static const String modelName='resturants';
  static const String deliveryCharges='subTotal';
  static const String cusines='cuisines';




}

class ModelFoodItem{
  ModelFoodItem._();
  static const String shortDescription='shortDescription';
  static const String image='image';
  static const String name = 'name';
  static const String modelName='FoodItem';
  static const String price='price';

}
class ModelCartItem{
  ModelCartItem._();
  static const String quantity='quantity';
  static const String name='name';
  static const String totalPrice='totalPrice';
  static const String pricePerunit='pricePerunit';
  static const String subTotal='subTotal';

}
class ModelOrderC{
  ModelOrderC._();
  static const String details='details';
  static const String restID='restID';
  static const String subTotal='subTotal';
  static const String s='s';
  static const String restName='restName';
  static const String orderID='orderID';


}

class Apis{
  Apis._();
  static const String baseUrl='https://cn-lab.herokuapp.com/';
  static const String student='student/';
  static const String teacher='teacher/';
  static const String classes='classes/';
  static const String class1='class/';

  static const String getStudentclass=baseUrl+student+classes;

static const getTeacherClass=baseUrl+teacher+classes;



}

class CnLab{
  static const String start='on_going';
  static const String muid='_id';


}

class CnApis{
  static const String id='id';
  static const String name="name";
  static const String email='email';
  static const String fcm_id='fcm_id';
  static const String uid="uid";

}
class LocationDataModel{
  static const place='place';
  static const lat='lat';
  static const lon='lon';
  static const uid='uid';
  static const parent_uid='parent_uid';
  static const day='day';
  static const time='time';
  static const month='month';
  static const date='date';


}
