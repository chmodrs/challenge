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


