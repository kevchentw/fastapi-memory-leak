# Fastapi Memory Leak test

This is a simple test for fastapi memory leak on python3.7 and python3.8 using docker, which is discuss on https://github.com/tiangolo/fastapi/issues/596.

Thanks to @bestend for the sample code to reproduce memory leak.

## Usage

1. Install Docker
2. run `sh test.sh`

## Sample Output

```
Initial Mem Usage
==========================================
fastapi-py37: 76.21MiB / 7.353GiB
fastapi-py38: 75.86MiB / 7.353GiB
fastapi-py37-async: 75.44MiB / 7.353GiB
fastapi-py38-async: 75.62MiB / 7.353GiB
==========================================
Run 1000 Requests....
==========================================
Run fastapi-py37
real: 0m16.632s; user 0m4.748s; system 0m2.855s
Run fastapi-py38
real: 0m15.319s; user 0m4.750s; system 0m2.722s
Run fastapi-py37-async
real: 0m21.276s; user 0m4.877s; system 0m2.823s
Run fastapi-py38-async
real: 0m22.568s; user 0m5.218s; system 0m2.935s
==========================================
After 1000 Requests Mem Usage
==========================================
fastapi-py37: 1.266GiB / 7.353GiB
fastapi-py38: 144.8MiB / 7.353GiB
fastapi-py37-async: 84.07MiB / 7.353GiB
fastapi-py38-async: 83.63MiB / 7.353GiB
==========================================
```
