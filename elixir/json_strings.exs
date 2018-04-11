defmodule Json_Strings do
  def good do
    ~s({"name": "Nooby McNooberson", "winPercent": null})
  end

  def glad do
    ~s({"name": "Mikhail Tal", "winPercent": 85.2})
  end

  def dead do
    ~s({"name": "Never McWonAGame", "winPercent": 0})
  end

  def sad do
    ~s({"name": "Nooby McNooberson", "winPercent": false})
  end

  def bad do
    ~s({"name": "Nooby McNooberson", 'winPercent': null})
  end

  def rad do
    ~s({"roo": "Nooby McNooberson", "rar": null, "raz": "Boom!"})
  end
end
