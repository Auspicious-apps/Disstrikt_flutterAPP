/*
<!--
       
  ~ @author     :Puneet Kumar
  ~ All Rights Reserved.
  ~ Proprietary and confidential :  All information contained herein is, and remains
 
  ~ Unauthorized copying of this file, via any medium is strictly prohibited.
  ~
  -->
 */

export 'dart:async';
export 'dart:convert';
export 'dart:io';

export 'package:device_info_plus/device_info_plus.dart';
/*============================================ third parties libraries ====================================*/


export 'package:flutter/cupertino.dart' hide RefreshCallback;
export 'package:flutter/foundation.dart';
/* =============================================dart, flutter and getx =====================================*/

export 'package:flutter/gestures.dart';
export 'package:flutter/material.dart' hide DatePickerTheme;
export 'package:flutter/material.dart';
export 'package:flutter/services.dart';


/*================================================== application binding =====================================*/

export 'package:disstrikt/app/bindings/initial_binding.dart';
export 'package:disstrikt/app/bindings/local_source_bindings.dart';
export 'package:disstrikt/app/bindings/repository_bindings.dart';
/*=============================================== base exports =============================================*/

export 'package:disstrikt/app/core/base/base_view.dart';
export 'package:disstrikt/app/core/base/page_state.dart';

export 'package:disstrikt/app/core/values/app_assets.dart';
export 'package:disstrikt/app/core/values/app_colors.dart';
export 'package:disstrikt/app/core/values/app_global_values.dart';
export 'package:disstrikt/app/core/values/app_strings.dart';

export 'package:disstrikt/app/core/values/app_values.dart';
export 'package:disstrikt/app/core/widget/asset_image.dart';
export 'package:disstrikt/app/core/widget/button_widget.dart';
/* ================================================app constants ===========================================*/

export 'package:disstrikt/app/core/values/app_arguments.dart';
export 'package:disstrikt/app/core/values/app_text_styles.dart';


/*=================================================== widgets =============================================*/

export 'package:disstrikt/app/core/widget/edit_text_widget.dart';



export 'package:disstrikt/app/core/widget/read_more_widget.dart';
export 'package:disstrikt/app/core/widget/square_percent_indicator.dart';
export 'package:disstrikt/app/core/widget/text_view.dart';




/*==================================================== local services =====================================*/



/*============================================== application controllers =====================================*/



/* ==================================================app routes ===========================================*/

export 'package:disstrikt/app/routes/app_pages.dart';
export 'package:disstrikt/app/routes/app_routes.dart';
export 'package:disstrikt/main.dart';
/*============================================== application screens =====================================*/

export 'package:get/get.dart'
    hide Response, HeaderValue, MultipartFile, FormData;
export 'package:get/instance_manager.dart';

