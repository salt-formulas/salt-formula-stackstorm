{%- from "stackstorm/map.jinja" import server with context %}
{%- if server.enabled %}

stackstorm_packages:
  pkg.installed:
  - names: {{ server.pkgs }}

{{ server.conf_file }}:
  file.managed:
  - source: salt://stackstorm/files/st2.conf
  - template: jinja
  - user: root
  - group: root
  - mode: 644
  - require:
    - pkg: stackstorm_packages

stackstorm_install_database:
  cmd.run:
  - name: '/opt/stackstorm/mistral/bin/mistral-db-manage --config-file /etc/mistral/mistral.conf upgrade head;/opt/stackstorm/mistral/bin/mistral-db-manage --config-file /etc/mistral/mistral.conf populate'

stackstorm_user:
  user.present:
  - name: stackstorm
  - shell: /bin/bash
  - home: {{ server.dir.base }}	

stackstorm_dirs:
  file.directory:
  - names:
    - {{ server.dir.base }}
    - {{ server.dir.base }}/stackstorm/.ssh
  - user: stackstorm
  - group: stackstorm
  - mode: 0700
  - makedirs: true

/home/deployer/.ssh/id_rsa:
  file.managed:
    - user: stackstorm
    - group: stackstorm
    - mode: 600
    - contents_pillar: stackstorm:stackstorm:private_key

stackstorm_service:
  service.running:
  - enable: true
  - name: {{ server.service }}
  - watch:
    - file: {{ server.conf_file }}
  - require:
    - cmd: stackstorm_install_database
    - file: {{ server.conf_file }}

{%- endif %}
