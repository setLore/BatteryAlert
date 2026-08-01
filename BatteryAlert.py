import subprocess,time

current_percentage = int(open('/sys/class/power_supply/BAT0/capacity').read())

def sendNotification(content):
    subprocess.run(['notify-send', str(content)])

while True:
    if current_percentage > 99:
        sendNotification(f"Battery is at {current_percentage}%, disconnect charger!")
        print('sent notification')
        time.sleep(150)
    else:
        pass
        