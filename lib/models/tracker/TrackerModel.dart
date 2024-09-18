class TrackerModel {
  TrackerModel({
      Overview? overview, 
      dynamic healthExpected, 
      HealthMonitoring? healthMonitoring,}){
    _overview = overview;
    _healthExpected = healthExpected;
    _healthMonitoring = healthMonitoring;
}

  TrackerModel.fromJson(dynamic json) {
    _overview = json['overview'] != null ? Overview.fromJson(json['overview']) : null;
    _healthExpected = json['healthExpected'];
    _healthMonitoring = json['healthMonitoring'] != null ? HealthMonitoring.fromJson(json['healthMonitoring']) : null;
  }
  Overview? _overview;
  dynamic _healthExpected;
  HealthMonitoring? _healthMonitoring;

  Overview? get overview => _overview;
  dynamic get healthExpected => _healthExpected;
  HealthMonitoring? get healthMonitoring => _healthMonitoring;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_overview != null) {
      map['overview'] = _overview?.toJson();
    }
    map['healthExpected'] = _healthExpected;
    if (_healthMonitoring != null) {
      map['healthMonitoring'] = _healthMonitoring?.toJson();
    }
    return map;
  }

}

class HealthMonitoring {
  HealthMonitoring({
      String? id, 
      String? userId, 
      List<MonthlyMonitoring>? monthlyMonitoring, 
      List<WeeklyMonitoring>? weeklyMonitoring, 
      List<DailyMonitoring>? dailyMonitoring,}){
    _id = id;
    _userId = userId;
    _monthlyMonitoring = monthlyMonitoring;
    _weeklyMonitoring = weeklyMonitoring;
    _dailyMonitoring = dailyMonitoring;
}

  HealthMonitoring.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['userId'];
    if (json['monthly_monitoring'] != null) {
      _monthlyMonitoring = [];
      json['monthly_monitoring'].forEach((v) {
        _monthlyMonitoring?.add(MonthlyMonitoring.fromJson(v));
      });
    }
    if (json['weekly_monitoring'] != null) {
      _weeklyMonitoring = [];
      json['weekly_monitoring'].forEach((v) {
        _weeklyMonitoring?.add(WeeklyMonitoring.fromJson(v));
      });
    }
    if (json['daily_monitoring'] != null) {
      _dailyMonitoring = [];
      json['daily_monitoring'].forEach((v) {
        _dailyMonitoring?.add(DailyMonitoring.fromJson(v));
      });
    }
  }
  String? _id;
  String? _userId;
  List<MonthlyMonitoring>? _monthlyMonitoring;
  List<WeeklyMonitoring>? _weeklyMonitoring;
  List<DailyMonitoring>? _dailyMonitoring;

  String? get id => _id;
  String? get userId => _userId;
  List<MonthlyMonitoring>? get monthlyMonitoring => _monthlyMonitoring;
  List<WeeklyMonitoring>? get weeklyMonitoring => _weeklyMonitoring;
  List<DailyMonitoring>? get dailyMonitoring => _dailyMonitoring;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userId'] = _userId;
    if (_monthlyMonitoring != null) {
      map['monthly_monitoring'] = _monthlyMonitoring?.map((v) => v.toJson()).toList();
    }
    if (_weeklyMonitoring != null) {
      map['weekly_monitoring'] = _weeklyMonitoring?.map((v) => v.toJson()).toList();
    }
    if (_dailyMonitoring != null) {
      map['daily_monitoring'] = _dailyMonitoring?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class DailyMonitoring {
  DailyMonitoring({
      String? day, 
      num? pulse, 
      num? temperature, 
      num? stressLevel, 
      num? caloriesBurned,}){
    _day = day;
    _pulse = pulse;
    _temperature = temperature;
    _stressLevel = stressLevel;
    _caloriesBurned = caloriesBurned;
}

  DailyMonitoring.fromJson(dynamic json) {
    _day = json['day'];
    _pulse = json['pulse'];
    _temperature = json['temperature'];
    _stressLevel = json['stress_level'];
    _caloriesBurned = json['calories_burned'];
  }
  String? _day;
  num? _pulse;
  num? _temperature;
  num? _stressLevel;
  num? _caloriesBurned;

  String? get day => _day;
  num? get pulse => _pulse;
  num? get temperature => _temperature;
  num? get stressLevel => _stressLevel;
  num? get caloriesBurned => _caloriesBurned;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = _day;
    map['pulse'] = _pulse;
    map['temperature'] = _temperature;
    map['stress_level'] = _stressLevel;
    map['calories_burned'] = _caloriesBurned;
    return map;
  }

}

