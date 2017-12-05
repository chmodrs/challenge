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

O script irá fazer a configuração do proxy reverso, encaminhando todas requisições da porta 80 para a porta 3000 do node, e após isso fazer um reload no serviço do nginx.

