docker build -t surendusuresh/multi-client:latest -t surendusuresh/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t surendusuresh/multi-server:latest -t surendusuresh/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t surendusuresh/multi-worker:latest -t surendusuresh/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push surendusuresh/multi-client:latest
docker push surendusuresh/multi-server:latest
docker push surendusuresh/multi-worker:latest

docker push surendusuresh/multi-client:$SHA
docker push surendusuresh/multi-server:$SHA
docker push surendusuresh/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=surendusuresh/multi-server:$SHA
kubectl set image deployments/client-deployment client=surendusuresh/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=surendusuresh/multi-worker:$SHA
