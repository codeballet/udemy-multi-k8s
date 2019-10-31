docker build -t codeballet/multi-client:latest -t codeballet/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t codeballet/multi-server:latest -t codeballet/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t codeballet/multi-worker:latest -t codeballet/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push codeballet/multi-client:latest
docker push codeballet/multi-server:latest
docker push codeballet/multi-worker:latest

docker push codeballet/multi-client:$SHA
docker push codeballet/multi-server:$SHA
docker push codeballet/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=codeballet/multi-server:$SHA
kubectl set image deployment/client-deployment client=codeballet/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=codeballet/multi-worker:$SHA
