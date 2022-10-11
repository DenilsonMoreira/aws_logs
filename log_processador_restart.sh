#!/bin/bash
nome=$( TZ='America/Sao_Paulo' date +%Y_%m_%d_%H:%M:%S)

POD=$1

echo "Buscando pod:"$POD


QTD=$(kubectl get pods -n processador | grep -v NAME | grep $POD | wc -l)
sleep 1 | echo "." | echo "!!!"
echo $QTD" pod(s)"
sleep 1

if [ $QTD > 0 ]; 
then
    echo "Segue abaixo:"
    echo "---------------------------------------------------------------------------------------------------"
    kubectl get pods -n processador | grep -v NAME | grep $POD 
    echo "---------------------------------------------------------------------------------------------------"
    
    
    mkdir $nome
    echo "Criando pasta "$nome
    cd $nome
    echo "Gerando logs"
    kubectl get pods -n processador | grep -v NAME | grep $POD | awk '{print "kubectl logs -n processador "$1" -p > log_"$1".txt"}' | bash +x
    
    exit
else
    echo "Encerrando por favor verifique o nome do pod pesquisado"
    exit

fi



