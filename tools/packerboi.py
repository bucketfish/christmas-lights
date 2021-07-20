#hell yea god. ok i'm gonna shower and come back soon
#finding size of image:
#- h/w (or vice versa) >= 2
#   - find some quick way to calculate this? lol. like 1/3 of something probably or find square root and get 2/3 of that round down
#- least number of blank spaces
#- PACK


import os
import sys
from PIL import Image
from math import floor, ceil, sqrt


def main():
    paths = os.listdir()
    paths.sort()
    try:
        paths.remove(".DS_Store")
    except:
        pass
    try:
        paths.remove("packerboi.py")
    except:
        pass
    images = [Image.open(x) for x in paths]
    print(paths)

    width, height = images[0].size

    count = len(images)
    startcount = ceil(2 * sqrt(count) / 3)
    endcount = ceil(sqrt(count) + startcount)

    bestwidth = floor(sqrt(count))
    bestblanks = bestwidth - (count%bestwidth)

    for i in range(startcount, endcount):
        curwidth = i
        curheight = ceil(count/i)
        if abs(curwidth - curheight) < bestblanks:
            bestwidth = i
            bestblanks = abs(curwidth - curheight)


    print(width)
    print(height)
    print()
    print(count)
    print(bestwidth)
    print(ceil(count/bestwidth))
    print(bestwidth - (count%bestwidth))
    print()

    bestheight = ceil(count/bestwidth)



    total_width = width * bestwidth
    total_height = height * bestheight

    #new_im = Image.new('RGBA', (total_width, total_height))

    new_im = Image.new('RGBA', (total_width, total_height))


    x_offset = 0
    y_offset = 0

    h = 0


    for i in range(0, bestheight):
        for j in range(0, bestwidth):
            print(h)
            new_im.paste(images[h], (x_offset, y_offset))
            x_offset += width
            h += 1
            if h >= len(images):
                new_im.save('test.png')
                return
            #print(str(x_offset) + ", " + str(y_offset))
        x_offset = 0
        y_offset += height


    new_im.save('test.png')


main()
