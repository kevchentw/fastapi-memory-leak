echo "Build...."
docker build -t fastapi-py37-mem-leak-test py3.7 >/dev/null 2>&1
docker build -t fastapi-py38-mem-leak-test py3.8 >/dev/null 2>&1
echo "Start Server...."
docker run --name fastapi-py37 -d fastapi-py37-mem-leak-test >/dev/null 2>&1
docker run --name fastapi-py38 -d fastapi-py38-mem-leak-test >/dev/null 2>&1
echo "Initial Mem Usage"
echo "=========================================="
docker stats fastapi-py37 fastapi-py38 --no-stream --format "{{.Name}}: {{.MemUsage}}"
echo "=========================================="
echo "Run 1000 Requests...."
docker exec -it fastapi-py37 bash -c "for run in {1..1000}; do curl 127.0.0.1>/dev/null 2>&1; done"
docker exec -it fastapi-py38 bash -c "for run in {1..1000}; do curl 127.0.0.1>/dev/null 2>&1; done"
echo "After 1000 Requests Mem Usage"
echo "=========================================="
docker stats fastapi-py37 fastapi-py38 --no-stream --format "{{.Name}}: {{.MemUsage}}"
echo "=========================================="
echo "Cleanup...."
docker stop fastapi-py37 fastapi-py38 >/dev/null 2>&1
docker rm fastapi-py37 fastapi-py38 >/dev/null 2>&1