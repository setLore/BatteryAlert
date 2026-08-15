import subprocess,time

def sendNotification(content):
    subprocess.run(['notify-send', '-e', 'BatteryAlert', str(content)])

while True:
    current_percentage = int(open('/sys/class/power_supply/BAT0/capacity').read())
    isCharging = open('/sys/class/power_supply/BAT0/status').read()
    if isCharging == "Charging\n": 
        if current_percentage < 99:
            print('percentage not high enough, passing.')
            time.sleep(5)
            pass
        elif current_percentage >= 99:
            sendNotification(f"Battery is at {current_percentage}%, disconnect charger!")
            print('sent notification')
            time.sleep(150)
        else:
            print("something's wrong")
            time.sleep(5)
            pass
    elif isCharging == "Not charging\n":
        print("not charging, passing.")
        time.sleep(5)
        pass
    else:
        print("not charging, passing.")
        time.sleep(5)
        pass