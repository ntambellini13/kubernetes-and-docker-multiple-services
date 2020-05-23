docker build -t ntambellini/multi-client:latest -t ntambellini/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ntambellini/multi-server:latest -t ntambellini/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ntambellini/multi-worker:latest -t ntambellini/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ntambellini/multi-client:latest
docker push ntambellini/multi-server:latest
docker push ntambellini/multi-worker:latest
docker push ntambellini/multi-client:$SHA
docker push ntambellini/multi-server:$SHA
docker push ntambellini/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ntambellini/multi-server:$SHA
kubectl set image deployments/client-deployment client=ntambellini/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ntambellini/multi-worker:$SHA


