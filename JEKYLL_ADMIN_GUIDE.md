# Jekyll Admin 사용 가이드

## 개요
Jekyll Admin은 Jekyll 사이트를 위한 전통적인 CMS 스타일의 그래픽 인터페이스를 제공하는 플러그인입니다. 웹 브라우저를 통해 콘텐츠를 쉽게 작성하고 관리할 수 있습니다.

## 설치 완료 ✅
- ✅ **jekyll-admin gem 설치됨**
- ✅ **_config.yml 설정 완료**
- ✅ **Jekyll 서버 실행 중**

## 접속 방법

### 로컬 개발 환경
```
http://localhost:4000/admin
```

### 배포된 사이트
```
https://dirtyboots95.github.io/admin
```

## 주요 기능

### 1. 콘텐츠 관리
- **Posts**: 블로그 포스트 작성 및 편집
- **Pages**: 정적 페이지 관리
- **Collections**: 컬렉션별 콘텐츠 관리
  - **Journal**: 일기
  - **Book**: 독서 리뷰
  - **Movie**: 영화 리뷰
  - **Gallery**: 갤러리

### 2. 파일 관리
- **Static Files**: 이미지, CSS, JS 등 정적 파일 관리 ✅ **활성화됨**
- **Data Files**: YAML 데이터 파일 관리 (숨김)

### 3. 사이트 설정
- **Configuration**: _config.yml 파일 편집
- **Drafts**: 초안 관리

## 사용법

### 새 포스트 작성
1. **Admin 페이지 접속**
2. **좌측 메뉴에서 "Posts" 클릭**
3. **"New Post" 버튼 클릭**
4. **제목, 내용, 메타데이터 입력**
5. **"Save" 버튼으로 저장**

### 컬렉션 콘텐츠 작성
1. **좌측 메뉴에서 원하는 컬렉션 선택**
   - **Journal**: 일기 작성
   - **Book**: 독서 리뷰 작성
   - **Movie**: 영화 리뷰 작성
   - **Gallery**: 갤러리 아이템 추가
2. **"New [Collection Name]" 버튼 클릭**
3. **필요한 필드 입력**
   - **Title**: 제목 입력 시 자동으로 파일명 생성 (Makefile 규칙과 동일)
   - **Path**: 수동으로 지정하거나 Title에서 자동 생성
4. **저장**

### 제목 → 파일명 변환 규칙
- **한글, 영문, 숫자, 공백, 하이픈만 허용**
- **공백을 하이픈(-)으로 변환**
- **연속된 하이픈을 하나로 변환**
- **앞뒤 하이픈 제거**

**예시:**
- **Journal**: `"오늘의 맛있는 점심!"` → `"오늘의-맛있는-점심"`
- **Book**: `"Book Review: The Great Gatsby"` → `"book-review-the-great-gatsby"`
- **Movie**: `"영화 리뷰: 어벤져스"` → `"영화-리뷰-어벤져스"`

### 이미지 업로드
1. **좌측 메뉴에서 "Static Files" 클릭**
2. **"Upload Files" 버튼 클릭**
3. **이미지 파일 선택 및 업로드**
4. **이미지는 `assets/images/` 폴더에 자동 저장됨**
5. **업로드된 이미지 URL을 포스트에서 사용**

## 설정 옵션

### 현재 설정
```yaml
jekyll_admin:
  hidden_links:
    - staticfiles      # 정적 파일 관리 숨김
    - datafiles        # 데이터 파일 관리 숨김
    - configuration    # 설정 파일 편집 숨김
  homepage: "posts"    # 홈페이지를 Posts로 설정
```

### 추가 설정 옵션

#### 컬렉션 라벨 커스터마이징
```yaml
collections:
  posts:
    output: true
    sidebar_label: "블로그"  # 사이드바에 "블로그"로 표시
  journal:
    output: true
    sidebar_label: "일기"   # 사이드바에 "일기"로 표시
```

#### 더 많은 링크 숨기기
```yaml
jekyll_admin:
  hidden_links:
    - posts
    - pages
    - staticfiles
    - datafiles
    - configuration
    - drafts
```

## 장점

### 1. 사용자 친화적
- ✅ **직관적인 웹 인터페이스**
- ✅ **마크다운 에디터 내장**
- ✅ **실시간 미리보기**

### 2. 완전한 통합
- ✅ **Jekyll과 완벽 호환**
- ✅ **기존 파일 구조 유지**
- ✅ **Git과 연동 가능**

### 3. 안정성
- ✅ **Jekyll 공식 플러그인**
- ✅ **활발한 개발 및 유지보수**
- ✅ **광범위한 사용자 기반**

## 보안 고려사항

