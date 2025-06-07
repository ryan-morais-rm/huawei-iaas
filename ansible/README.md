# Ansible Project

Este repositório contém a estrutura de um projeto **Ansible** organizado para gerenciar ambientes de produção e staging. A estrutura é modular e permite gerenciar configurações de diferentes servidores, como servidores web e servidores de banco de dados, de forma eficiente e reutilizável.

## Estrutura do Projeto

Abaixo está a estrutura principal do repositório:

```plaintext
ansible-project/
│
├── inventory/                  # Inventários de máquinas (hosts)
│   ├── production              # Inventário para o ambiente de produção
│   ├── staging                 # Inventário para o ambiente de staging
│   └── hosts.ini               # Arquivo principal de hosts (pode ser compartilhado)
│
├── roles/                      # Funções (roles) reutilizáveis
│   ├── webserver/              # Função para servidores web
│   └── database/               # Função para servidores de banco de dados
│
├── playbooks/                  # Playbooks Ansible
│   ├── principal.yml                # Playbook principal que inclui outros
│   ├── webservers.yml          # Playbook específico para servidores web
│   └── dbservers.yml           # Playbook específico para servidores DB
│
├── ansible.cfg                 # Arquivo de configuração do Ansible
│
└── README.md                   # Documentação do repositório

