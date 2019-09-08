import 'package:rxdart/rxdart.dart';


class BLoC{
  BehaviorSubject<int> _growthSubj = BehaviorSubject<int>.seeded(185);
  BehaviorSubject<int> _weightSubj = BehaviorSubject<int>.seeded(95);
  BehaviorSubject<int> _ageSubj = BehaviorSubject<int>.seeded(50);
  BehaviorSubject<String> _resultSubj = BehaviorSubject<String>();

  Observable<String> get resultStream => _resultSubj.stream;
  Observable<int> sliderStream(String label){
    switch(label){
      case 'см': return _growthSubj.stream;
      case 'кг': return _weightSubj.stream;
      case 'лет': return _ageSubj.stream;
    }
  }

  changeValue(String label, int value){
    switch(label){
      case 'см': _growthSubj.add(value); break;
      case 'кг': _weightSubj.add(value); break;
      case 'лет': _ageSubj.add(value);
    }
    _resultSubj.add('');
  }

  result(){
    if(_growthSubj.value==null || _weightSubj.value==null || _ageSubj.value==null) return;
    int brocksFormula = _growthSubj.value - (_ageSubj.value<40 ? 110 : 100);
    String res = 'норма';
    if(_weightSubj.value < brocksFormula*0.9) res = 'недостаток';
    if(_weightSubj.value > brocksFormula*1.15) res = 'избыток';
    _resultSubj.add(res);
  }

  dispose(){
    _resultSubj.close();
    _growthSubj.close();
    _weightSubj.close();
    _ageSubj.close();
  }
}