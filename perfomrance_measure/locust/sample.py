from locust import HttpLocust, TaskSet


def math(l):
    l.client.get("/math.php")

def sleep(l):
    l.client.get("/sleep.php")

class UserBehavior(TaskSet):
    tasks = {math: 1,sleep: 1}

class WebsiteUser(HttpLocust):
    task_set = UserBehavior
    min_wait = 5000
    max_wait = 9000 
