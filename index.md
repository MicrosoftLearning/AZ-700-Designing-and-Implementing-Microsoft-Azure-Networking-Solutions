---
title: Online Hosted Instructions
permalink: index.html
layout: home
---

# Content Directory

Required exercise files can be [DOWNLOADED HERE](https://github.com/MicrosoftLearning/AZ-700-Designing-and-Implementing-Microsoft-Azure-Networking-Solutions/archive/master.zip)

Scroll down for demonstrations. 

## Exercise

{% assign Exercise = site.pages | where_exp:"page", "page.url contains '/Instructions/Exercises'" %}
| Module | Exercise |
| --- | --- | 
{% for activity in Exercise %}| {{ activity.Exercise.module }} | [{{ activity.Exercise.title }}{% if activity.Exercise.type %} - {{ activity.Exercise.type }}{% endif %}]({{ site.github.url }}{{ activity.url }}) |
{% endfor %}

<!-- ## Demonstrations (under construction)

{% assign demos = site.pages | where_exp:"page", "page.url contains '/Instructions/Demos'" %}
| Demonstration |
| --- | 
{% for activity in demos  %}| [{{ activity.demo.title }}]({{ site.github.url }}{{ activity.url }}) |
{% endfor %}
-->


