echo "Build...."
docker build -t fastapi-py37-mem-leak-test py3.7 >/dev/null 2>&1
docker build -t fastapi-py38-mem-leak-test py3.8 >/dev/null 2>&1
docker build -t fastapi-py37-async-mem-leak-test py3.7-async >/dev/null 2>&1
docker build -t fastapi-py38-async-mem-leak-test py3.8-async >/dev/null 2>&1
echo "Start Server...."
docker run --name fastapi-py37 -d fastapi-py37-mem-leak-test >/dev/null 2>&1
docker run --name fastapi-py38 -d fastapi-py38-mem-leak-test >/dev/null 2>&1
docker run --name fastapi-py37-async -d fastapi-py37-async-mem-leak-test >/dev/null 2>&1
docker run --name fastapi-py38-async -d fastapi-py38-async-mem-leak-test >/dev/null 2>&1
echo "Initial Mem Usage"
echo "=========================================="
docker stats fastapi-py37 fastapi-py38 fastapi-py37-async fastapi-py38-async --no-stream --format "{{.Name}}: {{.MemUsage}}"
echo "=========================================="
echo "Run 1000 Requests...."
echo "Run fastapi-py37"
docker exec -it fastapi-py37 bash -c "export TIMEFORMAT='real: %3lR; user %3lU; system %3lS' && time (for run in {1..1000}; do curl 127.0.0.1>/dev/null 2>&1; done)"
echo "Run fastapi-py38"
docker exec -it fastapi-py38 bash -c "export TIMEFORMAT='real: %3lR; user %3lU; system %3lS' && time (for run in {1..1000}; do curl 127.0.0.1>/dev/null 2>&1; done)"
echo "Run fastapi-py37-async"
docker exec -it fastapi-py37-async bash -c "export TIMEFORMAT='real: %3lR; user %3lU; system %3lS' && time (for run in {1..1000}; do curl 127.0.0.1>/dev/null 2>&1; done)"
echo "Run fastapi-py38-async"
docker exec -it fastapi-py38-async bash -c "export TIMEFORMAT='real: %3lR; user %3lU; system %3lS' && time (for run in {1..1000}; do curl 127.0.0.1>/dev/null 2>&1; done)"
echo "After 1000 Requests Mem Usage"
echo "=========================================="
docker stats fastapi-py37 fastapi-py38 fastapi-py37-async fastapi-py38-async --no-stream --format "{{.Name}}: {{.MemUsage}}"
echo "=========================================="
echo "Cleanup...."
docker stop fastapi-py37 fastapi-py38 fastapi-py37-async fastapi-py38-async >/dev/null 2>&1
docker rm fastapi-py37 fastapi-py38 fastapi-py37-async fastapi-py38-async >/dev/null 2>&1