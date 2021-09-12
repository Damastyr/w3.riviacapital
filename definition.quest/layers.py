import os

file = open("layers.rivia_dojon.yml", "r")

lines = file.read().splitlines()

offsetX = -24
offsetY = 0
offsetZ = -10

with open('layers.rivia_dojon.yml', 'w') as u:
    u = u
with open('layers.rivia_dojon_new.yml', 'a') as the_file:
    for i in lines:
        line = i#.strip()
        if "pos: " in line:
            x = line[line.find("pos:")+6:line.find(",")]
            y = line[line.find(",")+2:line.rfind(",")]
            z = line[line.rfind(",")+2:line.rfind("]")]

            floatX = float(x) + offsetX
            floatY = float(y) + offsetY
            floatZ = float(z) + offsetZ

            the_file.write("        pos: [ " + str(floatX) + ", " + str(floatY) + ", " + str(floatZ) + " ]\n")
        else:
            the_file.write(line+"\n")
