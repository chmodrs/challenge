# Node Challenge

* Pré-requisitos: Ubuntu 16.04 LTS

Entre no diretório /root e faça o download do repositório git.

```
git clone https://github.com/chmodrs/challenge.git
```

Entre no diretório "challenge" e execute o script "01-prepare-machine.sh"

Esse script irá atualizar todo o Sistema Operacional, compilar o pacote do nodejs, instalar o pm2 e
criar o usuário que irá fazer o deploy através do pm2.

Após isso a aplicação já estará pronta para ser executada.

O app.js é nossa aplicação node, ela sendo executada diretamente não utiliza o conceito de 
clusterização, para corrigir isso criamos o cluster.js, que executa a aplicação clusterizada de 
acordo com o número de processadores na máquina.

O package.json contém todas nossas dependencias que a aplicação necessita, no nosso caso a biblioteca
express.

Utilizamos o PM2 para fazer o deploy e rollback seguro das nossas aplicações. É uma ferramenta poderosa, que é possível além de deploy, criar load balancer, scripts de inicialização, etc...

O PM2 utiliza um arquivo de configuração, onde definimos alguns steps, como deploy, rollback, etc. No noso cas estamos utilizando o arquivo "ecosystem.config.js"

No ecosystem.config.js definimos um repositório git onde estará nossa aplicação, após fazer a sincronização remota, como no exemplo abaixo:

```
git pull https://github.com/chmodrs/challenge.git
git push -u origin -all
```

Após isso basta executar a aplicação com os comandos

```
pm2 deploy ecosystem.config.js production setup
pm2 deploy ecosystem.config.js production
```

Se precisar parar a aplicação

```
pm2 stop ecosystem.config.js
```

Com o pm2, nossa aplicação estará rodando na porta 3000, pensando em facilitar isso vamos criar um proxy
reverso utilizando o nginx, redirecionando as requisições da porta 3000 para a porta 80. Em nosso cluster, por mais processadores que existam na máquina, todas instâncias criadas pelo node irão rodar na porta 3000, não havendo necessidade de utilizar um service discovery com o nginx para criar o load balancer.

* Para instalar e configurar o proxy reverso execute o script "02-nginx-confg.sh"

O script irá fazer a configuração do proxy reverso, encaminhando todas requisições da porta 80 para a porta 3000 do node, e após isso fazer um reload no serviço do nginx. Após a execução do script, sua aplicação node já poderá ser acessível através do NGINX.

## NGINX Stress Test

Para testarmos a capacidade de nosso servidor, vamos utilizar um script que utiliza o AB (apache benchmark) para simular algumas conexões e stress do nosso web server.

Esse script pode ser facilmente editado para realidade do seu servidor, mas nele já está alguns dos testes de acesso mais próximos da realidade de pequenos sites, e aumentando para grandes cargas de acesso.

Para rodar o Benchmark

```
./03-stress-nginx.sh
```

## NGINX Report

Para garantir a estabilidade e disponibilidade do nosso webserver, vamos adicionar um script que irá ler as requisições recebidas pelo NGINX e irá enviar um e-mail no final do dia com o conteúdo das mesmas. Esse script vai basicamente ler as requisições 4xx e 5xx no log do NGINX e nos enviar de forma legível.

Para agendar esse script para vir a ser um relatório diário, vamos adicionar uma entrada no crontab da seguinte forma

```
0 23 * * * /etc/init.d/04-nginx-report.sh >/dev/null 2>&1
```

Ou seja, vamos pegar o script  04-nginx-report.sh e copiar para o diretório /etc/init.d/, dar permissão de execução. Depois precisamos editar a variável "MAIL" adicionando o e-mail que queremos receber o relatório, e pronto!

Lembrando que esse script já leva em consideração que você está com seu sendmail configurado.
