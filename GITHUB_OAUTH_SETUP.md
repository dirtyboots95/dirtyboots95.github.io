# GitHub OAuth 앱 설정 가이드

## 1단계: GitHub OAuth 앱 생성

### GitHub에서 OAuth 앱 생성
1. **GitHub에 로그인**
2. **우측 상단 프로필 아이콘** → **Settings**
3. **좌측 메뉴** → **Developer settings**
4. **OAuth Apps** → **New OAuth App**

### OAuth 앱 정보 입력
```
Application name: dirtyboots95.github.io CMS
Homepage URL: https://dirtyboots95.github.io
Application description: Decap CMS for dirtyboots95.github.io
Authorization callback URL: https://dirtyboots95.github.io/admin/
```

### 중요 사항
- **Authorization callback URL**은 정확히 `https://dirtyboots95.github.io/admin/`이어야 합니다
- URL 끝에 슬래시(`/`) 포함 필수

## 2단계: Client ID와 Secret 복사

### OAuth 앱 생성 후
1. **Client ID** 복사 (공개 정보)
2. **"Generate a new client secret"** 클릭
3. **Client Secret** 복사 (비공개 정보, 한 번만 표시됨)

## 3단계: config.yml 설정

### admin/config.yml 파일 수정
```yaml
backend:
  name: github
  repo: dirtyboots95/dirtyboots95.github.io
  branch: gh-pages
  client_id: "YOUR_ACTUAL_CLIENT_ID"  # 실제 Client ID로 변경
  base_url: "https://api.github.com"
  auth_endpoint: "https://github.com/login/oauth/authorize"
  auth_scope: "repo"
```

### 설정 예시
```yaml
backend:
  name: github
  repo: dirtyboots95/dirtyboots95.github.io
  branch: gh-pages
  client_id: "Ov23liABC123def456"  # 실제 값으로 변경
  base_url: "https://api.github.com"
  auth_endpoint: "https://github.com/login/oauth/authorize"
  auth_scope: "repo"
```

## 4단계: 배포 및 테스트

### 변경사항 커밋 및 푸시
```bash
git add .
git commit -m "Add GitHub OAuth configuration"
git push origin feature/add-admin
```

### 테스트
1. **https://dirtyboots95.github.io/admin/** 접속
2. **"Login with GitHub"** 클릭
3. **GitHub 계정으로 로그인**
4. **저장소 권한 승인**

## 5단계: 문제 해결

### 일반적인 문제들

#### 1. "Not found" 에러
- **Authorization callback URL** 확인
- 정확히 `https://dirtyboots95.github.io/admin/`인지 확인

#### 2. 권한 에러
- GitHub 계정이 저장소에 대한 쓰기 권한이 있는지 확인
- OAuth 앱이 올바른 저장소에 접근 권한이 있는지 확인

#### 3. 브랜치 에러
- `gh-pages` 브랜치가 존재하는지 확인
- 올바른 브랜치명인지 확인

### 디버깅 팁
1. **브라우저 개발자 도구**에서 네트워크 탭 확인
2. **콘솔**에서 에러 메시지 확인
3. **GitHub OAuth 앱 설정** 재확인

## 보안 주의사항

### Client Secret 보안
- **Client Secret은 절대 공개하지 마세요**
- **GitHub 저장소에 직접 커밋하지 마세요**
- **환경 변수나 별도 설정 파일 사용 권장**

### 대안: 환경 변수 사용
```yaml
backend:
  name: github
  repo: dirtyboots95/dirtyboots95.github.io
  branch: gh-pages
  client_id: ${GITHUB_CLIENT_ID}
  # Client Secret은 프론트엔드에서 사용하지 않음
```

## 완료 후 사용법

### CMS 접속
1. **https://dirtyboots95.github.io/admin/** 접속
2. **GitHub 계정으로 로그인**
3. **콘텐츠 작성 및 관리**

### 사용 가능한 컬렉션
- **일기** - `_posts/journal/`
- **독서** - `_posts/book/`
- **영화** - `_posts/movie/`
- **갤러리** - `_gallery/`
- **초안** - `_posts/draft/`

## 추가 정보

### GitHub OAuth 앱 관리
- **Settings** → **Developer settings** → **OAuth Apps**에서 관리
- **Client Secret 재생성** 가능
- **권한 범위 수정** 가능

### Decap CMS 문서
- [공식 문서](https://decapcms.org/docs/)
- [GitHub 백엔드 설정](https://decapcms.org/docs/backend-github/)
- [OAuth 설정](https://decapcms.org/docs/backend-github/#authentication)