class WeeklyMonitoring {
  WeeklyMonitoring({
      String? week, 
      num? pulse, 
      num? temperature, 
      num? stressLevel, 
      num? caloriesBurned,}){
    _week = week;
    _pulse = pulse;
    _temperature = temperature;
    _stressLevel = stressLevel;
    _caloriesBurned = caloriesBurned;
}

  WeeklyMonitoring.fromJson(dynamic json) {
    _week = json['week'];
    _pulse = json['pulse'];
    _temperature = json['temperature'];
    _stressLevel = json['stress_level'];
    _caloriesBurned = json['calories_burned'];
  }
  String? _week;
  num? _pulse;
  num? _temperature;
  num? _stressLevel;
  num? _caloriesBurned;

  String? get week => _week;
  num? get pulse => _pulse;
  num? get temperature => _temperature;
  num? get stressLevel => _stressLevel;
  num? get caloriesBurned => _caloriesBurned;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['week'] = _week;
    map['pulse'] = _pulse;
    map['temperature'] = _temperature;
    map['stress_level'] = _stressLevel;
    map['calories_burned'] = _caloriesBurned;
    return map;
  }

}

class MonthlyMonitoring {
  MonthlyMonitoring({
      String? month, 
      num? pulse, 
      num? temperature, 
      num? stressLevel, 
      num? caloriesBurned,}){
    _month = month;
    _pulse = pulse;
    _temperature = temperature;
    _stressLevel = stressLevel;
    _caloriesBurned = caloriesBurned;
}

  MonthlyMonitoring.fromJson(dynamic json) {
    _month = json['month'];
    _pulse = json['pulse'];
    _temperature = json['temperature'];
    _stressLevel = json['stress_level'];
    _caloriesBurned = json['calories_burned'];
  }
  String? _month;
  num? _pulse;
  num? _temperature;
  num? _stressLevel;
  num? _caloriesBurned;

  String? get month => _month;
  num? get pulse => _pulse;
  num? get temperature => _temperature;
  num? get stressLevel => _stressLevel;
  num? get caloriesBurned => _caloriesBurned;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['month'] = _month;
    map['pulse'] = _pulse;
    map['temperature'] = _temperature;
    map['stress_level'] = _stressLevel;
    map['calories_burned'] = _caloriesBurned;
    return map;
  }

}

class Overview {
  Overview({
      String? id, 
      String? userId, 
      List<Report>? report,}){
    _id = id;
    _userId = userId;
    _report = report;
}

  Overview.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['userId'];
    if (json['report'] != null) {
      _report = [];
      json['report'].forEach((v) {
        _report?.add(Report.fromJson(v));
      });
    }
  }
  String? _id;
  String? _userId;
  List<Report>? _report;

  String? get id => _id;
  String? get userId => _userId;
  List<Report>? get report => _report;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userId'] = _userId;
    if (_report != null) {
      map['report'] = _report?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Report {
  Report({
      String? week, 
      num? prevMonth, 
      num? thisMonth,}){
    _week = week;
    _prevMonth = prevMonth;
    _thisMonth = thisMonth;
}

  Report.fromJson(dynamic json) {
    _week = json['week'];
    _prevMonth = json['prev_month'];
    _thisMonth = json['this_month'];
  }
  String? _week;
  num? _prevMonth;
  num? _thisMonth;

  String? get week => _week;
  num? get prevMonth => _prevMonth;
  num? get thisMonth => _thisMonth;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['week'] = _week;
    map['prev_month'] = _prevMonth;
    map['this_month'] = _thisMonth;
    return map;
  }

}