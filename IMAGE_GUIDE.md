# 📸 이미지 업로드 및 사용 가이드

## 📁 이미지 폴더 구조

```
assets/images/
├── journal/          # 일상 기록용 이미지
├── books/           # 책 리뷰용 이미지
├── movies/          # 영화 리뷰용 이미지
└── gallery/         # 갤러리용 이미지 (기존)
```

## 🚀 이미지 업로드 방법

### 1. **폴더별 이미지 업로드**

```bash
# Journal 이미지
cp ~/Desktop/오늘사진.jpg assets/images/journal/2024-01-15-오늘사진.jpg

# Book 이미지
cp ~/Desktop/책표지.jpg assets/images/books/책제목-표지.jpg

# Movie 이미지
cp ~/Desktop/영화포스터.jpg assets/images/movies/영화제목-포스터.jpg
```

### 2. **이미지 파일명 규칙**

- **형식**: `YYYY-MM-DD-설명.확장자`
- **예시**: `2024-01-15-카페사진.jpg`
- **주의**: 한글, 공백, 특수문자 사용 금지

## 📝 템플릿에서 이미지 사용법

### Journal 템플릿

```markdown
### 📸 오늘의 사진

![오늘의 사진]({{ site.baseurl }}/assets/images/journal/2024-01-15-카페사진.jpg){: .center-image}

*사진 설명: 오늘 찍은 사진에 대한 설명을 여기에 작성합니다.*
```

### Book 템플릿

```markdown
![책 표지]({{ site.baseurl }}/assets/images/books/책제목-표지.jpg){: .book-cover}

![책 속 페이지]({{ site.baseurl }}/assets/images/books/책제목-페이지.jpg){: .book-page}
```

### Movie 템플릿

```markdown
![영화 포스터]({{ site.baseurl }}/assets/images/movies/영화제목-포스터.jpg){: .movie-poster}

![영화 스틸컷]({{ site.baseurl }}/assets/images/movies/영화제목-스틸컷.jpg){: .movie-still}
```

## 🎨 이미지 스타일 클래스

### 사용 가능한 CSS 클래스

- `.center-image` - 중앙 정렬된 큰 이미지
- `.small-image` - 작은 이미지 (나란히 배치용)
- `.book-cover` - 책 표지 이미지
- `.book-page` - 책 페이지 이미지
- `.movie-poster` - 영화 포스터
- `.movie-still` - 영화 스틸컷

### 여러 이미지 나란히 배치

```markdown
![첫 번째 사진]({{ site.baseurl }}/assets/images/journal/사진1.jpg){: .small-image}
![두 번째 사진]({{ site.baseurl }}/assets/images/journal/사진2.jpg){: .small-image}
![세 번째 사진]({{ site.baseurl }}/assets/images/journal/사진3.jpg){: .small-image}
```

## 📱 이미지 최적화 팁

### 1. **파일 크기**
- 웹용으로 최적화 (1MB 이하 권장)
- JPG: 사진용
- PNG: 투명도가 필요한 경우
- WebP: 최신 브라우저 지원시

### 2. **해상도**
- 데스크톱: 1200px 너비 이하
- 모바일: 800px 너비 이하
- 썸네일: 400px 너비 이하

### 3. **파일명**
- 영문, 숫자, 하이픈만 사용
- 날짜 포함 권장
- 설명적인 이름 사용

## 🔧 이미지 편집 도구

### 온라인 도구
- [TinyPNG](https://tinypng.com/) - 이미지 압축
- [Canva](https://canva.com/) - 이미지 편집
- [Pixlr](https://pixlr.com/) - 온라인 포토샵

### 명령어 도구
```bash
# 이미지 크기 변경 (ImageMagick 필요)
convert 원본.jpg -resize 800x600 새이미지.jpg

# 이미지 압축
convert 원본.jpg -quality 85 압축된이미지.jpg
```

## 🚨 주의사항

### 1. **저작권**
- 자신이 찍은 사진 사용 권장
- 저작권이 있는 이미지 사용시 출처 명시
- 무료 이미지 사이트 활용

### 2. **개인정보**
- 개인정보가 포함된 이미지 업로드 금지
- 얼굴이 포함된 경우 모자이크 처리

### 3. **파일 관리**
- 정기적으로 사용하지 않는 이미지 정리
- 백업 파일 관리

## 📚 무료 이미지 사이트

- [Unsplash](https://unsplash.com/) - 고품질 무료 사진
- [Pexels](https://pexels.com/) - 무료 스톡 사진
- [Pixabay](https://pixabay.com/) - 무료 이미지 및 벡터
- [Freepik](https://freepik.com/) - 무료 벡터 및 일러스트

## 💡 실용적인 팁

1. **일관된 스타일**: 모든 이미지에 동일한 스타일 적용
2. **설명 추가**: 모든 이미지에 alt 텍스트와 설명 추가
3. **로딩 최적화**: 이미지 크기 최적화로 페이지 로딩 속도 향상
4. **백업**: 원본 이미지 파일 백업 보관
