import subprocess

SPEAKER_ICON = "墳"
HEADPHONE_ICON = "" 
BLUETOOTH_ICON = ""

default_sink = str(subprocess.check_output(["pactl", "get-default-sink"]))

if "bluez" in default_sink:
    print(BLUETOOTH_ICON)
elif "M-Audio" in default_sink:
    print(HEADPHONE_ICON)
else:
    print(SPEAKER_ICON)

