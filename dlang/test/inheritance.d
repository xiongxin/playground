module inheritance;

import std.stdio;
import std.string;
import std.random;

class Clock {
  int hour;
  int minute;
  int second;

  void adjust(int hour, int minute, int second = 0) {
    this.hour = hour;
    this.minute = minute;
    this.second = second;
  }

  void reset() {
    hour = 0;
    minute = 0;
    second = 0;
  }

  override string toString() const {
    return format("%02s:%02s:%02s", hour, minute, second);
  }
}

class AlarmClock : Clock {
  int alarmHour;
  int alarmMinute;

  void adjustAlarm(int hour, int minute) {
    this.hour = hour;
    this.minute = minute;
  }

  override void reset() {
    super.reset();
    alarmHour = 0;
    alarmMinute = 0;
  }

  override string toString() const {
    return format("%s ♫%02s:%02s", super.toString(),
      alarmHour, alarmMinute);
  }
}

class BrokenClock : Clock {
  this() {
    super(0, 0, 0);
  }

  override void reset() {
    hour = uniform(0, 24);
    minute = uniform(0, 60);
    second = uniform(0, 60);
  }
}

void main(string[] args) {
  Clock deskClock = new Clock;
  deskClock.adjust(20, 30);
  writeln(deskClock);

  AlarmClock bedSideClock = new AlarmClock;
  bedSideClock.adjust(20, 30);
  bedSideClock.adjustAlarm(7, 0);

  writeln(bedSideClock);
}
