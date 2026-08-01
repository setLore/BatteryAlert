import subprocess,time

def sendNotification(content):
    subprocess.run(['notify-send', str(content)])

while True:
    current_percentage = int(open('/sys/class/power_supply/BAT0/capacity').read())
    isCharging = open('/sys/class/power_supply/BAT0/status').read()
    if isCharging == "Charging\n": 
        if current_percentage < 99:
            time.sleep(5)
            pass
        elif current_percentage >= 99:
            sendNotification(f"Battery is at {current_percentage}%, disconnect charger!")
            print('sent notification')
            time.sleep(150)
        else:
            print("3")
            time.sleep(5)
            pass
    elif isCharging == "Not charging\n":
        pass
    else:
        print("4")
        time.sleep(5)
        pass