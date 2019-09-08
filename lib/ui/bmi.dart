import 'package:flutter/material.dart';
import '../bloc/provider.dart';
import '../bloc/bloc.dart';
import 'slider.dart';


class BMI extends StatefulWidget {
  @override
  _BMIState createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  BLoC _bloc;

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BLoCProvider.of(context);
    return SafeArea(
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: <Widget>[
              CustomSlider('см', 150.0, 220.0),
              CustomSlider('кг', 40.0, 150.0),
              CustomSlider('лет', 20.0, 80.0),
              Expanded(
                child: Center(
                    child: StreamBuilder(
                      stream: _bloc.resultStream,
                      initialData: '',
                      builder: (context, snapshot){
                        return  Text(
                          snapshot.data,
                          style: Theme.of(context).textTheme.title,
                        );
                      },
                    )
                ),
              ),
              Center(
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(45.0)),
                    boxShadow: [BoxShadow(blurRadius: 5, color: Colors.white24)],
                  ),
                  child: InkWell(
                      onTap: () => _bloc.result(),
                      highlightColor: Colors.white54,
                      splashColor: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(45.0)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                        child: Text(
                          'Рассчитать',
                          style: Theme.of(context).textTheme.button,
                        ),
                      )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}