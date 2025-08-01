from datetime import datetime, timedelta
now = datetime.now()

print(now.timestamp())

int_list = [0, 1, 2, 3, 4]

print(sum(int_list))

time_difference = now - timedelta(days=1)

print(time_difference)
