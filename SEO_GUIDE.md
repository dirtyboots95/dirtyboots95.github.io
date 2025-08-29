# SEO 설정 가이드

## 완료된 SEO 설정

### 1. 메타 태그 최적화
- ✅ 페이지별 제목 태그 (Title Tag)
- ✅ 메타 설명 (Meta Description)
- ✅ 키워드 태그 (Keywords)
- ✅ 저자 정보 (Author)
- ✅ 캐노니컬 URL (Canonical URL)

### 2. Open Graph 태그 (소셜 미디어)
- ✅ og:title
- ✅ og:description
- ✅ og:type
- ✅ og:url
- ✅ og:site_name
- ✅ og:image

### 3. Twitter Card 태그
- ✅ twitter:card
- ✅ twitter:title
- ✅ twitter:description
- ✅ twitter:image

### 4. 구조화된 데이터 (JSON-LD)
- ✅ Schema.org BlogPosting/WebSite 마크업
- ✅ 저자 및 출판사 정보
- ✅ 게시일 및 수정일 정보

### 5. 검색엔진 최적화 파일
- ✅ sitemap.xml
- ✅ robots.txt
- ✅ RSS 피드 링크

## 추가 설정이 필요한 항목

### 1. Google Search Console 설정
1. [Google Search Console](https://search.google.com/search-console)에 접속
2. 사이트 등록: `https://dirtyboots95.github.io`
3. HTML 태그 방식으로 인증 코드 확인
4. `_config.yml`의 `google_site_verification`에 코드 입력

### 2. Naver Search Advisor 설정
1. [Naver Search Advisor](https://searchadvisor.naver.com/)에 접속
2. 사이트 등록: `https://dirtyboots95.github.io`
3. HTML 태그 방식으로 인증 코드 확인
4. `_config.yml`의 `naver_site_verification`에 코드 입력

### 3. Google Analytics 설정
1. [Google Analytics](https://analytics.google.com/)에서 계정 생성
2. 측정 ID 확인 (G-XXXXXXXXXX 형식)
3. `_config.yml`의 `google_analytics`에 ID 입력

### 4. OG 이미지 설정
- 기본 OG 이미지 파일을 `assets/images/og-image.jpg`에 추가
- 권장 크기: 1200x630px
- 파일 크기: 1MB 이하

## 포스트 작성 시 SEO 최적화 팁

### 1. Front Matter에 추가할 수 있는 SEO 필드
```yaml
---
title: "포스트 제목"
description: "포스트에 대한 간단한 설명 (150자 이내)"
keywords: ["키워드1", "키워드2", "키워드3"]
image: "/assets/images/post-image.jpg"
last_modified_at: 2024-01-01
---
```

### 2. 제목 최적화
- 제목 길이: 50-60자 이내
- 주요 키워드를 앞쪽에 배치
- 명확하고 구체적인 제목 사용

### 3. 내용 최적화
- H1, H2, H3 태그를 적절히 사용
- 키워드를 자연스럽게 포함
- 이미지에 alt 텍스트 추가
- 내부 링크 및 외부 링크 활용

## 검색엔진 제출

### 1. Google Search Console
- sitemap.xml 제출: `https://dirtyboots95.github.io/sitemap.xml`
- URL 검사 도구로 개별 페이지 확인

### 2. Naver Search Advisor
- 사이트맵 제출: `https://dirtyboots95.github.io/sitemap.xml`
- URL 등록으로 개별 페이지 등록

## 모니터링

### 1. Google Search Console
- 검색 성능 확인
- 색인 생성 상태 모니터링
- 모바일 사용성 확인

### 2. Naver Search Advisor
- 색인 생성 현황 확인
- 검색 노출 현황 모니터링

## 추가 권장사항

1. **페이지 로딩 속도 최적화**
   - 이미지 압축
   - CSS/JS 파일 최소화

2. **모바일 최적화**
   - 반응형 디자인 확인
   - 터치 친화적 인터페이스

3. **보안 설정**
   - HTTPS 사용 확인
   - 보안 헤더 설정

4. **정기적인 콘텐츠 업데이트**
   - 새로운 포스트 작성
   - 기존 콘텐츠 업데이트
