---
layout: post
title: "Markdown 서식 예제"
date: YYYY-MM-DD 10:00:00 +0900
category: example
comments: true
tags: [markdown, example, template]
---

# 제목 1 (H1)

## 제목 2 (H2)

### 제목 3 (H3)

#### 제목 4 (H4)

##### 제목 5 (H5)

###### 제목 6 (H6)

---

## 텍스트 서식

**굵은 텍스트** 또는 __굵은 텍스트__

*기울임 텍스트* 또는 _기울임 텍스트_

***굵고 기울임 텍스트*** 또는 ___굵고 기울임 텍스트___

~~취소선 텍스트~~

<u>밑줄 텍스트</u>

`인라인 코드`

---

## 목록

### 순서가 있는 목록 (Ordered List)

1. 첫 번째 항목
2. 두 번째 항목
3. 세 번째 항목
   - 중첩된 순서 없는 목록
   - 또 다른 중첩 항목
4. 네 번째 항목

### 순서가 없는 목록 (Unordered List)

- 항목 1
- 항목 2
- 항목 3
  - 중첩된 항목
  - 또 다른 중첩 항목
    - 더 깊은 중첩
- 항목 4

### 체크리스트

- [x] 완료된 작업
- [ ] 미완료 작업
- [ ] 또 다른 미완료 작업

---

## 링크와 이미지

### 링크

