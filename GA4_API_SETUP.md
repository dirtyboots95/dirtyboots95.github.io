# Google Analytics 4 API 설정 및 배포 가이드

## 📊 개요
이 가이드는 Jekyll 블로그에서 Google Analytics 4 Data API를 사용하여 방문자 통계를 표시하는 방법을 설명합니다.

## 🚀 로컬 테스트

### 1. Jekyll 서버 실행
```bash
# 의존성 설치
bundle install

# 로컬 서버 실행
make serve
```

### 2. 방문자 카운터 확인
- 브라우저에서 `http://localhost:4000` 접속
- 홈페이지에 방문자 카운터가 표시됨
- 로컬 환경에서는 테스트 데이터가 표시됨

## 🌐 GitHub Pages 배포

### 옵션 1: Netlify 배포 (권장)

#### 1. Netlify 계정 설정
- [Netlify](https://netlify.com)에 가입
- GitHub 저장소 연결

#### 2. 환경 변수 설정
Netlify 대시보드 → Site settings → Environment variables에서 설정:

```
GOOGLE_APPLICATION_CREDENTIALS=google-credentials.json
GA4_PROPERTY_ID=503083435
```

#### 3. Google Analytics 서비스 계정 설정
1. [Google Cloud Console](https://console.cloud.google.com)에서 프로젝트 생성
2. Google Analytics Data API v1 활성화
3. 서비스 계정 생성 및 키 파일 다운로드
4. `google-credentials.json` 파일을 프로젝트 루트에 업로드

#### 4. 배포
```bash
git add .
git commit -m "Add Netlify Functions for GA4 API"
git push origin main
```

### 옵션 2: Vercel 배포

#### 1. Vercel 계정 설정
- [Vercel](https://vercel.com)에 가입
- GitHub 저장소 연결

#### 2. 환경 변수 설정
Vercel 대시보드 → Project Settings → Environment Variables에서 설정:

```
GOOGLE_APPLICATION_CREDENTIALS=google-credentials.json
GA4_PROPERTY_ID=503083435
```

#### 3. 배포
```bash
git add .
git commit -m "Add Vercel Functions for GA4 API"
git push origin main
```

## 🔧 Google Analytics 4 설정

### 1. GA4 속성 정보 확인
- Measurement ID: `G-H9LCES4944`
- Property ID: `503083435`
- Stream ID: `12092786575`

### 2. API 권한 설정
1. Google Analytics 계정에서 관리자 권한 확인
2. Google Cloud Console에서 서비스 계정에 GA4 데이터 읽기 권한 부여
3. GA4 속성에서 서비스 계정 이메일 추가

## 📁 파일 구조

```
dirtyboots95.github.io/
├── _includes/
│   └── visitor_counter.html      # 방문자 카운터 컴포넌트
├── api/
│   └── ga4-analytics.js         # Vercel Functions용 API
├── netlify/
│   └── functions/
│       ├── ga4-analytics.js     # Netlify Functions용 API
│       └── package.json         # 의존성 정의
├── _sass/
│   └── no-style-please.scss     # 방문자 카운터 스타일
├── netlify.toml                 # Netlify 설정
├── vercel.json                  # Vercel 설정
└── _config.yml                  # Jekyll 설정
```

## 🎨 방문자 카운터 스타일

방문자 카운터는 다음과 같은 특징을 가집니다:
- 그라데이션 배경 (라이트/다크 테마 지원)
- 호버 효과 (그림자 및 변형)
- 반응형 디자인
- 테스트 환경 표시

## 🔍 문제 해결

### 1. API 호출 실패
- Google Analytics API 권한 확인
- 서비스 계정 키 파일 경로 확인
- 환경 변수 설정 확인

### 2. CORS 오류
- 서버리스 함수의 CORS 헤더 설정 확인
- API 엔드포인트 경로 확인

### 3. 데이터 로딩 실패
- 브라우저 개발자 도구에서 콘솔 오류 확인
- 네트워크 탭에서 API 응답 확인

## 📈 실제 방문자 데이터 확인

### 1. Google Analytics 대시보드
- [GA4 대시보드](https://analytics.google.com)에서 실시간 데이터 확인
- 방문자 수, 페이지뷰, 사용자 행동 분석

### 2. API 응답 확인
```bash
# API 엔드포인트 테스트
curl "https://your-domain.com/api/ga4-analytics?property_id=503083435"
```

### 3. 로그 확인
- Netlify/Vercel 대시보드에서 함수 실행 로그 확인
- 에러 및 성공 응답 모니터링

## 🚀 성능 최적화

### 1. 캐싱
- 방문자 데이터를 5-10분마다 업데이트
- 불필요한 API 호출 방지

### 2. 에러 처리
- API 실패 시 폴백 데이터 표시
- 사용자 친화적인 에러 메시지

### 3. 로딩 상태
- 데이터 로딩 중 스피너 표시
- 점진적 향상 (Progressive Enhancement)

## 📚 추가 리소스

- [Google Analytics Data API v1 문서](https://developers.google.com/analytics/devguides/reporting/data/v1)
- [Netlify Functions 문서](https://docs.netlify.com/functions/overview/)
- [Vercel Functions 문서](https://vercel.com/docs/functions)
- [Jekyll 공식 문서](https://jekyllrb.com/docs/)

## 🤝 지원

문제가 발생하거나 추가 도움이 필요한 경우:
1. GitHub Issues에 문제 보고
2. 프로젝트 문서 확인
3. Google Analytics 및 배포 플랫폼 공식 문서 참조
