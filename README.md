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
# vi: set ft=ruby :

machines = {
  "node01" => {"memory" => "1024", "cpu" => "1", "image" => "bento/ubuntu-22.04"},
  "node02" => {"memory" => "1024", "cpu" => "1", "image" => "bento/ubuntu-22.04"},
  "node03" => {"memory" => "1024", "cpu" => "1", "image" => "bento/ubuntu-22.04"},
  "node04" => {"memory" => "1024", "cpu" => "1", "image" => "bento/ubuntu-22.04"}
}

Vagrant.configure("2") do |config|

  machines.each do |name, conf|
    config.vm.define "#{name}" do |machine|
      config.vm.box = "#{conf["image"]}"
      machine.vm.hostname = "#{name}"
      machine.vm.network "public_network"
      machine.vm.provider "virtualbox" do |vb|
        vb.name = "#{name}"
        vb.memory = conf["memory"]
        vb.cpus = conf["cpu"]

      end
      machine.vm.provision "shell", path: "get-docker.sh"
    end
  end
```
Em seguida, em um terminal, execute o seguinte comando:

```
vagrant up
```