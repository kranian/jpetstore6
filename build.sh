#!/usr/bin/bash
docker login -u 아이디 -p 패스워드
docker build -t 계정아이디/jpetstore:1.0.0 -f ./src/Dockerfile --build-arg WAR_FILE=jpetstore  .
docker push 계정아이디/jpetstore:1.0.0
docker logout