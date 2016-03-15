{%- if pillar.stackstorm is defined %}
include:
{%- if pillar.stackstorm.server is defined %}
- stackstorm.server
{%- endif %}
{%- endif %}
