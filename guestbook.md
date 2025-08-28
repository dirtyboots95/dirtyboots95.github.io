---
layout: default
title: Guestbook
comments: true
---

{%- include site_header.html -%}

<p>{%- include back_link.html -%}</p>

<h1>{{ page.title }}</h1>

<p>이름과 이메일을 입력하고 방명록을 남겨주세요. (이메일은 공개되지 않습니다)</p>

{%- include disqus_comments.html -%}