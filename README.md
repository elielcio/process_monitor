## Script de Monitoramento de Processos
Este é um script shell para monitorar a execução de processos no sistema Linux. Ele pode ser usado para monitorar qualquer processo em execução e encerrá-lo se estiver em execução por mais tempo do que o limite especificado.

### Instalação
Para instalar o script, baixe o arquivo process_monitor.sh e salve-o na pasta /usr/local/scripts/process_monitor.

Certifique-se de que o arquivo tenha permissão de execução, usando o seguinte comando:

sudo chmod +x /usr/local/scripts/process_monitor/process_monitor.sh

### Dependências / Pré-requisitos
Para executar este script, é necessário ter as seguintes dependências instaladas:
bash
pgrep
ps
bc
awk

#### Instalação das dependências no Debian 9
sudo apt-get update
sudo apt-get install bash procps bc gawk

#### Instalação das dependências no CentOS
sudo yum update
sudo yum install bash procps-ng bc gawk

### Utilização
Para executar o script, abra o terminal e navegue até a pasta /usr/local/scripts/process_monitor. Em seguida, execute o seguinte comando:

sudo ./process_monitor.sh [nome_do_processo] [tempo_maximo_de_execucao] [-l]

Onde:

nome_do_processo: o nome do processo a ser monitorado, por exemplo, mariadbd ou httpd.
tempo_maximo_de_execucao: o tempo máximo de execução em segundos. Se não for especificado, será definido como 600 segundos (10 minutos).
-l (opcional): se usado, o script exibirá mensagens echo somente quando o comando for encerrado.

Exemplo

sudo ./process_monitor.sh mariadbd 3600 -l

Este exemplo irá monitorar o processo mariadbd por um tempo máximo de 3600 segundos (1 hora) e exibir mensagens echo apenas quando o processo for encerrado.

### Funcionamento
Ao ser executado, o script verifica se o processo especificado está em execução. Se não estiver, o script exibirá a mensagem "O processo não está em execução" e sairá com código de erro 1.

Se o processo estiver em execução, o script calculará o tempo de execução atual do processo e o comparará com o tempo máximo de execução especificado. Se o tempo de execução for maior do que o tempo máximo especificado, o script encerrará o processo usando o comando kill. Caso contrário, o script exibirá a mensagem "O processo está em execução há menos de [tempo_maximo_de_execucao] segundos".

Se o parâmetro -l for utilizado, o script exibirá uma mensagem somente quando o processo for encerrado.

### Conclusão
Este script é uma ferramenta útil para monitorar processos e garantir que eles não estejam em execução por um tempo excessivo, o que pode causar problemas de desempenho ou até mesmo falhas no sistema. Com a ajuda deste script, é possível automatizar o monitoramento de processos e garantir um melhor desempenho e estabilidade do sistema.

## Autor
Este script foi criado por:
Eli Elcio Skrock Antunes
elielcio@gmail.com