[Google](https://www.google.com)

[상대 링크 예제](../about.html)

[이메일 링크](mailto:example@email.com)

### 이미지

![이미지 설명]({{ site.baseurl }}/assets/images/placeholder.jpg)

![작은 이미지]({{ site.baseurl }}/assets/images/placeholder.jpg){: .small-image}

![중앙 정렬 이미지]({{ site.baseurl }}/assets/images/placeholder.jpg){: .center-image}

### 유튜브 영상 임베드

#### 기본 유튜브 임베드
<iframe width="560" height="315" src="https://www.youtube.com/embed/dQw4w9WgXcQ" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

#### 반응형 유튜브 임베드 (권장)
<div class="video-container">
<iframe width="560" height="315" src="https://www.youtube.com/embed/dQw4w9WgXcQ" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

#### 유튜브 링크 (자동 임베드)
https://www.youtube.com/watch?v=dQw4w9WgXcQ

#### Jekyll Include 방식 (권장)
{% raw %}{% include youtube.html id="dQw4w9WgXcQ" %}{% endraw %}

#### Jekyll Include 방식 (커스텀 크기)
{% raw %}{% include youtube.html id="dQw4w9WgXcQ" width="480" height="270" %}{% endraw %}

#### 유튜브 쇼츠
<iframe width="315" height="560" src="https://www.youtube.com/embed/dQw4w9WgXcQ" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

#### 스크린샷 + 링크 방식 (권장)
[![유튜브 영상 스크린샷]({{ site.baseurl }}/assets/images/youtube-thumbnail.jpg)](https://www.youtube.com/watch?v=dQw4w9WgXcQ)

#### 스크린샷 + 설명 + 링크
[![유튜브 영상 스크린샷]({{ site.baseurl }}/assets/images/youtube-thumbnail.jpg)](https://www.youtube.com/watch?v=dQw4w9WgXcQ)

**영상 제목**: 예제 영상 제목  
**채널**: 예제 채널  
**재생 시간**: 3:45  
**설명**: 이 영상은 예제용입니다. 클릭하면 유튜브에서 시청할 수 있습니다.

#### 썸네일 + 재생 버튼 스타일
<div class="video-thumbnail">
  <a href="https://www.youtube.com/watch?v=dQw4w9WgXcQ" target="_blank" rel="noopener">
    <img src="{{ site.baseurl }}/assets/images/youtube-thumbnail.jpg" alt="유튜브 영상 썸네일">
    <div class="play-button">▶</div>
  </a>
</div>

### 유튜브 스크린샷 추가 방법

#### 1. 유튜브 썸네일 URL 사용
유튜브 영상 ID를 사용하여 썸네일을 가져올 수 있습니다:

**영상 ID**: `dQw4w9WgXcQ` (URL에서 `v=` 뒤의 부분)

**썸네일 URL 패턴**:
- 최고 품질: `https://img.youtube.com/vi/VIDEO_ID/maxresdefault.jpg`
- 고품질: `https://img.youtube.com/vi/VIDEO_ID/hqdefault.jpg`
- 중간 품질: `https://img.youtube.com/vi/VIDEO_ID/mqdefault.jpg`
- 표준 품질: `https://img.youtube.com/vi/VIDEO_ID/sddefault.jpg`
- 첫 번째 썸네일: `https://img.youtube.com/vi/VIDEO_ID/0.jpg`
- 두 번째 썸네일: `https://img.youtube.com/vi/VIDEO_ID/1.jpg`
- 세 번째 썸네일: `https://img.youtube.com/vi/VIDEO_ID/2.jpg`
- 네 번째 썸네일: `https://img.youtube.com/vi/VIDEO_ID/3.jpg`

#### 2. 실제 사용 예시
```markdown
[![유튜브 썸네일](https://img.youtube.com/vi/dQw4w9WgXcQ/maxresdefault.jpg)](https://www.youtube.com/watch?v=dQw4w9WgXcQ)
```

#### 3. 로컬 저장 방식
1. 유튜브 썸네일을 다운로드
2. `assets/images/` 폴더에 저장
3. 상대 경로로 참조

```markdown
[![유튜브 썸네일]({{ site.baseurl }}/assets/images/youtube-thumbnail.jpg)](https://www.youtube.com/watch?v=dQw4w9WgXcQ)
```

#### 4. 다양한 품질의 썸네일 예시
![최고 품질](https://img.youtube.com/vi/dQw4w9WgXcQ/maxresdefault.jpg)
![고품질](https://img.youtube.com/vi/dQw4w9WgXcQ/hqdefault.jpg)
![중간 품질](https://img.youtube.com/vi/dQw4w9WgXcQ/mqdefault.jpg)

---

## 코드 블록

### 인라인 코드

`console.log('Hello, World!');`

### 코드 블록 (언어 지정)

```javascript
function hello() {
    console.log('Hello, World!');
    return 'Hello';
}
```

```python
def hello():
    print("Hello, World!")
    return "Hello"
```

```html
<!DOCTYPE html>
<html>
<head>
    <title>Example</title>
</head>
<body>
    <h1>Hello, World!</h1>
</body>
</html>
```

```css
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 20px;
}
```

### 코드 블록 (언어 미지정)

```
이것은 언어가 지정되지 않은 코드 블록입니다.
여러 줄의 텍스트를 포함할 수 있습니다.
```

---

## 인용문

> 이것은 인용문입니다.
> 여러 줄로 구성될 수 있습니다.

> 인용문 안에 **굵은 텍스트**나 *기울임 텍스트*를 사용할 수도 있습니다.

---

## 표 (Table)

| 제목 1 | 제목 2 | 제목 3 |
|--------|--------|--------|
| 셀 1   | 셀 2   | 셀 3   |
| 셀 4   | 셀 5   | 셀 6   |

| 왼쪽 정렬 | 가운데 정렬 | 오른쪽 정렬 |
|:---------|:----------:|----------:|
| 왼쪽     | 가운데     | 오른쪽     |
| 텍스트   | 텍스트     | 텍스트     |

---

## 수평선

---

또는

***

또는

___

---

## 이스케이프 문자

\*별표\* \`백틱\` \[대괄호\] \(괄호\) \#샵 \+플러스 \-마이너스 \.점 \!느낌표

---

## HTML 태그 사용

<div style="background-color: #f0f0f0; padding: 10px; border-radius: 5px;">
이것은 HTML div 태그를 사용한 스타일링된 박스입니다.
</div>

<details>
<summary>접을 수 있는 섹션</summary>
이 내용은 접을 수 있습니다.
</details>

---

## 수학 공식 (MathJax 지원 시)

인라인 수식: $E = mc^2$

블록 수식:
$$
\int_{-\infty}^{\infty} e^{-x^2} dx = \sqrt{\pi}
$$

---

## 각주

여기에 각주를 추가할 수 있습니다[^1].

[^1]: 이것은 각주 내용입니다.

---

## 정의 목록 (Definition List)

HTML을 사용해야 합니다:

<dl>
<dt>용어 1</dt>
<dd>용어 1에 대한 정의입니다.</dd>
<dt>용어 2</dt>
<dd>용어 2에 대한 정의입니다. 여러 줄로 구성될 수 있습니다.</dd>
</dl>

---

## 특수 문자

&copy; &trade; &reg; &deg; &plusmn; &times; &divide; &infin; &asymp; &ne; &le; &ge;

---

## 마크다운 확장 기능

### 작업 목록 (Task List)

- [x] 완료된 작업
- [ ] 미완료 작업
- [x] 또 다른 완료된 작업

### 이모지

😀 😃 😄 😁 😆 😅 🤣 😂 🙂 🙃 😉 😊 😇 🥰 😍 🤩 😘 😗 😚 😙

### 하이라이트

==하이라이트된 텍스트==

---

## Jekyll 특수 기능

### 변수 사용

현재 사이트 제목: {{ site.title }}

현재 페이지 제목: {{ page.title }}

### 조건문

{% raw %}
{% if page.category == 'book' %}
이것은 책 카테고리입니다.
{% elsif page.category == 'movie' %}
이것은 영화 카테고리입니다.
{% else %}
이것은 다른 카테고리입니다.
{% endif %}
{% endraw %}

### 반복문

{% raw %}
{% for post in site.posts limit:3 %}
- [{{ post.title }}]({{ post.url }})
{% endfor %}
{% endraw %}

---

## 마무리

이것은 Markdown의 모든 주요 서식을 보여주는 예제 파일입니다. 필요에 따라 이 템플릿을 수정하여 사용하세요.
