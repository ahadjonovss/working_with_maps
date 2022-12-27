import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_with_maps/ui/map/map_page.dart';
import 'package:working_with_maps/view_model/splash_view_model.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<SplashViewModel>(
          builder: (context, value, child) {
            if(value.latLong!=null){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>MapScreen()));
            }
            return FlutterLogo(size: 20,);
          },
          ),
      ),
    );
  }
}
