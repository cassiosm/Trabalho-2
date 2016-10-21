#!/bin/bash



#Mostra o texto "digite o arquivo"
echo "digite o arquivo: "

#deixa um espaço entre a proxima linha
echo "" 

#lê a palavra digita e armazena 
read ARQUIVO

#deixa um espaço entre a proxima linha
echo ""

#Mostra o texto "São mostradas 15 primeiras palavras que mais aparece"
echo "São mostradas 15 primeiras palavras que mais aparece"

#deixa um espaço entre a proxima linha
echo ""

#deixa um espaço entre a proxima linha
echo ""

# o comando cat mostra o conteudo do arquivo
# o comando egrep -o '\w+'quebra o texto em palavras e exclui a pontuação 
# o comando grep ... define o minimo de letras que cada palavra tem que aparecer
# o comando short ordem as linhas
# o comando uniq -c conta quanta vezes cada linha consecutiva aparece
# o comando sort -n -r organiza as linhas texto invertendo o resultado da comparação e inverte a ordem do resultado da comparação
# o comando head mostra somente as primeira N linhas, no caso 15
cat $ARQUIVO | egrep -o '\w+' | grep ... | sort | uniq -c | sort -n -r | head -n 15
