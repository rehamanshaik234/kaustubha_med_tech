class TrackerModel {
  TrackerModel({
    Tracks? tracks,
    Overview? overview,
    HealthExpected? healthExpected,
    HealthMonitoring? healthMonitoring,
  }) {
    _tracks = tracks;
    _overview = overview;
    _healthExpected = healthExpected;
    _healthMonitoring = healthMonitoring;
  }

  TrackerModel.fromJson(dynamic json) {
    _tracks = json['tracks'] != null ? Tracks.fromJson(json['tracks']) : null;
    _overview = json['overview'] != null ? Overview.fromJson(json['overview']) : null;
    _healthExpected = json['healthExpected'] != null
        ? HealthExpected.fromJson(json['healthExpected'])
        : null;
    _healthMonitoring = json['healthMonitoring'] != null
        ? HealthMonitoring.fromJson(json['healthMonitoring'])
        : null;
  }

  Tracks? _tracks;
  Overview? _overview;
  HealthExpected? _healthExpected;
  HealthMonitoring? _healthMonitoring;

  Tracks? get tracks => _tracks;
  Overview? get overview => _overview;
  HealthExpected? get healthExpected => _healthExpected;
  HealthMonitoring? get healthMonitoring => _healthMonitoring;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_tracks != null) {
      map['tracks'] = _tracks?.toJson();
    }
    if (_overview != null) {
      map['overview'] = _overview?.toJson();
    }
    if (_healthExpected != null) {
      map['healthExpected'] = _healthExpected?.toJson();
    }
    if (_healthMonitoring != null) {
      map['healthMonitoring'] = _healthMonitoring?.toJson();
    }
    return map;
  }
}

class Tracks {
  Tracks({
    String? id,
    String? userId,
    Activity? activity,
    Sleep? sleep,
    Wellness? wellness,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _userId = userId;
    _activity = activity;
    _sleep = sleep;
    _wellness = wellness;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Tracks.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['userId'];
    _activity = json['activity'] != null ? Activity.fromJson(json['activity']) : null;
    _sleep = json['sleep'] != null ? Sleep.fromJson(json['sleep']) : null;
    _wellness = json['wellness'] != null ? Wellness.fromJson(json['wellness']) : null;
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  String? _id;
  String? _userId;
  Activity? _activity;
  Sleep? _sleep;
  Wellness? _wellness;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;
  String? get userId => _userId;
  Activity? get activity => _activity;
  Sleep? get sleep => _sleep;
  Wellness? get wellness => _wellness;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userId'] = _userId;
    if (_activity != null) {
      map['activity'] = _activity?.toJson();
    }
    if (_sleep != null) {
      map['sleep'] = _sleep?.toJson();
    }
    if (_wellness != null) {
      map['wellness'] = _wellness?.toJson();
    }
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}

class Activity {
  Activity({num? daily, num? weekly, num? monthly}) {
    _daily = daily;
    _weekly = weekly;
    _monthly = monthly;
  }

  Activity.fromJson(dynamic json) {
    _daily = json['daily'];
    _weekly = json['weekly'];
    _monthly = json['monthly'];
  }

  num? _daily;
  num? _weekly;
  num? _monthly;

  num? get daily => _daily;
  num? get weekly => _weekly;
  num? get monthly => _monthly;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['daily'] = _daily;
    map['weekly'] = _weekly;
    map['monthly'] = _monthly;
    return map;
  }
}

class Sleep {
  Sleep({num? daily, num? weekly, num? monthly}) {
    _daily = daily;
    _weekly = weekly;
    _monthly = monthly;
  }

  Sleep.fromJson(dynamic json) {
    _daily = json['daily'];
    _weekly = json['weekly'];
    _monthly = json['monthly'];
  }

  num? _daily;
  num? _weekly;
  num? _monthly;

  num? get daily => _daily;
  num? get weekly => _weekly;
  num? get monthly => _monthly;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['daily'] = _daily;
    map['weekly'] = _weekly;
    map['monthly'] = _monthly;
    return map;
  }
}

class Wellness {
  Wellness({num? daily, num? weekly, num? monthly}) {
    _daily = daily;
    _weekly = weekly;
    _monthly = monthly;
  }

  Wellness.fromJson(dynamic json) {
    _daily = json['daily'];
    _weekly = json['weekly'];
    _monthly = json['monthly'];
  }

  num? _daily;
  num? _weekly;
  num? _monthly;

  num? get daily => _daily;
  num? get weekly => _weekly;
  num? get monthly => _monthly;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['daily'] = _daily;
    map['weekly'] = _weekly;
    map['monthly'] = _monthly;
    return map;
  }
}

class Overview {
  Overview({
    String? id,
    String? userId,
    List<Report>? report,
  }) {
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
    num? thisMonth,
  }) {
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

class HealthExpected {
  HealthExpected({
    String? id,
    String? userId,
    List<HealthReport>? report,
  }) {
    _id = id;
    _userId = userId;
    _report = report;
  }

  HealthExpected.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['userId'];
    if (json['report'] != null) {
      _report = [];
      json['report'].forEach((v) {
        _report?.add(HealthReport.fromJson(v));
      });
    }
  }

  String? _id;
  String? _userId;
  List<HealthReport>? _report;

  String? get id => _id;
  String? get userId => _userId;
  List<HealthReport>? get report => _report;

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

class HealthReport {
  HealthReport({
    String? month,
    num? health,
    num? expected,
  }) {
    _month = month;
    _health = health;
    _expected = expected;
  }

  HealthReport.fromJson(dynamic json) {
    _month = json['month'];
    _health = json['health'];
    _expected = json['expected'];
  }

  String? _month;
  num? _health;
  num? _expected;

  String? get month => _month;
  num? get health => _health;
  num? get expected => _expected;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['month'] = _month;
    map['health'] = _health;
    map['expected'] = _expected;
    return map;
  }
}

class HealthMonitoring {
  HealthMonitoring({
    String? id,
    String? userId,
    List<MonthlyMonitoring>? monthlyMonitoring,
    List<WeeklyMonitoring>? weeklyMonitoring,
    List<DailyMonitoring>? dailyMonitoring,
  }) {
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
      map['monthly_monitoring'] =
          _monthlyMonitoring?.map((v) => v.toJson()).toList();
    }
    if (_weeklyMonitoring != null) {
      map['weekly_monitoring'] =
          _weeklyMonitoring?.map((v) => v.toJson()).toList();
    }
    if (_dailyMonitoring != null) {
      map['daily_monitoring'] =
          _dailyMonitoring?.map((v) => v.toJson()).toList();
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
    num? caloriesBurned,
  }) {
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
    num? caloriesBurned,
  }) {
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
    num? caloriesBurned,
  }) {
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
