# Fastapi Memory Leak test

This is a simple test for fastapi memory leak on python3.7 and python3.8 using docker, which is discuss on https://github.com/tiangolo/fastapi/issues/596.

Thanks to @bestend for the sample code to reproduce memory leak.

## Usage

1. Install Docker
2. run `sh test.sh`

## Sample Output

```
Build....
Start Server....
Initial Mem Usage
==========================================
fastapi-py37: 183.6MiB / 31.16GiB
fastapi-py38: 187.6MiB / 31.16GiB
==========================================
Run Requests....
After 1000 Requests Mem Usage
==========================================
fastapi-py37: 6.943GiB / 31.16GiB
fastapi-py38: 386.4MiB / 31.16GiB
==========================================
Cleanup....
```
