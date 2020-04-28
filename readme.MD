# Netmiko Demo

I created a container that has all the necessary dependancies for this demo:
```
docker pull jshively/ubuntu-network-dev:latest
```

Clone down the repo:
```
git clone https://github.com/jshively37/netmiko-presentation.git
```

Change into the directory:
```
cd netmiko-presentation
```

Run the container:
```
docker run -it -p 8888:8888 -v $PWD:/development jshively/ubuntu-network-dev:latest
```

Once in the container start juypter notebook:
```
jupyter notebook --ip=0.0.0.0 --allow-root &
```

From your machine access the http://127.0.0.1 string that appears on the screen.

