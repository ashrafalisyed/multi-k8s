docker build -t ashrafsyed77/multi-client:latest -t ashrafsyed77/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ashrafsyed77/multi-server:latest -t ashrafsyed77/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ashrafsyed77/multi-worker:latest -t ashrafsyed77/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ashrafsyed77/multi-client:latest
docker push ashrafsyed77/multi-server:latest
docker push ashrafsyed77/multi-worker:latest

docker push ashrafsyed77/multi-client:$SHA
docker push ashrafsyed77/multi-server:$SHA
docker push ashrafsyed77/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ashrafsyed77/multi-server:$SHA
kubectl set image deployments/client-deployment client=ashrafsyed77/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ashrafsyed77/multi-worker:$SHA