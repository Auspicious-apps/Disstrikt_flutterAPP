


/*
<!--
       
  ~ @author     :Puneet Kumar
  ~ All Rights Reserved.
  ~ Proprietary and confidential :  All information contained herein is, and remains
 
  ~ Unauthorized copying of this file, via any medium is strictly prohibited.
  ~
  -->
 */



import 'package:disstrikt/app/core/widget/elevated_container.dart';
import 'package:disstrikt/app/export.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: ElevatedContainer(
        padding: EdgeInsets.all(margin_20),
        child: const CircularProgressIndicator(
          color: AppColors.appColor,
        ),
      ),
    );
  }
}
