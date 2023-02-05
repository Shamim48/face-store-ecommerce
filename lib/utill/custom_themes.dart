import 'package:fakestore/utill/color_resources.dart';
import 'package:fakestore/utill/dimensions.dart';
import 'package:flutter/material.dart';

const ubuntuRegular = TextStyle(
  fontFamily: 'Ubuntu',
  fontSize: Dimensions.FONT_SIZE_SMALL,
);

const ubuntuHeader = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w600,
  fontSize: Dimensions.FONT_SIZE_LARGE,

);
const ubuntuSemiBold = TextStyle(
  fontFamily: 'Ubuntu',
  fontSize: Dimensions.FONT_SIZE_SMALL,
  fontWeight: FontWeight.w600,
);

const ubuntuBold = TextStyle(
  fontFamily: 'Ubuntu',
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
  fontWeight: FontWeight.w700,
);
const ubuntuItalic = TextStyle(
  fontFamily: 'Ubuntu',
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
  fontStyle: FontStyle.italic,
);

snackBar (String msg){
  return  SnackBar(
    content:  Text(msg,style: ubuntuRegular.copyWith(color: ColorResources.WHITE),),
    backgroundColor: ColorResources.COLOR_PRIMARY,
  );
}

