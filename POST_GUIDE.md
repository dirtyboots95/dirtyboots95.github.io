# 📝 게시물 작성 가이드

## 🚀 빠른 시작

### 1. Makefile 사용 (추천)

```bash
# 대화형으로 새 게시물 생성
make new-post

# 특정 카테고리로 바로 생성
make new-journal
make new-book
make new-movie
```

### 2. Ruby 스크립트 사용

```bash
# 스크립트 실행 권한 부여
chmod +x create_post.rb

# 스크립트 실행
ruby create_post.rb
```

### 3. 템플릿 파일 복사

```bash
# Journal 게시물
cp _templates/journal_template.md _posts/journal/$(date +%Y-%m-%d)-새-게시물.md

# Book 리뷰
cp _templates/book_template.md _posts/book/$(date +%Y-%m-%d)-새-책-리뷰.md

# Movie 리뷰
cp _templates/movie_template.md _posts/movie/$(date +%Y-%m-%d)-새-영화-리뷰.md
```

## 📋 게시물 작성 단계

### 1. 파일명 규칙
- 형식: `YYYY-MM-DD-제목.md`
- 예시: `2024-01-15-새로운-게시물.md`

### 2. Front Matter 필수 항목
```yaml
---
layout: post
title: "게시물 제목"
date: 2024-01-15 10:00:00 +0900
category: journal  # 또는 book, movie
comments: true     # 댓글 활성화 (선택사항)
---
```

### 3. 내용 작성
- Markdown 형식 사용
- 이미지는 `assets/images/` 폴더에 저장
- 코드 블록은 ``` 사용

## 🎨 템플릿 활용

### Journal 템플릿
- 일상 기록용 구조
- 주요 내용과 느낀 점 정리

### Book 템플릿
- 책 정보, 평점, 줄거리
- 인상 깊은 구절과 추천 대상

### Movie 템플릿
- 영화 정보, 평점, 줄거리
- 연기, 영상미, 음악 평가

## 🔧 개발 서버 실행

```bash
# 개발 서버 시작 (자동 새로고침)
make serve

# 또는
bundle exec jekyll serve --livereload
```

## 📁 파일 구조

```
_posts/
├── journal/          # 일상 기록
├── book/            # 책 리뷰
└── movie/           # 영화 리뷰

_templates/          # 템플릿 파일들
├── journal_template.md
├── book_template.md
└── movie_template.md
```

## 💡 팁

1. **미리보기**: `make serve`로 실시간 미리보기
2. **템플릿 활용**: 각 카테고리별 템플릿 사용
3. **이미지**: `assets/images/` 폴더에 저장 후 참조
4. **태그**: 필요시 `tags: [태그1, 태그2]` 추가
5. **초안**: `published: false`로 초안 상태 유지

## 🚨 주의사항

- 파일명에 한글 사용 금지
- 날짜 형식은 `YYYY-MM-DD` 준수
- 카테고리는 정확히 입력 (journal, book, movie)
- Front Matter의 YAML 문법 준수
