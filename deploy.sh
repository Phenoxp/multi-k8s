docker build -t phenoxp/multi-client:latest -t phenoxp/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t phenoxp/multi-server:latest -t phenoxp/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t phenoxp/multi-worker:latest -t phenoxp/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push phenoxp/multi-client:latest
docker push phenoxp/multi-server:latest
docker push phenoxp/multi-worker:latest

docker push phenoxp/multi-client:$SHA
docker push phenoxp/multi-server:$SHA
docker push phenoxp/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=phenoxp/multi-server:$SHA
kubectl set image deployments/client-deployment client=phenoxp/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=phenoxp/multi-worker:$SHA