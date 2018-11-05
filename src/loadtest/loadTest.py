https://github.com/reorx/httpstat
https://www.pythoncentral.io/how-to-create-a-thread-in-python/


from multiprocessing.dummy import Pool as ThreadPool

def squareNumber(n):
    return n ** 2

# function to be mapped over
def calculateParallel(numbers, threads=2):
    pool = ThreadPool(threads)
    results = pool.map(squareNumber, numbers)
    pool.close()
    pool.join()
    return results

if __name__ == "__main__":
    numbers = [1, 2, 3, 4, 5]
    squaredNumbers = calculateParallel(numbers, 4)
    for n in squaredNumbers:
        print(n)



======================================
from threading import Thread
from time import sleep

def threaded_function(arg):-----------------
    for i in range(arg):
        print "running"
        sleep(1)


if __name__ == "__main__":
    thread = Thread(target = threaded_function, args = (10, ))
    thread.start()
    thread.join()
    print "thread finished...exiting"