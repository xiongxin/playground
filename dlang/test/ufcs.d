module ufcs;

import std.stdio;
import std.algorithm;

class Car {
  enum economy = 12.5;
  private double fuelAmount;

  this(double fuelAmount) {
    this.fuelAmount = fuelAmount;
  }

  double fuel() const {
    return fuelAmount;
  }
}

bool canTravel(Car car, double distance) {
  return (car.fuel() * car.economy) >= distance;
}

void main(string[] args) {
  auto car = new Car(5);
  auto remainingFuel = car.fuel();

  if (car.canTravel(100)) {
    //..
  }

  auto values = [1, 2, 3, 4, 5];

  writeln(values.map!(a => a * 10)
      .map!(a => a / 3)
      .filter!(a => !(a % 2)));
}