### 현재 설정 (개발 환경에서만 활성화)
```yaml
# 개발 환경에서만 Jekyll Admin 활성화
{% if jekyll.environment == "development" %}
jekyll_admin:
  hidden_links:
    - datafiles      # 데이터 파일 관리 숨김
    - configuration  # 설정 파일 편집 숨김
  whitelist: []      # 개발 환경: 모든 IP 허용
  static_files:
    upload_dir: "assets/images"  # 이미지 업로드 경로
  collections:
    journal:
      # 제목을 파일명으로 자동 변환 (Makefile과 동일한 규칙)
      slug: "{{ title | slugify: 'default' | replace: ' ', '-' | replace: '--', '-' }}"
    book:
      # 제목을 파일명으로 자동 변환 (Makefile과 동일한 규칙)
      slug: "{{ title | slugify: 'default' | replace: ' ', '-' | replace: '--', '-' }}"
    movie:
      # 제목을 파일명으로 자동 변환 (Makefile과 동일한 규칙)
      slug: "{{ title | slugify: 'default' | replace: ' ', '-' | replace: '--', '-' }}"
{% endif %}
```

### 🔒 보안 설정 완료!
- ✅ **기본값**: 프로덕션 환경에서 Jekyll Admin 완전 비활성화
- ✅ **개발 환경에서만 Admin 인터페이스 접근 가능**
- ✅ **배포 시 누구도 `/admin`에 접근할 수 없음**

### 환경별 동작:
- **개발 환경** (`JEKYLL_ENV=development`): Admin 인터페이스 활성화
- **프로덕션 환경** (`JEKYLL_ENV=production`): Admin 인터페이스 비활성화 (기본값)

### 프로덕션에서 Admin 사용하려면?
Jekyll Admin은 **기본적으로 인증 시스템이 없어서** 보안이 취약합니다. 하지만 다음 방법들로 안전하게 사용할 수 있습니다:

#### 1. IP 주소 제한 (가장 간단)
```yaml
# _config.yml에서 프로덕션 Admin 활성화
jekyll_admin:
  whitelist: ["127.0.0.1", "::1", "YOUR_IP_ADDRESS"]  # 허용할 IP만 지정
```

#### 2. 웹 서버 기본 인증 (더 안전)
**Nginx 설정:**
```nginx
location /admin {
    auth_basic "Admin Access";
    auth_basic_user_file /etc/nginx/.htpasswd;
    # Jekyll Admin 설정...
}
```

**Apache 설정:**
```apache
<Directory "/path/to/your/site/admin">
    AuthType Basic
    AuthName "Admin Access"
    AuthUserFile /etc/apache2/.htpasswd
    Require valid-user
</Directory>
```

#### 3. VPN/SSH 터널링 (가장 안전)
- 내부 네트워크에서만 Admin 접근 허용
- 외부에서는 VPN이나 SSH 터널을 통해 접근

### 프로덕션 Admin 활성화 방법:
1. **_config.yml에서 주석 해제:**
```yaml
# 프로덕션 환경에서도 Admin 사용
jekyll_admin:
  whitelist: ["YOUR_IP_ADDRESS"]  # 본인 IP만 허용
```

2. **추가 보안 설정 적용** (위의 방법 중 선택)

### 배포 시 주의사항
- **GitHub Pages**: 자동으로 프로덕션 환경으로 빌드됨 (Admin 비활성화)
- **Netlify/Vercel**: 환경 변수로 `JEKYLL_ENV=production` 설정
- **로컬 개발**: `JEKYLL_ENV=development`로 실행하여 Admin 사용

### GitHub Pages
- **GitHub Pages에서는 Jekyll Admin이 자동으로 비활성화됨**
- **로컬에서만 사용 가능**

### 환경 변수 설정
```bash
# 개발 환경에서 실행
JEKYLL_ENV=development bundle exec jekyll serve

# 또는
export JEKYLL_ENV=development
bundle exec jekyll serve
```

## 문제 해결

### Admin 페이지에 접속할 수 없는 경우
1. **Jekyll 서버가 실행 중인지 확인**
2. **올바른 URL 사용**: `http://localhost:4000/admin`
3. **브라우저 캐시 삭제**

### 플러그인이 로드되지 않는 경우
1. **bundle install 실행**
2. **Jekyll 서버 재시작**
3. **Gemfile에 jekyll-admin이 올바르게 추가되었는지 확인**

### 권한 오류
1. **파일 쓰기 권한 확인**
2. **Jekyll 서버를 올바른 사용자로 실행**

## 추가 정보

### 공식 문서
- [Jekyll Admin GitHub](https://github.com/jekyll/jekyll-admin)
- [Jekyll Admin 공식 사이트](https://jekyll.github.io/jekyll-admin/)

### 지원되는 기능
- **마크다운 에디터**
- **이미지 업로드**
- **파일 관리**
- **메타데이터 편집**
- **드래그 앤 드롭**

## 결론
Jekyll Admin은 Jekyll 사이트를 위한 강력하고 사용하기 쉬운 CMS 인터페이스를 제공합니다. 로컬 개발 환경에서 콘텐츠를 쉽게 작성하고 관리할 수 있어 개발 효율성을 크게 향상시킵니다.
