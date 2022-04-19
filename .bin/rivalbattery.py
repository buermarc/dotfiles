#!/usr/bin/env python3
from time import sleep
import rivalcfg

battery_level = ["", "", "", "", "", "", "", "", "", ""]
battery_level_charging = ["", "", "", "", "", "", "", "", "", ""]


def print_battery():
    with rivalcfg.get_first_mouse() as mouse:

        level: int = mouse.battery["level"]

        if mouse.battery["is_charging"]:
            icons = battery_level_charging
        else:
            icons = battery_level
        try:
            print(f"{level}% {icons[int(level/10)]}")
            exit(0)
        except Exception:
            print("鈴")
            exit(0)


try:
    print_battery()
except Exception:
    print("勒")
    sleep(5)
    try:
        print_battery()
    except Exception:
        print("")
