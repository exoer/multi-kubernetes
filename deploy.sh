docker build -t arnejenssen/multi-client:latest -t arnejenssen/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t arnejenssen/multi-server:latest -t arnejenssen/multi-server:$SHA -f ./server/Dockerfile ./servver
docker build -t arnejenssen/multi-worker:latest -t arnejenssen/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push arnejenssen/multi-client:latest
docker push arnejenssen/multi-server:latest
docker push arnejenssen/multi-worker:latest
docker push arnejenssen/multi-client:$SHA
docker push arnejenssen/multi-server:$SHA
docker push arnejenssen/multi-worker:$SHA

kubectl apply -f k8s
#tag image with version
kubectl set image deployments/server-deployment server=arnejenssen/multi-server:$SHA
kubectl set image deployments/client-deployment client=arnejenssen/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=arnejenssen/multi-worker$SHA
