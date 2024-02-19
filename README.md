<h1>
    <a href="https://www.dio.me/">
     <img align="center" width="40px" src="https://hermes.digitalinnovation.one/assets/diome/logo-minimized.png"></a>
    <span> Cluster Swarm Local com o Vagrant</span>
</h1>

Repositório desenvolvido para fins educativos.

## Objetivo
Criar um Cluster Swarm local utilizando máquinas virtuais.

## O Vagrantfile

Este é um exemplo simples de Vagrantfile, no entanto, há muitas opções que podem ser incluídas nesse arquivo.

```
# -*- mode: ruby -*-
# vi: set ft=ruby  :

machines = {
  "master" => {"memory" => "1024", "cpu" => "1", "ip" => "100", "image" => "bento/ubuntu-22.04"},
  "node01" => {"memory" => "1024", "cpu" => "1", "ip" => "101", "image" => "bento/ubuntu-22.04"},
  "node02" => {"memory" => "1024", "cpu" => "1", "ip" => "102", "image" => "bento/ubuntu-22.04"},
  "node03" => {"memory" => "1024", "cpu" => "1", "ip" => "103", "image" => "bento/ubuntu-22.04"}
}

Vagrant.configure("2") do |config|

  machines.each do |name, conf|
    config.vm.define "#{name}" do |machine|
      machine.vm.box = "#{conf["image"]}"
      machine.vm.hostname = "#{name}"
      machine.vm.network "public_network", ip: "172.16.10.#{conf["ip"]}"
      machine.vm.provider "virtualbox" do |vb|
        vb.name = "#{name}"
        vb.memory = conf["memory"]
        vb.cpus = conf["cpu"]
        
      end
      machine.vm.provision "shell", path: "get-docker.sh"
      
      if "#{name}" == "master"
        machine.vm.provision "shell", path: "master.sh"
      else
        machine.vm.provision "shell", path: "worker.sh"
      end

    end
  end
end
```
Dependendo da sua configuração, você pode definir manualmente o IP. Para isso adicione `ip:`.

```
machine.vm.network "public_network", ip: "172.16.10.#{conf["ip"]}"
```
Se mais de uma interface de rede estiver disponível na máquina host, o Vagrant solicitará que você escolha qual interface a máquina virtual deve fazer a ponte.

## Executando o script

### Execute a partir de um terminal

A maneira mais simples de usar o script acima é copiar e colar o conteúdo em um arquivo chamado `Vagrantfile`.

Em seguida, em um terminal, execute o seguinte comando:

```
vagrant up
```
